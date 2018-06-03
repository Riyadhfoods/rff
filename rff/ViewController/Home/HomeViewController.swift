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
        navigationItem.title = getString(englishString: "Home", arabicString: "الرئيسية", language: language)
        
        view.backgroundColor = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1.0)
        sideMenus()
    }
    
    // -- MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if taskInbox.count == 0 {
            emptyMessage(message: getString(englishString: "No data", arabicString: "لا توجد بيانات", language: language), viewController: self, tableView: pendingInboxTableview)
        }
        return taskInbox.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cell_id, for: indexPath) as? PendingInboxCell{
            cell.contentView.backgroundColor = UIColor.clear
            
            let english_description = taskInbox[indexPath.row].EnglishDes
            let arabic_description = taskInbox[indexPath.row].ArabicDesc
            let count = taskInbox[indexPath.row].Count
            
            cell.englishDescriptionLeft.text = getString(englishString: english_description, arabicString: "الوصف بالانجليزي:", language: language)
            cell.arabicDescriptionLeft.text = getString(englishString: arabic_description, arabicString: "الوصف بالعربي:", language: language)
            cell.countLeft.text = getString(englishString: "\(count)", arabicString: "العدد:", language: language)
            cell.englishDescriptionRight.text = getString(englishString: "English Description:", arabicString: english_description, language: language)
            cell.arabicDescriptionRight.text = getString(englishString: "Arabic Description:", arabicString: arabic_description, language: language)
            cell.countRight.text = getString(englishString: "Count:", arabicString: "\(count)", language: language)
            cell.viewButton.setTitle(getString(englishString: "CLICK TO VIEW", arabicString: "اضغط للعرض", language: language), for: .normal)
            
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
