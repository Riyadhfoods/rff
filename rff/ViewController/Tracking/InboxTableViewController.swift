//
//  InboxTableViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 27/08/1439 AH.
//  Copyright © 1439 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class InboxTableViewController: UITableViewController {

    let cellId = "trackingInboxCell"
    var arrayOfInboxGrid = [InboxGrid]()
    var listIndexSelected: Int = 0
    var categoryIndexSelected: Int = 0
    
    let mainBackgroundColor = AppDelegate().mainBackgroundColor
    var navTitle: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set title for nav bar
        setCustomNav(navItem: navigationItem, title: navTitle)
        
        //Geting array of inbox elements
        setupArrayOfInboxGrid()
        
        view.backgroundColor = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1.0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // -- MARK: set ups
    
    func setupArrayOfInboxGrid(){
        if let currentUserId = AuthServices.currentUserId{
            if let currentUserIdInt = Int(currentUserId){
                arrayOfInboxGrid = Login().SearchInbox(empid: currentUserIdInt, formid: String(listIndexSelected), drpdwnvalue: String(categoryIndexSelected), search: "", langid: LoginViewController.languageChosen)
            }
        }
    }

    // -- MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if arrayOfInboxGrid.count == 0 {
            emptyMessage(message: "No data", viewController: self, tableView: self.tableView)
        }
        return arrayOfInboxGrid.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? InboxTableViewCell {
            
            cell.holderView.layer.cornerRadius = 5.0
            cell.holderView.layer.borderColor = UIColor(red: 105/255, green: 132/255, blue: 92/255, alpha: 1.0).cgColor
            cell.holderView.layer.borderWidth = 1
            
            cell.contentView.backgroundColor = UIColor.clear
            
            let emp_id = arrayOfInboxGrid[indexPath.row].empid
            let emp_name = arrayOfInboxGrid[indexPath.row].empname
            let date = arrayOfInboxGrid[indexPath.row].date
            
            if LoginViewController.languageChosen == 1 {
                cell.empIdEnglish.text = emp_id
                cell.empNameEnglish.text = emp_name
                cell.dateEnglish.text = date
                cell.viewForm.setTitle("VIEW FORM", for: .normal)
                
                cell.empIdArabic.text = "Emp ID:"
                cell.empNameArabic.text = "Emp Name:"
                cell.dateArabic.text = "Date:"
            } else {
                cell.empIdEnglish.text = "رقم الموظف"
                cell.empNameEnglish.text = "اسم الموظف"
                cell.dateEnglish.text = "التاريخ"
                
                cell.empIdArabic.text = emp_id
                cell.empNameArabic.text = emp_name
                cell.dateArabic.text = date
                cell.viewForm.setTitle("عرض النموذج", for: .normal)
            }
            
            
            return cell
        }

        // Configure the cell...

        return UITableViewCell()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}
