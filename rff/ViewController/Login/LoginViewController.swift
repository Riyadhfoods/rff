//
//  ViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 20/08/1439 AH.
//  Copyright © 1439 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    // -- MARK: IBOutlets
    @IBOutlet weak var logoHolderView: UIView!
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var usernameTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var companyPickerView: UITextField!
    @IBOutlet weak var companyDropdownImage: UIImageView!
    @IBOutlet weak var languangePickerView: UITextField!
    @IBOutlet weak var languangeDropdownImage: UIImageView!
    
    // MARK: Constrians
    @IBOutlet weak var logoHeight: NSLayoutConstraint!
    @IBOutlet weak var logoWidth: NSLayoutConstraint!
    @IBOutlet weak var logoHolderHeight: NSLayoutConstraint!
    @IBOutlet weak var logoHolderWidth: NSLayoutConstraint!
    @IBOutlet weak var textfieldHeight: NSLayoutConstraint!
    @IBOutlet weak var pickerViewHeight: NSLayoutConstraint!
    @IBOutlet weak var buttonHeight: NSLayoutConstraint!
    
    
    let activityIndicator: UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView()
        ai.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        ai.hidesWhenStopped = true
        ai.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        
        return ai
    }()
    
    // -- MARK: Variables
    
    let screenHeight = AppDelegate().screenSize.height
    let pickerViewAction = PickerviewAction()
    
    let pickViewCompay: UIPickerView = UIPickerView()
    let pickViewLanguage: UIPickerView = UIPickerView()
    
    var pickview: UIPickerView = UIPickerView()
    
    let companyArray = ["RiyadhFoods - شركة الرياض لصناعات التغذية"]
    let languageArray = ["English - إنجليزي" , "Arabic - عربي"]
    
    // 1 --> English, 2 --> Arabic
    static var languageChosen: Int = 1
    
    let screenSize = AppDelegate().screenSize

    // -- MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logoHolderView.layer.cornerRadius = 153.41 / 2
        setUpLayout()
        
        // text field delegate
        usernameTextfield.delegate = self
        passwordTextfield.delegate = self
        
        setUpPickerView()
    }
    
    // -- MARK: Pick view functions
    
    func setUpLayout(){
        let logoHolderSEScreen = screenHeight * 0.23
        let logoSEScreen = screenHeight * 0.215
        let textfieldbuttonSESecreen = screenHeight * 0.074
        
        if screenHeight == 568 {
            logoHolderHeight.constant = logoHolderSEScreen
            logoHolderWidth.constant = logoHolderSEScreen
            logoWidth.constant = logoSEScreen
            logoHeight.constant = logoSEScreen
            textfieldHeight.constant = textfieldbuttonSESecreen
            pickerViewHeight.constant = textfieldbuttonSESecreen
            buttonHeight.constant = textfieldbuttonSESecreen
            logoHolderView.layer.cornerRadius = logoHolderSEScreen / 2
        } else {
            logoHolderView.layer.cornerRadius = 153.41 / 2
        }
    }
    
    func setUpPickerView(){
        pickerViewAction.showPickView(txtfield: companyPickerView, pickerview: pickViewCompay, viewController: self, cancelSelector: #selector(cancelClick), doneSelector: nil)
        pickerViewAction.showPickView(txtfield: languangePickerView, pickerview: pickViewLanguage, viewController: self, cancelSelector: #selector(cancelClick), doneSelector: nil)
    }
    
    @objc func cancelClick(){
        if pickview == pickViewCompay{
            companyPickerView.resignFirstResponder()
            return
        }
        languangePickerView.resignFirstResponder()
    }
    
    // -- MARK: IBActions
    
    @IBAction func loginButton(_ sender: Any) {
        
        // Activity Indicator
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
        print("Button pressed!")
        guard let usernametext = usernameTextfield.text, let passwordText = passwordTextfield.text else {
            activityIndicator.stopAnimating()
            return
        }
        
        if usernametext.isEmpty || passwordText.isEmpty {
            activityIndicator.stopAnimating()
            AlertMessage().showAlertMessage(alertTitle: "Alert!", alertMessage: "Username or password is empty", actionTitle: nil, onAction: nil, cancelAction: "Dismiss", self)
        }
        
        if let language = languangePickerView.text{
            LoginViewController.languageChosen = setLanguageChosen(languagetextfield: language)
        }
        
        AuthServices().checkUserId(id: usernametext, password: passwordText, onSeccuss: {
            self.activityIndicator.stopAnimating()
            self.performSegue(withIdentifier: "showHomePage", sender: nil)
        }) { (error) in
            self.activityIndicator.stopAnimating()
            AlertMessage().showAlertMessage(alertTitle: "Alert!", alertMessage: error, actionTitle: nil, onAction: nil, cancelAction: "Dismiss", self)
        }
    }
    
    // -- MARK: Pivker view delegate
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == pickViewCompay{
            return companyArray.count
        }
        return languageArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == pickViewCompay{
            self.pickview = pickViewCompay
            return companyArray[row]
        }
        self.pickview = pickViewLanguage
        return languageArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == pickViewCompay{
            companyPickerView.text = companyArray[row]
            cancelClick()
        } else {
            languangePickerView.text =  languageArray[row]
            cancelClick()
        }
    }
    
    // -- MARK: Helper functions
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.usernameTextfield{
            passwordTextfield.becomeFirstResponder()
        } else if textField == self.passwordTextfield{
            textField.resignFirstResponder()
        }
        return true
    }
    
    
    
    // -- MARK: helper function
    func setLanguageChosen(languagetextfield: String) -> Int{
        if languagetextfield == languageArray[1] {
            return 2
        }
        return 1
    }
    
    func showAlertMessage(withTitle title: String, andMessage message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let dismissButton = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
        alert.addAction(dismissButton)
        present(alert, animated: true, completion: nil)
    }
}

