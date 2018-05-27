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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    // -- MARK: Helper functions:
    func emptyMessage(message:String, viewController:UITableViewController) {
        let rect = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: self.view.bounds.size.width, height: self.view.bounds.size.height))
        let messageLabel = UILabel(frame: rect)
        messageLabel.text = message
        messageLabel.textColor = mainBackgroundColor
        messageLabel.backgroundColor = .clear
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont.systemFont(ofSize: 20)
        messageLabel.sizeToFit()
        
        viewController.tableView.backgroundView = messageLabel;
        viewController.tableView.separatorStyle = .none;
    }

    // -- MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if arrayOfInboxGrid.count == 0 {
            emptyMessage(message: "No data", viewController: self)
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
            
            cell.empId.text = emp_id
            cell.empName.text = emp_name
            cell.date.text = date
            
            return cell
        }

        // Configure the cell...

        return UITableViewCell()
    }

}
