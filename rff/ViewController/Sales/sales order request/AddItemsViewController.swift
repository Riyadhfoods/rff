//
//  AddItemsViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 07/06/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class AddItemsViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextViewDelegate {
    
    // -- MARK: IBOutlets
    
    @IBOutlet weak var itemsTextfield: UITextField!
    @IBOutlet weak var showItemsPickerViewTextfield: UITextField!
    @IBOutlet weak var unoitTextfield: UITextField!
    @IBOutlet weak var showUnoitPickerViewTextfield: UITextField!
    @IBOutlet weak var qtyTextfield: UITextField!
    @IBOutlet weak var showQtyPickerViewTextfield: UITextField!
    @IBOutlet weak var warningLabel: UILabel!
    @IBOutlet weak var itemsAddedLabel: UILabel!
    @IBOutlet weak var commentTextview: UITextView!
    
    @IBOutlet weak var stackviewWidth: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    
    // -- MARK: Variables
    
    let screenSize = AppDelegate().screenSize
    let itemsPickerView: UIPickerView = UIPickerView()
    let unoitPickerView: UIPickerView = UIPickerView()
    let qtyPickerView: UIPickerView = UIPickerView()
    var pickerview: UIPickerView = UIPickerView()
    
    var items = [String]()
    var unoits = [String]()
    var qtys = [String]()
    var selectedRow: Int = 0
    
    // -- MARK: viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showItemsPickerViewTextfield.tintColor = .clear
        showUnoitPickerViewTextfield.tintColor = .clear
        showQtyPickerViewTextfield.tintColor = .clear
        commentTextview.text = ""
        
        items = ["aaaaaaaaaaaaaa", "aaaaaaaaaaaaaa", "aaaaaaaaaaaaaa"]
        unoits = ["bbbbbbbbbbbbbbb", "bbbbbbbbbbbbbbb"]
        qtys = ["ccccccccccccccc"]
        
        setUpWidth()
        setupPickerView()
        setUpCommentDisplay()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapView(gesture:)))
        view.addGestureRecognizer(tapGesture)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // -- MARK: Set ups
    
    @objc func didTapView(gesture: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    func setUpWidth(){
        stackviewWidth.constant = screenSize.width - 32
    }
    
    func setupPickerView(){
        PickerviewAction().showPickView(txtfield: showItemsPickerViewTextfield, pickerview: itemsPickerView, viewController: self, cancelSelector: #selector(cancelClick), doneSelector: #selector(doneClick))
        PickerviewAction().showPickView(txtfield: showUnoitPickerViewTextfield, pickerview: unoitPickerView, viewController: self, cancelSelector: #selector(cancelClick), doneSelector: #selector(doneClick))
        PickerviewAction().showPickView(txtfield: showQtyPickerViewTextfield, pickerview: qtyPickerView, viewController: self, cancelSelector: #selector(cancelClick), doneSelector: #selector(doneClick))
    }
    
    func setUpCommentDisplay(){
        commentTextview.layer.cornerRadius = 5.0
        commentTextview.layer.borderColor = mainBackgroundColor.cgColor
        commentTextview.layer.borderWidth = 1
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            commentTextview.resignFirstResponder()
            return false
        }
        return true
    }
    
    // -- MARK: objc functions
    
    @objc func doneClick(){
        if pickerview == itemsPickerView{
            itemsTextfield.text = items[selectedRow]
            showItemsPickerViewTextfield.resignFirstResponder()
        } else if pickerview == unoitPickerView{
            unoitTextfield.text = unoits[selectedRow]
            showUnoitPickerViewTextfield.resignFirstResponder()
        } else {
            qtyTextfield.text = qtys[selectedRow]
            showQtyPickerViewTextfield.resignFirstResponder()
        }
    }
    
    @objc func cancelClick(){
        if pickerview == itemsPickerView{
            showItemsPickerViewTextfield.resignFirstResponder()
        } else if pickerview == unoitPickerView{
            showUnoitPickerViewTextfield.resignFirstResponder()
        } else {
            showQtyPickerViewTextfield.resignFirstResponder()
        }
    }
    
    // -- MARK: picker view data source
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == itemsPickerView{
            return items.count
        } else if pickerView == unoitPickerView{
            return unoits.count
        }
        return qtys.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        self.pickerview = pickerView
        if pickerView == itemsPickerView{
            return items[row]
        } else if pickerView == unoitPickerView{
            return unoits[row]
        }
        return qtys[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedRow = row
    }
    
    // MARK: IBActions
    
    @IBAction func addItemButtonTapped(_ sender: Any) {
    }
    
    @IBAction func showItemsButtonTapped(_ sender: Any) {
    }
    
}

extension AddItemsViewController{
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

