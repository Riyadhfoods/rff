//
//  NavigationBar.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 09/09/1439 AH.
//  Copyright © 1439 Riyadh Foods Industrial Co. All rights reserved.
//

import Foundation
import NotificationCenter

let mainBackgroundColor = AppDelegate().mainBackgroundColor

func setCustomNav(navItem: UINavigationItem){
    navItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    navItem.title = SlideMenuViewController.selectedItem
}

func setCustomNav(navItem: UINavigationItem, title: String){
    navItem.title = title
}

func emptyMessage(message: String, viewController: UIViewController, tableView: UITableView) {
    let rect = CGRect(origin: CGPoint(x: 16,y :16), size: CGSize(width: viewController.view.bounds.size.width - 16, height: viewController.view.bounds.size.height - 16))
    let messageLabel = UILabel(frame: rect)
    messageLabel.text = message
    messageLabel.textColor = mainBackgroundColor
    messageLabel.backgroundColor = .clear
    messageLabel.numberOfLines = 0
    messageLabel.textAlignment = .center
    messageLabel.font = UIFont.systemFont(ofSize: 20)
    messageLabel.sizeToFit()
    
    tableView.backgroundView = messageLabel;
    tableView.separatorStyle = .none;
}


