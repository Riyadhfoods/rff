//
//  StoreViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 07/06/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class StoreViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    // -- MARK: IBOutlets
    
    @IBOutlet weak var storeTextfield: UITextField!
    @IBOutlet weak var showStorePickerViewTextfield: UITextField!
    @IBOutlet weak var cityTextfield: UITextField!
    @IBOutlet weak var showCityPickerViewTextfield: UITextField!
    @IBOutlet weak var salesPersonTextfield: UITextField!
    @IBOutlet weak var showSalesPersonPickerViewTextfield: UITextField!
    @IBOutlet weak var merchandiserTextfield: UITextField!
    @IBOutlet weak var showMerchandiserPickerViewTextfield: UITextField!
    
    // -- MARK: Variables
    
    let storePickerView: UIPickerView = UIPickerView()
    let cityPickerView: UIPickerView = UIPickerView()
    let salesPersonPickerView: UIPickerView = UIPickerView()
    let merchandiserPickerView: UIPickerView = UIPickerView()
    var storeTextChosen: String?
    var cityTextChosen: String?
    var salesPersonTextChosen: String?
    var merchandiserTextChosen: String?
    var storeArray = [String]()
    var cityArray = [String]()
    var salesPersonArray = [String]()
    var merchandiserArray = [String]()
    
    // To keep track
    var pickerview: UIPickerView = UIPickerView()
    
    let languageChosen = LoginViewController.languageChosen
    
    // -- MARK: viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showStorePickerViewTextfield.tintColor = .clear
        showCityPickerViewTextfield.tintColor = .clear
        showSalesPersonPickerViewTextfield.tintColor = .clear
        showMerchandiserPickerViewTextfield.tintColor = .clear
        
        storeArray = ["aaaaaaaaaaa"]
        cityArray = ["bbbbbbbbb"]
        salesPersonArray = ["cccccccccc"]
        merchandiserArray = ["ddddddddddd"]
        
        setUpdefaultValueForText()
        setUpPickerView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // -- MARK: Set ups
    
    func setUpdefaultValueForText(){
        storeTextChosen = storeArray[0]
        cityTextChosen = cityArray[0]
        salesPersonTextChosen = salesPersonArray[0]
        merchandiserTextChosen = merchandiserArray[0]
    }
    
    func setUpPickerView(){
        PickerviewAction().showPickView(txtfield: showStorePickerViewTextfield, pickerview: storePickerView, viewController: self, cancelSelector: #selector(cancelClick), doneSelector: #selector(doneClick))
        PickerviewAction().showPickView(txtfield: showCityPickerViewTextfield, pickerview: cityPickerView, viewController: self, cancelSelector: #selector(cancelClick), doneSelector: #selector(doneClick))
        PickerviewAction().showPickView(txtfield: showSalesPersonPickerViewTextfield, pickerview: salesPersonPickerView, viewController: self, cancelSelector: #selector(cancelClick), doneSelector: #selector(doneClick))
        PickerviewAction().showPickView(txtfield: showMerchandiserPickerViewTextfield, pickerview: merchandiserPickerView, viewController: self, cancelSelector: #selector(cancelClick), doneSelector: #selector(doneClick))
    }
    
    
    
    // -- MARK: objc functions
    
    @objc func doneClick(){
        if pickerview == storePickerView{
            storeTextfield.text = storeTextChosen
            showStorePickerViewTextfield.resignFirstResponder()
        } else if pickerview == cityPickerView{
            cityTextfield.text = cityTextChosen
            showCityPickerViewTextfield.resignFirstResponder()
        } else if pickerview == salesPersonPickerView{
            salesPersonTextfield.text = salesPersonTextChosen
            showSalesPersonPickerViewTextfield.resignFirstResponder()
        } else {
            merchandiserTextfield.text = merchandiserTextChosen
            showMerchandiserPickerViewTextfield.resignFirstResponder()
        }
    }
    
    @objc func cancelClick(){
        if pickerview == storePickerView{
            showStorePickerViewTextfield.resignFirstResponder()
        } else if pickerview == cityPickerView{
            showCityPickerViewTextfield.resignFirstResponder()
        } else if pickerview == salesPersonPickerView{
            showSalesPersonPickerViewTextfield.resignFirstResponder()
        } else {
            showMerchandiserPickerViewTextfield.resignFirstResponder()
        }
    }
    
    // -- MARK: picker view data source
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == storePickerView{
            return storeArray.count
        } else if pickerView == cityPickerView{
            return cityArray.count
        } else if pickerView == salesPersonPickerView{
            return salesPersonArray.count
        }
        return merchandiserArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        self.pickerview = pickerView
        if pickerView == storePickerView{
            return storeArray[row]
        } else if pickerView == cityPickerView{
            return cityArray[row]
        } else if pickerView == salesPersonPickerView{
            return salesPersonArray[row]
        }
        return merchandiserArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == storePickerView{
            storeTextfield.text = storeArray[row]
            storeTextChosen = storeArray[row]
        } else if pickerView == cityPickerView{
            cityTextfield.text = cityArray[row]
            cityTextChosen = cityArray[row]
        } else if pickerView == salesPersonPickerView{
            salesPersonTextfield.text = salesPersonArray[row]
            salesPersonTextChosen = salesPersonArray[row]
        } else {
            merchandiserTextfield.text = merchandiserArray[row]
            merchandiserTextChosen = merchandiserArray[row]
        }
    }
    
    // -- MARK: IBActions

    @IBAction func nextButtonTapped(_ sender: Any) {
    }
    
}
