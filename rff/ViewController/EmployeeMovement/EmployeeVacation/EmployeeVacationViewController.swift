//
//  EmployeeVacationViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 26/08/1439 AH.
//  Copyright © 1439 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class EmployeeVacationViewController: UIViewController {

    @IBOutlet weak var menuBtn: UIBarButtonItem!
    @IBOutlet weak var addVacationButtonOutlet: UIButton!
    
    let screenSize = AppDelegate().screenSize
    //let swrevealAction = SWRevealFunction()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Changing the back button of the navigation contoller
        setCustomNav(navItem: navigationItem)
        
        if LoginViewController.languageChosen == 1 {
            addVacationButtonOutlet.setTitle("ADD VACATION", for: .normal)
        } else {
            addVacationButtonOutlet.setTitle("إضافة اجازه", for: .normal)
        }
        sideMenus()
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
    
    @IBAction func signOutBuuttonTapped(_ sender: Any) {
        AuthServices().logout(self)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}
