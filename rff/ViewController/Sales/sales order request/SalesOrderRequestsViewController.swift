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
    var selectedRow: Int = 0
    
    @IBOutlet weak var stackviewWidth: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    
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
        
        stackviewWidth.constant = screenSize.width - 32
        
        companyArray = ["rff1", "rff2", "rff3"]
        branchArray = ["riyadh1", "riyadh2", "riyadh3"]
        docIdArray = ["AAAA1", "AAAA2", "AAAA3"]
        locCodeArray = ["6565"]
        
        setUpWidth()
        setUpPickerView()
        sideMenus()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapView(gesture:)))
        view.addGestureRecognizer(tapGesture)
    }
    
    // -- MARK: Set ups
    
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
            companyTextfield.text = companyArray[selectedRow]
            showCompanyPickerViewTextfield.resignFirstResponder()
        } else if pickerview == branchPickerView{
            branchTextfield.text = branchArray[selectedRow]
            showBranchPickerViewTextfield.resignFirstResponder()
        } else if pickerview == docIdPickerView{
            docIdTextfield.text = docIdArray[selectedRow]
            showDocIdPickerViewTextfield.resignFirstResponder()
        } else {
            LocCodeTextfield.text = locCodeArray[selectedRow]
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
        selectedRow = row
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

extension SalesOrderRequestsViewController{
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addObservers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeObservers()
    }
    
    func addObservers(){
        NotificationCenter.default.addObserver(forName: .UIKeyboardWillShow, object: nil, queue: nil) {
            (notification) in
            self.keyboardWillShow(notification: notification)
        }
        
        NotificationCenter.default.addObserver(forName: .UIKeyboardWillHide, object: nil, queue: nil) {
            (notification) in
            self.keyboardWillHide(notification: notification)
        }
    }
    
    func removeObservers(){
        NotificationCenter.default.removeObserver(self)
    }
    
    func keyboardWillShow(notification: Notification){
        guard let userInfo = notification.userInfo, let frame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: frame.height, right: 0)
        scrollView.contentInset = contentInset
    }
    
    func keyboardWillHide(notification: Notification){
        scrollView.contentInset = UIEdgeInsets.zero
    }
}
