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
    
    @IBOutlet weak var vacationDetailsStackViewWidth: NSLayoutConstraint!
    
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
    
    let vacationTypeArray = ["Annual Vacations"]
    let empNameArray = [
        "Select Employee - اختر الموظف",
        "1598 - Faisal Saad Suliman"]
    let empDelegateArray = [
        "Your delegate - الموظف البديل",
        "111 - Ahmed Siddig Ahmed Algam"]
    
    var empNametextChosen: String?
    var empDelegatetextChosen: String?
    var vacationTypetextChosen: String?
    
    var empNameIndex: Int = 0
    var empDelegateIndex: Int = 0
    var vacationTypeIndex: Int = 0
    
    // -- MARK: viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Change the width of vacation Details Stack View base of the screen size
        vacationDetailsStackViewWidth.constant = screenSize.width - 32
        
        // Changing the back button of the navigation contoller
        setCustomBackButton(navItem: navigationItem)
        
        leaveStartDatePickerView.tintColor = .clear
        ReturnDatePickerView.tintColor = .clear
        vacationTypePickerView.tintColor = .clear
        empPickerView.tintColor = .clear
        delegatePickerView.tintColor = .clear
        
        setUpPickerView()
        setupDatePicker()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // -- MARK: Set ups
    
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
                 empPickerView.text = empNameArray[0]
            }else {
                empPickerView.text = empNametextChosen
            }
            empPickerView.resignFirstResponder()
            return
        }
        
        else if pickerView == pickViewEmpDelegate{
            if empDelegateIndex == 0 {
                delegatePickerView.text = empDelegateArray[0]
            }else {
                delegatePickerView.text = empDelegatetextChosen
            }
            delegatePickerView.resignFirstResponder()
            return
        }
        
        else if pickerView == vacationTypePickerViewPikcer{
            if vacationTypeIndex == 0 {
                vacationTypePickerView.text = vacationTypeArray[0]
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
            return empNameArray.count
        }
        return empDelegateArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == vacationTypePickerViewPikcer{
            self.pickerView = pickerView
            return vacationTypeArray[row]
        } else if pickerView == pickViewEmpName{
            self.pickerView = pickViewEmpName
            return empNameArray[row]
        }
        self.pickerView = pickViewEmpDelegate
        return empDelegateArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == vacationTypePickerViewPikcer{
            vacationTypetextChosen = vacationTypeArray[row]
            vacationTypeIndex = row
        } else if pickerView == pickViewEmpName {
            empNametextChosen = empNameArray[row]
            empNameIndex = row
        } else {
            empDelegatetextChosen =  empDelegateArray[row]
            empDelegateIndex = row
        }
    }
    
}

















