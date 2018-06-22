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
    let language = LoginViewController.languageChosen
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
        navigationItem.title = "Home".localiz()
        
        view.backgroundColor = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1.0)
        
        setSlideMenu(controller: self, menuButton: menuBtn)
    }
    
    // -- MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if taskInbox.count == 0 {
            emptyMessage(message: "No data".localiz(), viewController: self, tableView: pendingInboxTableview)
        }
        return taskInbox.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cell_id, for: indexPath) as? PendingInboxCell{
            cell.contentView.backgroundColor = UIColor.clear
            
            let english_description = taskInbox[indexPath.row].EnglishDes
            let arabic_description = taskInbox[indexPath.row].ArabicDesc
            let count = taskInbox[indexPath.row].Count
            
            cell.englishDescriptionLeft.text = english_description.localiz()
            cell.arabicDescriptionLeft.text = arabic_description.localiz()
            cell.countLeft.text = "\(count)".localiz()
            
            return cell
        }
        return UITableViewCell()
    }
    
    // -- MARK: IBActions
    @IBAction func signOutBuuttonTapped(_ sender: Any) {
        AuthServices().logout(self)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}
