//
//  VacationsDetailsViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 09/09/1439 AH.
//  Copyright © 1439 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class VacationsDetailsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    // -- MARK: IBOutlets
    
    @IBOutlet weak var empPickerView: UITextField!
    @IBOutlet weak var empDropdown: UIImageView!
    @IBOutlet weak var delegatePickerView: UITextField!
    @IBOutlet weak var delegateDropdown: UIImageView!
    @IBOutlet weak var numOfDays: UITextField!
    @IBOutlet weak var balanceVacation: UILabel!
    @IBOutlet weak var leaveStartDatePickerView: UITextField!
    @IBOutlet weak var ReturnDatePickerView: UITextField!
    @IBOutlet weak var vacationTypePickerView: UITextField!
    @IBOutlet weak var vacationTypeDropdown: UIImageView!
    @IBOutlet weak var exitReEntryDays: UITextField!
    @IBOutlet weak var extraDays: UILabel!
    @IBOutlet weak var settlementAmount: UILabel!
    @IBOutlet weak var nextButtonOutlet: UIButton!
    
    @IBOutlet weak var vacationDetailsStackViewWidth: NSLayoutConstraint!
    
    // -- labels
    @IBOutlet weak var vacationDetailsHeader: UILabel!
    @IBOutlet weak var settlementDetailsHeader: UILabel!
    
    @IBOutlet weak var numberOfDaysTitle: UILabel!
    @IBOutlet weak var balanceVacationTitle: UILabel!
    @IBOutlet weak var leaveStartDateTitle: UILabel!
    @IBOutlet weak var returnDateTitle: UILabel!
    @IBOutlet weak var vacationTypeTitle: UILabel!
    @IBOutlet weak var exitTitle: UILabel!
    @IBOutlet weak var extraDaysTitle: UILabel!
    @IBOutlet weak var settlementTitle: UILabel!
    
    
    let leaveDatePickerDatePicker: UIDatePicker = UIDatePicker()
    let returnDatePickerDatePicker: UIDatePicker = UIDatePicker()
    let pickViewEmpName: UIPickerView = UIPickerView()
    let pickViewEmpDelegate: UIPickerView = UIPickerView()
    let vacationTypePickerViewPikcer: UIPickerView = UIPickerView()
    
    var datePickerView: UIDatePicker = UIDatePicker()
    var pickerView: UIPickerView = UIPickerView()
    //static var i: Int = 0
    
    // -- MARK: Variables
    
    let screenSize = AppDelegate().screenSize
    let webservice = Login()
    
    var empVacationDetails = EmpVac()
    var vacationTypeArray = [EmpVac]()
    var empVacArray = [EmpVac]()
    var empDelegateArray = [EmpVac]()
    
    // To store vacation type id
    var vacationTypeId: String = ""
    
    var empNametextChosen: String?
    var empDelegatetextChosen: String?
    var vacationTypetextChosen: String?
    
    var empNameIndex: Int = 0
    var empDelegateIndex: Int = 0
    var vacationTypeIndex: Int = 0
    
    var languangeChosen: Int = LoginViewController.languageChosen
    
    // -- MARK: viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupArrays()
        
        // Change the width of vacation Details Stack View base of the screen size
        vacationDetailsStackViewWidth.constant = screenSize.width - 32
        
        // Changing the back button of the navigation contoller
        setCustomNav(navItem: navigationItem)
        
        leaveStartDatePickerView.tintColor = .clear
        ReturnDatePickerView.tintColor = .clear
        vacationTypePickerView.tintColor = .clear
        empPickerView.tintColor = .clear
        delegatePickerView.tintColor = .clear
        
        setUpPickerView()
        setupDatePicker()
        setupLanguagChange()
        setUpEmployeeDetails()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // -- MARK: Set ups
    
    func setupArrays(){
        if let userId = AuthServices.currentUserId{
            empVacArray = webservice.BindEmpsVacationsDropDown(langid: languangeChosen, Emp_no: userId)
            self.empPickerView.text = empVacArray[0].Emp_Ename
            
            empDelegateArray = webservice.BindDelegateVacationsDropDown(langid: languangeChosen, Emp_no: userId)
            vacationTypeArray = webservice.BindVacationType_DDL(langid: languangeChosen)
            self.vacationTypePickerView.text = vacationTypeArray[2].Vac_Desc
            
            empVacationDetails = webservice.GetEmpVacationDetails(langid: languangeChosen, Emp_no: userId)
        }
    }
    
    func setUpEmployeeDetails(){
        numOfDays.text = empVacationDetails.Number_Days
        balanceVacation.text = empVacationDetails.Balance_Vacation
        leaveStartDatePickerView.text = empVacationDetails.Leave_Start_Dt
        ReturnDatePickerView.text = empVacationDetails.Leave_Return_Dt
        exitReEntryDays.text = empVacationDetails.ExitReEntry
        
        if empVacationDetails.ExtraDays == "" {
            extraDays.text = "       "
        } else {
           extraDays.text = empVacationDetails.ExtraDays
        }
        if languangeChosen == 1 {
           settlementAmount.text = empVacationDetails.SettlementAmount
        } else {
            settlementTitle.text = empVacationDetails.SettlementAmount
        }
        
    }
    
    func setUpPickerView(){
        PickerviewAction().showPickView(
            txtfield: empPickerView,
            pickerview: pickViewEmpName,
            viewController: self,
            cancelSelector: #selector(cancelClick),
            doneSelector: #selector(pickerViewDoneClick))
        
        PickerviewAction().showPickView(
            txtfield: delegatePickerView,
            pickerview: pickViewEmpDelegate,
            viewController: self,
            cancelSelector: #selector(cancelClick),
            doneSelector: #selector(pickerViewDoneClick))
        
        PickerviewAction().showPickView(txtfield: vacationTypePickerView, pickerview: vacationTypePickerViewPikcer, viewController: self, cancelSelector: #selector(cancelClick), doneSelector: #selector(pickerViewDoneClick))
    }
    
    func setupDatePicker(){
        PickerviewAction().showDatePicker(txtfield: leaveStartDatePickerView, datePicker: leaveDatePickerDatePicker, viewController: self, datePickerSelector: #selector(handleDatePicker(sender:)), doneSelector: #selector(datePickerDoneClick))
        PickerviewAction().showDatePicker(txtfield: ReturnDatePickerView, datePicker: returnDatePickerDatePicker, viewController: self, datePickerSelector: #selector(handleDatePicker(sender:)), doneSelector: #selector(datePickerDoneClick))
    }
    
    func setupLanguagChange(){
        setlanguageForTitle(label: vacationDetailsHeader, titleEnglish: "Vacations Details", titleArabic: "تفاصيل الإجازة")
        setlanguageForTitle(label: settlementDetailsHeader, titleEnglish: "Settlement Details", titleArabic: "تفاصيل التصفية")
        setlanguageForTitle(label: numberOfDaysTitle, titleEnglish: "No of Days", titleArabic: "الإجازة المطلوبة")
        setlanguageForTitle(label: balanceVacationTitle, titleEnglish: "Balance Vacation", titleArabic: "الإجازة المستحقة")
        setlanguageForTitle(label: leaveStartDateTitle, titleEnglish: "Leave Start Date", titleArabic: "تاريخ بداية الإجازة")
        setlanguageForTitle(label: returnDateTitle, titleEnglish: "Return Date", titleArabic: "تاريخ نهاية الإجازة")
        setlanguageForTitle(label: vacationTypeTitle, titleEnglish: "Vacation Type", titleArabic: "نوع الاجازة")
        setlanguageForTitle(label: exitTitle, titleEnglish: "Exit Re-Entry Days", titleArabic: "عدد ايام الخروج والعودة")
        setlanguageForTitle(label: extraDaysTitle, titleEnglish: "Extra Days", titleArabic: "ايام اضافية")
        setSettlementLocalization()
        setupSubLabel()
        
        if languangeChosen == 1{
            nextButtonOutlet.setTitle("NEXT", for: .normal)
        } else {
            nextButtonOutlet.setTitle("التالي", for: .normal)
        }
    }
    
    func setupSubLabel(){
        if languangeChosen == 1{
            numOfDays.textAlignment = .left
            balanceVacation.textAlignment = .left
            leaveStartDatePickerView.textAlignment = .left
            ReturnDatePickerView.textAlignment = .left
            vacationTypePickerView.textAlignment = .left
            exitReEntryDays.textAlignment = .left
            extraDays.textAlignment = .left
        } else {
            numOfDays.textAlignment = .right
            balanceVacation.textAlignment = .right
            leaveStartDatePickerView.textAlignment = .right
            ReturnDatePickerView.textAlignment = .right
            vacationTypePickerView.textAlignment = .right
            exitReEntryDays.textAlignment = .right
            extraDays.textAlignment = .right
        }
    }
    
    func setlanguageForTitle(label: UILabel, titleEnglish: String, titleArabic: String){
        if languangeChosen == 1{
            label.text = titleEnglish
            label.textAlignment = .left
        } else {
            label.text = titleArabic
            label.textAlignment = .right
        }
    }
    
    func setSettlementLocalization(){
        if languangeChosen == 1{
            settlementTitle.text = "Settlement Amount:"
            settlementTitle.textAlignment = .left
            settlementAmount.text = "99999999"
            settlementAmount.textAlignment = .left
        } else {
            settlementAmount.text = "مبلغ التصفية:"
            settlementTitle.textAlignment = .right
            settlementTitle.text = "99999999"
            settlementAmount.textAlignment = .right
        }
    }
    
    // -- MARK: objc function
    
    @objc func handleDatePicker(sender: UIDatePicker){
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        self.datePickerView = sender
        
        if sender == leaveDatePickerDatePicker {
            leaveStartDatePickerView.text = dateFormatter.string(from: sender.date)
        } else {
            ReturnDatePickerView.text = dateFormatter.string(from: sender.date)
        }
    }
    
    @objc func pickerViewDoneClick()
    {
        if pickerView == pickViewEmpName{
            if empNameIndex == 0 {
                 empPickerView.text = empVacArray[0].Emp_Ename
            }else {
                empPickerView.text = empNametextChosen
            }
            empPickerView.resignFirstResponder()
            return
        }
        
        else if pickerView == pickViewEmpDelegate{
            if empDelegateIndex == 0 {
                delegatePickerView.text = empDelegateArray[0].Emp_Ename
            }else {
                delegatePickerView.text = empDelegatetextChosen
            }
            delegatePickerView.resignFirstResponder()
            return
        }
        
        else if pickerView == vacationTypePickerViewPikcer{
            if vacationTypeIndex == 0 {
                vacationTypePickerView.text = vacationTypeArray[0].Vac_Desc
                vacationTypeId = vacationTypeArray[0].Vac_Type
            }else {
                vacationTypePickerView.text = vacationTypetextChosen
            }
            vacationTypePickerView.resignFirstResponder()
            return
        }
    }
    
    @objc func datePickerDoneClick(){
        leaveStartDatePickerView.resignFirstResponder()
        ReturnDatePickerView.resignFirstResponder()
    }
    
    @objc func cancelClick(){
        if pickerView == pickViewEmpName{
            empPickerView.resignFirstResponder()
            return
        } else if pickerView == pickViewEmpDelegate{
            delegatePickerView.resignFirstResponder()
            return
        }
        vacationTypePickerView.resignFirstResponder()
    }
    
    // -- MARK: Picker view data souorce
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == vacationTypePickerViewPikcer{
            return vacationTypeArray.count
        } else if pickerView == pickViewEmpName {
            return empVacArray.count
        }
        return empDelegateArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == vacationTypePickerViewPikcer{
            self.pickerView = pickerView
            return vacationTypeArray[row].Vac_Desc
        } else if pickerView == pickViewEmpName{
            self.pickerView = pickViewEmpName
            print(empVacArray[row].Emp_Ename)
            return empVacArray[row].Emp_Ename
        }
        self.pickerView = pickViewEmpDelegate
        return empDelegateArray[row].Emp_Ename
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == vacationTypePickerViewPikcer{
            vacationTypetextChosen = vacationTypeArray[row].Vac_Desc
            vacationTypeId = vacationTypeArray[row].Vac_Type
            vacationTypeIndex = row
        } else if pickerView == pickViewEmpName {
            empNametextChosen = empVacArray[row].Emp_Ename
            empNameIndex = row
        } else {
            empDelegatetextChosen =  empDelegateArray[row].Emp_Ename
            empDelegateIndex = row
        }
    }
    
    // -- MARK: IBAction
    @IBAction func nextButtonTapped(_ sender: Any) {
        if let numOfDays = numOfDays.text, let leaveStartDate = leaveStartDatePickerView.text, let returnDate = ReturnDatePickerView.text, let vacationType = vacationTypePickerView.text, let exitReEntryDays = exitReEntryDays.text{
            empVacationDetails.Number_Days = numOfDays
            empVacationDetails.Leave_Start_Dt = leaveStartDate
            empVacationDetails.Leave_Return_Dt = returnDate
            
            if vacationTypeId == "" {
                empVacationDetails.Vac_Type = vacationTypeArray[2].Vac_Type
            } else {
                empVacationDetails.Vac_Type = vacationTypeId
            }
            
            empVacationDetails.Vac_Desc = vacationType
            empVacationDetails.ExitReEntry = exitReEntryDays
        }
        performSegue(withIdentifier: "showTicketDetails", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showTicketDetails"{
            if let vc = segue.destination as? TicketDetailsViewController{
                vc.empVacationDetails = self.empVacationDetails
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

















