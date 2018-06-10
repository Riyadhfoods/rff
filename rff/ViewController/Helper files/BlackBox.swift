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

// Localization

func getString(englishString: String, arabicString: String, language: Int) -> String{
    return language == 1 ? englishString : arabicString
}

func setlanguageForTitle(label: UILabel, titleEnglish: String, titleArabic: String, language: Int){
    if language == 1{
        label.text = titleEnglish
        label.textAlignment = .left
    } else {
        label.text = titleArabic
        label.textAlignment = .right
    }
}

func setlanguageForTitle(txt: UITextField, titleEnglish: String, titleArabic: String, language: Int){
    if language == 1{
        txt.text = titleEnglish
        txt.textAlignment = .left
    } else {
        txt.text = titleArabic
        txt.textAlignment = .right
    }
}

func setUpHeaderLabel(label: UILabel, language: Int){
    if language == 1{
        label.textAlignment = .left
    } else {
        label.textAlignment = .right
    }
}

func setUpHeaderLabel(txt: UITextField, language: Int){
    if language == 1{
        txt.textAlignment = .left
    } else {
        txt.textAlignment = .right
    }
}

func changeBoldFont(labelLeft: UILabel, labelRight: UILabel, langauge: Int){
    if langauge == 1{
        labelLeft.font = UIFont.boldSystemFont(ofSize: 15)
        labelRight.font = UIFont.systemFont(ofSize: 15)
    } else {
        labelRight.font = UIFont.boldSystemFont(ofSize: 15)
        labelLeft.font = UIFont.systemFont(ofSize: 15)
    }
}

func changeBoldFontAndColor(labelLeft: UILabel, labelRight: UILabel, langauge: Int){
    if langauge == 1{
        labelLeft.font = UIFont.boldSystemFont(ofSize: 17)
        labelLeft.textColor = .black
        labelRight.font = UIFont.systemFont(ofSize: 17)
        labelRight.textColor = AppDelegate().mainBackgroundColor
    } else {
        labelRight.font = UIFont.boldSystemFont(ofSize: 17)
        labelRight.textColor = .black
        labelLeft.font = UIFont.systemFont(ofSize: 17)
        labelLeft.textColor = AppDelegate().mainBackgroundColor
    }
}

func changeTitlePositionIfArabic(labelOne: UILabel, labelTwo: UILabel, titleEnglish: String, titleArabic: String, language: Int){
    if language == 1{
        labelOne.text = titleEnglish
        labelOne.textAlignment = .left
    } else {
        labelTwo.text = titleArabic
        labelTwo.textAlignment = .right
    }
}












