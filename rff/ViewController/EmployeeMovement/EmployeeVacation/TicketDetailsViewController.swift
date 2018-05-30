//
//  TicketDetailsViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 12/09/1439 AH.
//  Copyright © 1439 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit
import NotificationCenter

class TicketDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextViewDelegate {
    // -- MARK: IBOutlets
    
    @IBOutlet weak var selectorByCompany: UIView!
    @IBOutlet weak var selectorCash: UIView!
    @IBOutlet weak var selectorExitYes: UIView!
    @IBOutlet weak var selectorExitNo: UIView!
    
    @IBOutlet weak var innerSelectorByCompany: UIView!
    @IBOutlet weak var innerSelectorCash: UIView!
    @IBOutlet weak var innerSelectorExitYes: UIView!
    @IBOutlet weak var innerSelectorExitNo: UIView!
    
    @IBOutlet weak var byCompanyButton: UIButton!
    @IBOutlet weak var cashButton: UIButton!
    @IBOutlet weak var ExitYesButton: UIButton!
    @IBOutlet weak var exitNoBuuton: UIButton!
    
    @IBOutlet weak var dependentTicket: UITextField!
    @IBOutlet weak var visaReuireTableView: UITableView!
    @IBOutlet weak var comment: UITextView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    // -- MARK: Constrains
    
    @IBOutlet weak var commentWidth: NSLayoutConstraint!
    @IBOutlet weak var tableViewWidth: NSLayoutConstraint!
    
    // -- MARK: Variables
    
    let mainBackgroundColor = AppDelegate().mainBackgroundColor
    let screenSize = AppDelegate().screenSize
    let cornerRadiusValueHolder: CGFloat = 12
    let cornerRadiusValueInner: CGFloat = 11
    let cornerRadiusValueView: CGFloat = 9
    
    var empVacationDetails = EmpVac()
    let cell_Id = "cell_visaRequires"
    
    // -- MARK: viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        comment.delegate = self
        
        dependentTicket.text = empVacationDetails.Dependent_Ticket
        setupScreenLayout()
        sutupTicketRequestSelector()
        sutupExitSelector()
        setUpLanguageChosen()
        setUpCommentDisplay()
        
        // Handling the appearance of keyboard
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        scrollView.keyboardDismissMode = .interactive
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // -- MARK: setUps
    
    func setupScreenLayout(){
        commentWidth.constant = screenSize.width * 0.85
    }
    
    func setUpCommentDisplay(){
        comment.layer.cornerRadius = 5.0
        comment.layer.borderColor = mainBackgroundColor.cgColor
        comment.layer.borderWidth = 1
    }
    
    func sutupTicketRequestSelector(){
        selectorByCompany.layer.cornerRadius = cornerRadiusValueHolder
        selectorCash.layer.cornerRadius = cornerRadiusValueHolder
        
        innerSelectorByCompany.layer.cornerRadius = cornerRadiusValueInner
        innerSelectorCash.layer.cornerRadius = cornerRadiusValueInner
        
        byCompanyButton.layer.cornerRadius = cornerRadiusValueView
        byCompanyButton.backgroundColor = .white
        cashButton.layer.cornerRadius = cornerRadiusValueView
        cashButton.backgroundColor = mainBackgroundColor
    }
    
    func sutupExitSelector(){
        selectorExitYes.layer.cornerRadius = cornerRadiusValueHolder
        selectorExitNo.layer.cornerRadius = cornerRadiusValueHolder
        
        innerSelectorExitYes.layer.cornerRadius = cornerRadiusValueInner
        innerSelectorExitNo.layer.cornerRadius = cornerRadiusValueInner
        
        ExitYesButton.layer.cornerRadius = cornerRadiusValueView
        ExitYesButton.backgroundColor = mainBackgroundColor
        exitNoBuuton.layer.cornerRadius = cornerRadiusValueView
        exitNoBuuton.backgroundColor = .white
    }
    
    func sutupVisaRequireCell(cell: VisaRequiresCell){
        cell.selectorVisaYes.layer.cornerRadius = cornerRadiusValueHolder
        cell.selectorVisaNo.layer.cornerRadius = cornerRadiusValueHolder
        
        cell.innerSelectorVisaYes.layer.cornerRadius = cornerRadiusValueInner
        cell.innerSelectorVisaNo.layer.cornerRadius = cornerRadiusValueInner
        
        cell.visaYesButton.layer.cornerRadius = cornerRadiusValueView
        cell.visaYesButton.backgroundColor = mainBackgroundColor
        cell.visaNoButton.layer.cornerRadius = cornerRadiusValueView
        cell.visaNoButton.backgroundColor = .white
        
        cell.holderView.layer.cornerRadius = 5.0
        cell.holderView.layer.borderColor = mainBackgroundColor.cgColor
        cell.holderView.layer.borderWidth = 1
    }
    
    func setUpLanguageChosen(){
//        if languangeChosen == 1{
//            su.setTitle("NEXT", for: .normal)
//        } else {
//            nextButtonOutlet.setTitle("التالي", for: .normal)
//        }
    }
    
    // -- MARK: Tableview data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cell_Id, for: indexPath) as? VisaRequiresCell{
            self.sutupVisaRequireCell(cell: cell)
            return cell
        }
        return UITableViewCell()
    }
    
    // -- MARK: IBActions
    
    @IBAction func byCompanyButtonTapped(_ sender: Any) {
        byCompanyButton.backgroundColor = mainBackgroundColor
        cashButton.backgroundColor = .white
    }
    
    @IBAction func cashButtonTapped(_ sender: Any) {
        byCompanyButton.backgroundColor = .white
        cashButton.backgroundColor = mainBackgroundColor
    }
    
    @IBAction func exitYesButtonTapped(_ sender: Any) {
        ExitYesButton.backgroundColor = mainBackgroundColor
        exitNoBuuton.backgroundColor = .white
    }
    
    @IBAction func exitNoButtonTapped(_ sender: Any) {
        ExitYesButton.backgroundColor = .white
        exitNoBuuton.backgroundColor = mainBackgroundColor
    }
    
    @IBAction func submitButtonTapped(_ sender: Any) {
        
    }
    
    // -- MARK: Handle Keyboard
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height - 68
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y = 0
            }
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            comment.resignFirstResponder()
            return false
        }
        return true
    }
    
}












