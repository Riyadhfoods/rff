//
//  AuthServices.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 05/09/1439 AH.
//  Copyright © 1439 Riyadh Foods Industrial Co. All rights reserved.
//

import Foundation
import UIKit

class AuthServices{
    let login = Login()
    var arrayOfResult: [String?] = [String]()
    var result: String?
    static var currentUserId: String?
    static var currentUserName: String?
    
    func checkUserId(id: String, password: String, onSeccuss: @escaping () -> Void, onError: @escaping (_ ErrorMessage: String) -> Void){
        arrayOfResult = login.CheckLogin(username: id, password: password, error: "", langid: LoginViewController.languageChosen)
            
        if arrayOfResult[0] == "0"{
            AuthServices.currentUserId = id
            AuthServices.currentUserName = arrayOfResult[1]
            onSeccuss()
        } else {
            if let error = arrayOfResult[0]{
                onError(error)
            }
        }
    }
    
    func logout(_ UIViewController: UIViewController){
        AlertMessage().showAlertMessage(alertTitle: "SignOut", alertMessage: "Are you sure you want to sign out?", actionTitle: "Yes", onAction: {
            AuthServices.currentUserId = nil
            UIViewController.dismiss(animated: true, completion: nil)
        }, cancelAction: "Cancel", UIViewController)
    }
    
    func changePassword(id: String, oldPassword: String, newPassword: String, onSeccuss: @escaping () -> Void, onError: @escaping (_ ErrorMessage: String) -> Void){
        result = login.ChangePassword(emp_id: id, oldpassword: oldPassword, newpassword: newPassword, error: "")
        if result == "0"{
            onSeccuss()
        } else {
            if let error = result{
                onError(error)
            }
        }
    }
}






