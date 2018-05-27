//
//  PickerviewAction.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 02/09/1439 AH.
//  Copyright © 1439 Riyadh Foods Industrial Co. All rights reserved.
//

import Foundation
import UIKit

class PickerviewAction{
    
    //static var datePicker: UIDatePicker = UIDatePicker()
    
    let textfield = UITextField()
    let toolBar: UIToolbar = {
        let tb = UIToolbar()
        tb.barStyle = .default
        tb.isTranslucent = true
        tb.tintColor = UIColor.black
        tb.sizeToFit()
        tb.isUserInteractionEnabled = true
        
        return tb
    }()
    
    func showPickView(txtfield: UITextField, pickerview: UIPickerView, viewController: Any?, cancelSelector: Selector?, doneSelector: Selector?){
        pickerview.dataSource = viewController as? UIPickerViewDataSource
        pickerview.delegate = viewController as? UIPickerViewDelegate
        
        txtfield.delegate = viewController as? UITextFieldDelegate
        txtfield.inputView = pickerview
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: viewController, action: cancelSelector)
        if doneSelector != nil {
            let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: viewController, action: doneSelector)
            toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        } else {
            toolBar.setItems([cancelButton], animated: false)
        }
        txtfield.inputAccessoryView = toolBar
    }
    
    func showDatePicker(txtfield: UITextField, datePicker: UIDatePicker, viewController: Any?, datePickerSelector: Selector, doneSelector: Selector)
    {
        datePicker.datePickerMode = UIDatePickerMode.date
        txtfield.inputView = datePicker
        
        datePicker.addTarget(viewController, action: datePickerSelector, for: .valueChanged)
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: viewController, action: doneSelector)
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([ spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        txtfield.inputAccessoryView = toolBar
    }
}












