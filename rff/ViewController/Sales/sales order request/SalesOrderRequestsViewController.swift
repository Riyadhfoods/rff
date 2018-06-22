//
//  SalesOrderRequestsViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 26/08/1439 AH.
//  Copyright © 1439 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

var salesDetails = SalesModel()

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
    
    let webservice = Sales()
    let screenSize = AppDelegate().screenSize
    let companyPickerView: UIPickerView = UIPickerView()
    let branchPickerView: UIPickerView = UIPickerView()
    let docIdPickerView: UIPickerView = UIPickerView()
    let LocCodePickerView: UIPickerView = UIPickerView()
    var companyTextChosen: String?
    var branchTextChosen: String?
    var docIdTextChosen: String?
    var LocCodeTextChosen: String?
    var companyArray = [SalesModel]()
    var companyNamesArray = [String]()
    var branchArray = [SalesModel]()
    var branchNamesArray = [String]()
    var docIdArray = [String]()
    var locCodeArray = [SalesModel]()
    var locCodeNumsArray = [String]()
    var selectedRow: Int = 0
    
    @IBOutlet weak var stackviewWidth: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    
    // To keep track
    var pickerview: UIPickerView = UIPickerView()
    
    let languageChosen = LoginViewController.languageChosen
    
    // -- MARK: viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCustomNav(navItem: navigationItem)
        
        showCompanyPickerViewTextfield.tintColor = .clear
        showBranchPickerViewTextfield.tintColor = .clear
        showDocIdPickerViewTextfield.tintColor = .clear
        showLocCodePickerViewTextfield.tintColor = .clear
        
        stackviewWidth.constant = screenSize.width - 32
        
        setupAarray()
        setUpWidth()
        setUpPickerView()
        setSlideMenu(controller: self, menuButton: menuBtn)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapView(gesture:)))
        view.addGestureRecognizer(tapGesture)
    }
    
    // -- MARK: Set ups
    
    func setupAarray(){
        companyArray = webservice.BindSalesOrderCompany()
        branchArray = webservice.BindSalesOrderBranches()
        docIdArray = ["SRFC"]
        locCodeArray = webservice.BindSalesOrderLocCode()
        
        companyNamesArray = ["Select a company"]
        for company in companyArray{
            companyNamesArray.append(company.EName)
        }
        
        branchNamesArray = ["Select a branch"]
        for branch in branchArray{
            branchNamesArray.append(branch.Branch)
        }
        
        locCodeNumsArray = ["Select a location code"]
        for locCode in locCodeArray{
            locCodeNumsArray.append(locCode.LocationCode)
        }
    }
    
    @objc func didTapView(gesture: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    func setUpWidth(){
        stackviewWidth.constant = screenSize.width - 32
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
            companyTextfield.text = companyNamesArray[selectedRow]
            salesDetails.EName = companyNamesArray[selectedRow]
            showCompanyPickerViewTextfield.resignFirstResponder()
        } else if pickerview == branchPickerView{
            branchTextfield.text = branchNamesArray[selectedRow]
            salesDetails.Branch = branchNamesArray[selectedRow]
            showBranchPickerViewTextfield.resignFirstResponder()
        } else if pickerview == docIdPickerView{
            docIdTextfield.text = docIdArray[0]
            showDocIdPickerViewTextfield.resignFirstResponder()
        } else {
            LocCodeTextfield.text = locCodeNumsArray[selectedRow]
            salesDetails.LocationCode = locCodeNumsArray[selectedRow]
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
            return companyNamesArray.count
        } else if pickerView == branchPickerView{
            return branchNamesArray.count
        } else if pickerView == docIdPickerView{
            return docIdArray.count
        }
        return locCodeNumsArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        self.pickerview = pickerView
        if pickerView == companyPickerView{
            return companyNamesArray[row].trimmingCharacters(in: .newlines)
        } else if pickerView == branchPickerView{
            return branchNamesArray[row]
        } else if pickerView == docIdPickerView{
            return docIdArray[row]
        }
        return locCodeNumsArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedRow = row
    }
    
    // -- MARK: IBAction
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "showSalespersonDetails", sender: nil)
    }
    
    @IBAction func signOutBuuttonTapped(_ sender: Any) {
        AuthServices().logout(self)
    }
}

extension SalesOrderRequestsViewController{
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addObservers(onShow: { frame in
            let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: frame.height, right: 0)
            self.scrollView.contentInset = contentInset
        }, onHide: { _ in
            self.scrollView.contentInset = UIEdgeInsets.zero
        })
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeObservers()
    }
}
