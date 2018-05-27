//
//  TicketDetailsViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 12/09/1439 AH.
//  Copyright © 1439 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class TicketDetailsViewController: UIViewController {
    // -- MARK: IBOutlets
    
    @IBOutlet weak var selectorByCompany: UIView!
    @IBOutlet weak var selectorCash: UIView!
    @IBOutlet weak var selectorExitYes: UIView!
    @IBOutlet weak var selectorExitNo: UIView!
    @IBOutlet weak var selectorVisaYes: UIView!
    @IBOutlet weak var selectorVisaNo: UIView!
    
    @IBOutlet weak var innerSelectorByCompany: UIView!
    @IBOutlet weak var innerSelectorCash: UIView!
    @IBOutlet weak var innerSelectorExitYes: UIView!
    @IBOutlet weak var innerSelectorExitNo: UIView!
    @IBOutlet weak var innerSelectorVisaYes: UIView!
    @IBOutlet weak var innerSelectorVisaNo: UIView!
    
    @IBOutlet weak var byCompanyButton: UIButton!
    @IBOutlet weak var cashButton: UIButton!
    @IBOutlet weak var ExitYesButton: UIButton!
    @IBOutlet weak var exitNoBuuton: UIButton!
    @IBOutlet weak var visaYesButton: UIButton!
    @IBOutlet weak var visaNoButton: UIButton!
    
    @IBOutlet weak var dependentTicket: UITextField!
    
    // -- MARK: Variables
    
    let mainBackgroundColor = AppDelegate().mainBackgroundColor
    let cornerRadiusValueHolder: CGFloat = 12
    let cornerRadiusValueInner: CGFloat = 11
    let cornerRadiusValueView: CGFloat = 9
    
    // -- MARK: viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sutupTicketRequestSelector()
        sutupExitSelector()
        sutupVisaSelector()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // -- MARK: setUps
    
    func sutupTicketRequestSelector(){
        selectorByCompany.layer.cornerRadius = cornerRadiusValueHolder
        selectorCash.layer.cornerRadius = cornerRadiusValueHolder
        
        innerSelectorByCompany.layer.cornerRadius = cornerRadiusValueInner
        innerSelectorCash.layer.cornerRadius = cornerRadiusValueInner
        
        byCompanyButton.layer.cornerRadius = cornerRadiusValueView
        byCompanyButton.backgroundColor = mainBackgroundColor
        cashButton.layer.cornerRadius = cornerRadiusValueView
        cashButton.backgroundColor = .white
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
    
    func sutupVisaSelector(){
        selectorVisaYes.layer.cornerRadius = cornerRadiusValueHolder
        selectorVisaNo.layer.cornerRadius = cornerRadiusValueHolder
        
        innerSelectorVisaYes.layer.cornerRadius = cornerRadiusValueInner
        innerSelectorVisaNo.layer.cornerRadius = cornerRadiusValueInner
        
        visaYesButton.layer.cornerRadius = cornerRadiusValueView
        visaYesButton.backgroundColor = mainBackgroundColor
        visaNoButton.layer.cornerRadius = cornerRadiusValueView
        visaNoButton.backgroundColor = .white
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
    
    @IBAction func visaYesButtonTapped(_ sender: Any) {
        visaYesButton.backgroundColor = mainBackgroundColor
        visaNoButton.backgroundColor = .white
    }
    
    @IBAction func visaNoButtonTapped(_ sender: Any) {
        visaYesButton.backgroundColor = .white
        visaNoButton.backgroundColor = mainBackgroundColor
    }
    
    @IBAction func submitButtonTapped(_ sender: Any) {
        
    }
    
}
