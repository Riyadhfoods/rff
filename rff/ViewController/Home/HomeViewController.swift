//
//  HomeViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 26/08/1439 AH.
//  Copyright © 1439 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    // -- MARK: IBOutlets
    @IBOutlet weak var menuBtn: UIBarButtonItem!
    @IBOutlet weak var label: UILabel!
    
    // -- MARK: Variable
    let screenSize = AppDelegate().screenSize
    var greetingMessage: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let userName = AuthServices.currentUserName {
            if LoginViewController.languageChosen == 1 {
                greetingMessage = "Weclome"
            } else {
                greetingMessage = "مرحباً"
            }
            
            label.text = "\(greetingMessage) \(userName)"
        }
        
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

}
