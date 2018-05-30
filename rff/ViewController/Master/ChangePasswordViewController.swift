//
//  ChangePasswordViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 26/08/1439 AH.
//  Copyright © 1439 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class ChangePasswordViewController: UIViewController, UITextFieldDelegate {

    // -- MARK: IBOutlets
    @IBOutlet weak var menuBtn: UIBarButtonItem!
    @IBOutlet weak var oldPasswordLabel: UILabel!
    @IBOutlet weak var oldPasswordTextfield: UITextField!
    @IBOutlet weak var newPasswordLabel: UILabel!
    @IBOutlet weak var newPasswordTextfield: UITextField!
    @IBOutlet weak var changeButtonOutlet: UIButton!
    
    // -- MARK: Variable
    let screenSize = AppDelegate().screenSize
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    // 1 --> English, 2 --> Arabic
    let languageChosen = LoginViewController.languageChosen
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Adding the text field delegate
        oldPasswordTextfield.delegate = self
        newPasswordTextfield.delegate = self
        
        // Change the language to the correspanding language chosen
        if languageChosen == 1 {
            oldPasswordLabel.text = "Old password"
            oldPasswordLabel.textAlignment = .left
            newPasswordLabel.text = "New Password"
            newPasswordLabel.textAlignment = .left
            changeButtonOutlet.setTitle("CHANGE", for: .normal)
        } else {
            oldPasswordLabel.text = "الرقم السري القديم"
            oldPasswordLabel.textAlignment = .right
            newPasswordLabel.text = "الرقم السري الجديد"
            newPasswordLabel.textAlignment = .right
            changeButtonOutlet.setTitle("تغيير", for: .normal)
        }
        setCustomNav(navItem: navigationItem)
        
        sideMenus()
    }
    
    // -- MARK: Slide Menu
    //To show the slide menu
    func sideMenus () {
        if revealViewController() != nil {
            menuBtn.target = revealViewController()
            menuBtn.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rearViewRevealWidth = screenSize.width * 0.75
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    // -- MARK: IBActions
    @IBAction func signOutBuuttonTapped(_ sender: Any) {
        AuthServices().logout(self)
    }
    
    @IBAction func changeButtonTapped(_ sender: Any) {
        // Adding Activity indicator
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(activityIndicator)
        
        activityIndicator.startAnimating()
        
        if let currentUserId = AuthServices.currentUserId, let oldPassword = oldPasswordTextfield.text, let newPassword = newPasswordTextfield.text{
            AuthServices().changePassword(id: currentUserId, oldPassword: oldPassword, newPassword: newPassword, onSeccuss: {
                self.activityIndicator.stopAnimating()
                AlertMessage().showAlertMessage(alertTitle: "Password Change Successfully", alertMessage: "", actionTitle: "Ok", onAction: {
                    self.oldPasswordTextfield.text = ""
                    self.newPasswordTextfield.text = ""
                    
                    self.oldPasswordTextfield.resignFirstResponder()
                    self.newPasswordTextfield.resignFirstResponder()
                }, cancelAction: nil, self)
            }) { (error) in
                self.activityIndicator.stopAnimating()
                AlertMessage().showAlertMessage(alertTitle: "Error!", alertMessage: error, actionTitle: nil, onAction: nil, cancelAction: "Ok", self)
            }
            self.view.endEditing(true)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.oldPasswordTextfield{
            newPasswordTextfield.becomeFirstResponder()
        } else if textField == self.newPasswordTextfield{
            textField.resignFirstResponder()
        }
        return true
    }
}














