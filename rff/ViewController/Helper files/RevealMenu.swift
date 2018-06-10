//
//  RevealMenu.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 20/09/1439 AH.
//  Copyright © 1439 Riyadh Foods Industrial Co. All rights reserved.
//

import Foundation

protocol Revealable {
    var menuButton: UIBarButtonItem! { get set }
}

extension UIViewController {
    func setupRevealMenu<T : UIViewController>(controller : T) where T : Revealable {
        if self.revealViewController() != nil {
            controller.menuButton.target = self.revealViewController()
            controller.menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(controller.revealViewController().panGestureRecognizer())
            self.revealViewController().rearViewRevealWidth = 200
        }
    }
}

