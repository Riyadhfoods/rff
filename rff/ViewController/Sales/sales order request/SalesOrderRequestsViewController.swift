//
//  SalesOrderRequestsViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 26/08/1439 AH.
//  Copyright © 1439 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class SalesOrderRequestsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    // -- MARK: IBOutlets
    
    @IBOutlet weak var menuBtn: UIBarButtonItem!
    @IBOutlet weak var companyTextfield: UITextField!
    @IBOutlet weak var showCompanyPickerViewTextfield: UITextField!
    @IBOutlet weak var branchTextfield: UITextField!
    @IBOutlet weak var showBranchPickerViewTextfield: UITextField!
    @IBOutlet weak var docIdTextfield: UITextField!
    @IBOutlet weak var showDocIdPickerViewTextfield: UITextField!
    @IBOutlet weak var LocCodeTextfield: UITextField!
    @IBOutlet weak var showLocCodePickerViewTextfield: UITextField!
    
    // -- MARK: Variable
    
    let screenSize = AppDelegate().screenSize
    let companyPickerView: UIPickerView = UIPickerView()
    let branchPickerView: UIPickerView = UIPickerView()
    let docIdPickerView: UIPickerView = UIPickerView()
    let LocCodePickerView: UIPickerView = UIPickerView()
    var companyTextChosen: String?
    var branchTextChosen: String?
    var docIdTextChosen: String?
    var LocCodeTextChosen: String?
    var companyArray = [String]()
    var branchArray = [String]()
    var docIdArray = [String]()
    var locCodeArray = [String]()
    
    // To keep track
    var pickerview: UIPickerView = UIPickerView()
    
    let languageChosen = LoginViewController.languageChosen
    
    // -- MARK: viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showCompanyPickerViewTextfield.tintColor = .clear
        showBranchPickerViewTextfield.tintColor = .clear
        showDocIdPickerViewTextfield.tintColor = .clear
        showLocCodePickerViewTextfield.tintColor = .clear
        
        companyArray = ["rff"]
        branchArray = ["riyadh"]
        docIdArray = ["AAAA"]
        locCodeArray = ["6565"]
        
        setUpdefaultValueForText()
        setUpPickerView()
        sideMenus()
    }
    
    // -- MARK: Set ups
    
    func setUpdefaultValueForText(){
        companyTextChosen = companyArray[0]
        branchTextChosen = branchArray[0]
        docIdTextChosen = docIdArray[0]
        LocCodeTextChosen = locCodeArray[0]
    }
    
    func setUpPickerView(){
        PickerviewAction().showPickView(txtfield: showCompanyPickerViewTextfield, pickerview: companyPickerView, viewController: self, cancelSelector: #selector(cancelClick), doneSelector: #selector(doneClick))
        PickerviewAction().showPickView(txtfield: showBranchPickerViewTextfield, pickerview: branchPickerView, viewController: self, cancelSelector: #selector(cancelClick), doneSelector: #selector(doneClick))
        PickerviewAction().showPickView(txtfield: showDocIdPickerViewTextfield, pickerview: docIdPickerView, viewController: self, cancelSelector: #selector(cancelClick), doneSelector: #selector(doneClick))
        PickerviewAction().showPickView(txtfield: showLocCodePickerViewTextfield, pickerview: LocCodePickerView, viewController: self, cancelSelector: #selector(cancelClick), doneSelector: #selector(doneClick))
    }
    
    
    
    // -- MARK: objc functions
    
    @objc func doneClick(){
        if pickerview == companyPickerView{
            companyTextfield.text = companyTextChosen
            showCompanyPickerViewTextfield.resignFirstResponder()
        } else if pickerview == branchPickerView{
            branchTextfield.text = branchTextChosen
            showBranchPickerViewTextfield.resignFirstResponder()
        } else if pickerview == docIdPickerView{
            docIdTextfield.text = docIdTextChosen
            showDocIdPickerViewTextfield.resignFirstResponder()
        } else {
            LocCodeTextfield.text = LocCodeTextChosen
            showLocCodePickerViewTextfield.resignFirstResponder()
        }
    }
    
    @objc func cancelClick(){
        if pickerview == companyPickerView{
            showCompanyPickerViewTextfield.resignFirstResponder()
        } else if pickerview == branchPickerView{
            showBranchPickerViewTextfield.resignFirstResponder()
        } else if pickerview == docIdPickerView{
            showDocIdPickerViewTextfield.resignFirstResponder()
        } else {
            showLocCodePickerViewTextfield.resignFirstResponder()
        }
    }
    
    // -- MARK: picker view data source
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == companyPickerView{
            return companyArray.count
        } else if pickerView == branchPickerView{
            return branchArray.count
        } else if pickerView == docIdPickerView{
            return docIdArray.count
        }
        return locCodeArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        self.pickerview = pickerView
        if pickerView == companyPickerView{
            return companyArray[row]
        } else if pickerView == branchPickerView{
            return branchArray[row]
        } else if pickerView == docIdPickerView{
            return docIdArray[row]
        }
        return locCodeArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == companyPickerView{
            companyTextfield.text = companyArray[row]
            companyTextChosen = companyArray[row]
        } else if pickerView == branchPickerView{
            branchTextfield.text = branchArray[row]
            branchTextChosen = branchArray[row]
        } else if pickerView == docIdPickerView{
            docIdTextfield.text = docIdArray[row]
            docIdTextChosen = docIdArray[row]
        } else {
            LocCodeTextfield.text = locCodeArray[row]
            LocCodeTextChosen = locCodeArray[row]
        }
    }
    
    // -- MARK: IBAction
    
    @IBAction func nextButtonTapped(_ sender: Any) {
    }
    
    @IBAction func signOutBuuttonTapped(_ sender: Any) {
        AuthServices().logout(self)
    }

    
    //To show the slide menu
    func sideMenus () {
        if revealViewController() != nil {
            menuBtn.target = revealViewController()
            menuBtn.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rearViewRevealWidth = screenSize.width * 0.75
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
}
