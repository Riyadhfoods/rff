//
//  SalesOrderApprovalViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 26/08/1439 AH.
//  Copyright © 1439 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class SalesOrderApprovalViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // -- MARK: IBOutlets
    
    @IBOutlet weak var menuBtn: UIBarButtonItem!
    @IBOutlet weak var salesOrdertableview: UITableView!
    
    // -- MAKR: Variables
    
    let screenSize = AppDelegate().screenSize
    let cellId = "cell_salesOrderApproval"
    let webService = Sales()
    var salesOrderDetails: [SalesModel] = [SalesModel]()
    
    // -- MARK: viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let userId = AuthServices.currentUserId{
            if let userIdInt = Int(userId){
                salesOrderDetails = webService.SalesOrder(empno: userIdInt)
            }
        }
        sideMenus()
    }
    
    // -- MARK: Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if salesOrderDetails.count == 0{
            emptyMessage(message: "No Data", viewController: self, tableView: salesOrdertableview)
        }
        return salesOrderDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? SalesOrderApprovalCell{
            cell.orderId.text = salesOrderDetails[indexPath.row].OrderID
            cell.empCreated.text = salesOrderDetails[indexPath.row].SO_EmpCreated
            cell.customerName.text = salesOrderDetails[indexPath.row].SO_CustomerName
            cell.items.text = salesOrderDetails[indexPath.row].SO_Items
            cell.date.text = salesOrderDetails[indexPath.row].DeliveryDate
            cell.status.text = salesOrderDetails[indexPath.row].SO_Status
            cell.comment.text = salesOrderDetails[indexPath.row].SO_Comment
            
            return cell
        }
        return UITableViewCell()
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
    
    // -- MARK: IBActions
    
    @IBAction func signOutBuuttonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}
