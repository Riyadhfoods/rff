//
//  SalesPersonViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 07/06/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class SalesPersonViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    // -- MARK: IBOutlets
    
    @IBOutlet weak var salespersonTextfield: UITextField!
    @IBOutlet weak var showsalespersonPickerViewTextfield: UITextField!
    @IBOutlet weak var customerTextfield: UITextField!
    @IBOutlet weak var showcustomerPickerViewTextfield: UITextField!
    @IBOutlet weak var deliveryDateTextfield: UITextField!
    
    @IBOutlet weak var selectorSuperMarketYes: UIView!
    @IBOutlet weak var selectorSuperMarketNo: UIView!
    @IBOutlet weak var innerSelectorSuperMarketYes: UIView!
    @IBOutlet weak var innerSelectorSuperMarketNo: UIView!
    @IBOutlet weak var superMarketYesButton: UIButton!
    @IBOutlet weak var superMarketNoButton: UIButton!
    
    @IBOutlet weak var selectorOfferYes: UIView!
    @IBOutlet weak var selectorOfferNo: UIView!
    @IBOutlet weak var innerSelectorOfferYes: UIView!
    @IBOutlet weak var innerSelectorOfferNo: UIView!
    @IBOutlet weak var offerYesButton: UIButton!
    @IBOutlet weak var offerNoButton: UIButton!
    
    // -- MARK: Variables
    
    let salespersonPickerView: UIPickerView = UIPickerView()
    let customerPickerView: UIPickerView = UIPickerView()
    var salespersonTextChosen: String?
    var customerTextChosen: String?
    var salespersonArray = [String]()
    var customerArray = [String]()
    
    let deliveryDatePickerView: UIDatePicker = UIDatePicker()
    
    // To keep track
    var pickerview: UIPickerView = UIPickerView()
    
    let languageChosen = LoginViewController.languageChosen
    
    // -- MARK: viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        salespersonArray = ["aaaaaaaaaaa"]
        customerArray = ["bbbbbbbbbb"]
        
        showsalespersonPickerViewTextfield.tintColor = .clear
        showcustomerPickerViewTextfield.tintColor = .clear
        deliveryDateTextfield.tintColor = .clear
        
        setUpdefaultValueForText()
        setUpPickerView()
        setUpSelectors()
        setupDatePicker()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // -- MARK: Set ups
    
    func setUpdefaultValueForText(){
        salespersonTextChosen = salespersonArray[0]
        customerTextChosen = customerArray[0]
    }
    
    func setUpPickerView(){
        PickerviewAction().showPickView(txtfield: showsalespersonPickerViewTextfield, pickerview: salespersonPickerView, viewController: self, cancelSelector: #selector(cancelClick), doneSelector: #selector(doneClick))
        PickerviewAction().showPickView(txtfield: showcustomerPickerViewTextfield, pickerview: customerPickerView, viewController: self, cancelSelector: #selector(cancelClick), doneSelector: #selector(doneClick))
    }
    
    func setUpSelectors(){
        let cornerRadiusValueHolder: CGFloat = 12
        let cornerRadiusValueInner: CGFloat = 11
        let cornerRadiusValueView: CGFloat = 9
        
        selectorSuperMarketYes.layer.cornerRadius = cornerRadiusValueHolder
        selectorSuperMarketNo.layer.cornerRadius = cornerRadiusValueHolder
        innerSelectorSuperMarketYes.layer.cornerRadius = cornerRadiusValueInner
        innerSelectorSuperMarketNo.layer.cornerRadius = cornerRadiusValueInner
        
        superMarketYesButton.layer.cornerRadius = cornerRadiusValueView
        superMarketYesButton.backgroundColor = mainBackgroundColor
        superMarketNoButton.layer.cornerRadius = cornerRadiusValueView
        superMarketNoButton.backgroundColor = .white
        
        selectorOfferYes.layer.cornerRadius = cornerRadiusValueHolder
        selectorOfferNo.layer.cornerRadius = cornerRadiusValueHolder
        innerSelectorOfferYes.layer.cornerRadius = cornerRadiusValueInner
        innerSelectorOfferNo.layer.cornerRadius = cornerRadiusValueInner
        
        offerYesButton.layer.cornerRadius = cornerRadiusValueView
        offerYesButton.backgroundColor = mainBackgroundColor
        offerNoButton.layer.cornerRadius = cornerRadiusValueView
        offerNoButton.backgroundColor = .white
    }
    
    func setupDatePicker(){
        let leaveTitle = getString(englishString: "Leave Start Date", arabicString: "تاريخ بداية الإجازة", language: languageChosen)
        
        PickerviewAction().showDatePicker(txtfield: deliveryDateTextfield, datePicker: deliveryDatePickerView, title: leaveTitle, viewController: self, datePickerSelector: #selector(handleDatePicker(sender:)), doneSelector: #selector(datePickerDoneClick))
    }
    
    @objc func handleDatePicker(sender: UIDatePicker){
        let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        let currentDate = Date()
        var dateComponents = DateComponents()
        let minDate = calendar.date(byAdding: dateComponents, to: currentDate)
        
        self.deliveryDatePickerView.minimumDate = minDate
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        deliveryDateTextfield.text = dateFormatter.string(from: sender.date)
    }
    
    // -- MARK: objc functions
    
    @objc func doneClick(){
        if pickerview == salespersonPickerView{
            salespersonTextfield.text = salespersonTextChosen
            showsalespersonPickerViewTextfield.resignFirstResponder()
        } else {
            customerTextfield.text = customerTextChosen
            showcustomerPickerViewTextfield.resignFirstResponder()
        }
    }
    
    @objc func cancelClick(){
        if pickerview == salespersonPickerView{
            showsalespersonPickerViewTextfield.resignFirstResponder()
        } else {
            showcustomerPickerViewTextfield.resignFirstResponder()
        }
    }
    
    @objc func datePickerDoneClick(){
        deliveryDateTextfield.resignFirstResponder()
    }
    
    // -- MARK: picker view data source
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == salespersonPickerView{
            return salespersonArray.count
        }
        return customerArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        self.pickerview = pickerView
        if pickerView == salespersonPickerView{
            return salespersonArray[row]
        }
        return customerArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == salespersonPickerView{
            salespersonTextfield.text = salespersonArray[row]
            salespersonTextChosen = salespersonArray[row]
        } else {
            customerTextfield.text = customerArray[row]
            customerTextChosen = customerArray[row]
        }
    }
    
    // -- MARK: IBActions
    
    @IBAction func superMarketYesButtonTapped(_ sender: Any) {
        superMarketYesButton.backgroundColor = mainBackgroundColor
        superMarketNoButton.backgroundColor = .white
    }
    
    @IBAction func superMarketNoButtonTapped(_ sender: Any) {
        superMarketYesButton.backgroundColor = .white
        superMarketNoButton.backgroundColor = mainBackgroundColor
    }
    
    @IBAction func offerYesButtonTapped(_ sender: Any) {
        offerYesButton.backgroundColor = mainBackgroundColor
        offerNoButton.backgroundColor = .white
    }
    
    @IBAction func offerNoButtonTapped(_ sender: Any) {
        offerYesButton.backgroundColor = .white
        offerNoButton.backgroundColor = mainBackgroundColor
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
    }
    
}






