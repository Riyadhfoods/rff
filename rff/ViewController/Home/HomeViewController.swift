//
//  HomeViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 26/08/1439 AH.
//  Copyright © 1439 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // -- MARK: IBOutlets
    @IBOutlet weak var menuBtn: UIBarButtonItem!
    @IBOutlet weak var pendingInboxTableview: UITableView!
    
    // -- MARK: Variable
    let screenSize = AppDelegate().screenSize
    let mainBackgroundColor = AppDelegate().mainBackgroundColor
    var greetingMessage: String = ""
    let cell_id = "cell_pendingInbox"
    var webservice: Login = Login()
    var taskInbox: [Task_Inbox] = [Task_Inbox]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let userId = AuthServices.currentUserId {
            taskInbox = webservice.Task_InboxM(langid: LoginViewController.languageChosen, emp_id: userId)
        }
        
        if LoginViewController.languageChosen == 1 {
            navigationItem.title = "Home"
        } else {
            navigationItem.title = "الرئيسية"
        }
        
        view.backgroundColor = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1.0)
        sideMenus()
    }
    
    // -- MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if taskInbox.count == 0 {
            emptyMessage(message: "No data", viewController: self, tableView: pendingInboxTableview)
        }
        return taskInbox.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cell_id, for: indexPath) as? PendingInboxCell{
            
            cell.holderView.layer.cornerRadius = 5.0
            cell.holderView.layer.borderColor = UIColor(red: 105/255, green: 132/255, blue: 92/255, alpha: 1.0).cgColor
            cell.holderView.layer.borderWidth = 1
            
            cell.contentView.backgroundColor = UIColor.clear
            
            let english_description = taskInbox[indexPath.row].EnglishDes
            let arabic_description = taskInbox[indexPath.row].ArabicDesc
            let count = taskInbox[indexPath.row].Count
            
            cell.englishDescription.text = english_description
            cell.arabicDescription.text = arabic_description
            cell.count.text = "\(count)"
            
            return cell
        }
        return UITableViewCell()
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}
