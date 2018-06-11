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
    
    @IBOutlet weak var stackviewWidth: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    
    // -- MARK: Variables
    
    let screenSize = AppDelegate().screenSize
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
    var selectedRow: Int = 0
    
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
        
        setUpWidth()
        setUpPickerView()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapView(gesture:)))
        view.addGestureRecognizer(tapGesture)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // -- MARK: Set ups
    
    @objc func didTapView(gesture: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    func setUpWidth(){
        stackviewWidth.constant = screenSize.width - 32
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
            storeTextfield.text = storeArray[selectedRow]
            showStorePickerViewTextfield.resignFirstResponder()
        } else if pickerview == cityPickerView{
            cityTextfield.text = cityArray[selectedRow]
            showCityPickerViewTextfield.resignFirstResponder()
        } else if pickerview == salesPersonPickerView{
            salesPersonTextfield.text = salesPersonArray[selectedRow]
            showSalesPersonPickerViewTextfield.resignFirstResponder()
        } else {
            merchandiserTextfield.text = merchandiserArray[selectedRow]
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
        selectedRow = row
    }
    
    // -- MARK: IBActions

    @IBAction func nextButtonTapped(_ sender: Any) {
    }
    
}

extension StoreViewController{
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
