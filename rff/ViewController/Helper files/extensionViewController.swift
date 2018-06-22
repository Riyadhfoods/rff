//
//  RevealMenu.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 20/09/1439 AH.
//  Copyright © 1439 Riyadh Foods Industrial Co. All rights reserved.
//

import Foundation

extension UIViewController {
    func addObservers(onShow: @escaping (_ frame: CGRect) -> Void, onHide: @escaping (_ frame: CGRect) -> Void){
        NotificationCenter.default.addObserver(forName: .UIKeyboardWillShow, object: nil, queue: nil) {
            (notification) in
            self.keyboardWillShow(notification: notification, onShow: onShow)
        }
        
        NotificationCenter.default.addObserver(forName: .UIKeyboardWillHide, object: nil, queue: nil) {
            (notification) in
            self.keyboardWillHide(notification: notification, onHide: onHide)
        }
    }
    
    func removeObservers(){
        NotificationCenter.default.removeObserver(self)
    }
    
    func keyboardWillShow(notification: Notification, onShow: @escaping (_ frame: CGRect) -> Void){
        guard let userInfo = notification.userInfo, let frame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        onShow(frame)
    }
    
    func keyboardWillHide(notification: Notification, onHide: @escaping (_ frame: CGRect) -> Void){
        guard let userInfo = notification.userInfo, let frame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        onHide(frame)
    }
}

