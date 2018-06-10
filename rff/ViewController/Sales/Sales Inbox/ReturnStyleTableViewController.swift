//
//  JannatStyleTableViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 06/06/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class ReturnStyleTableViewController: UITableViewController {
    
    // -- MARK: Variables
    
    let cellId = "cell_returnStyle"
    var listIndexSelected: Int = 0
    var searchMessage: String = ""
    let salesWebservice: Sales = Sales()
    var salesArray: [SalesModel] = [SalesModel]()
    var urlString: [String] = [String]()
    var rowIndexSelected = 0
    
    let languageChosen = LoginViewController.languageChosen
    
    // -- MARK: viewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()
        setCustomNav(navItem: navigationItem, title: "Return List")
        view.backgroundColor = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1.0)

        print(salesArray.count)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // -- MARK: Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return salesArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? ReturnStyleCell{
            
            cell.idLabel.text = "\(salesArray[indexPath.row].ID)"
            cell.empCreatedLabel.text = salesArray[indexPath.row].EmpCreated
            cell.itemsLabel.text = salesArray[indexPath.row].Items
            cell.requestDateLabel.text = salesArray[indexPath.row].RequestDate
            cell.returnDateLabel.text = salesArray[indexPath.row].ReturnDate
            cell.statusLabel.text = salesArray[indexPath.row].Status
            cell.pendingByLabel.text = salesArray[indexPath.row].PendingBy
            cell.commentLabel.text = salesArray[indexPath.row].Comment
            cell.viewOutlet.addTarget(self, action: #selector(viewButtonTapped(sender:)), for: .touchUpInside)
            cell.viewOutlet.tag = indexPath.row
            
            urlString.append(salesArray[indexPath.row].URL)
            
            let id = "\(salesArray[indexPath.row].ID)"
            let empCreated = salesArray[indexPath.row].EmpCreated
            let items = salesArray[indexPath.row].Items
            let reqDate = salesArray[indexPath.row].date
            let rtnDate = salesArray[indexPath.row].date
            let status = salesArray[indexPath.row].Status
            let pendingBy = salesArray[indexPath.row].PendingBy
            let comment = salesArray[indexPath.row].Comment
            
            cell.idTitle.text = getString(englishString: "ID", arabicString: "الاصناف" , language: languageChosen)
            cell.idLabel.text = getString(englishString: id, arabicString: items, language: languageChosen)
            cell.empCreatedTitle.text = getString(englishString: "Emp Created", arabicString: "انشاء الموظف", language: languageChosen)
            cell.empCreatedLabel.text = getString(englishString: empCreated, arabicString: id, language: languageChosen)
            cell.itemsTitle.text = getString(englishString: "Items", arabicString: "الرقم", language: languageChosen)
            cell.itemsLabel.text = getString(englishString: items, arabicString: id, language: languageChosen)
            
            cell.requestDateTitle.text = getString(englishString: "Request Date", arabicString: "الرقم", language: languageChosen)
            cell.requestDateLabel.text = getString(englishString: reqDate, arabicString: rtnDate, language: languageChosen)
            cell.returnDateTitle.text = getString(englishString: "Return Date", arabicString: "الاصناف", language: languageChosen)
            cell.returnDateLabel.text = getString(englishString: rtnDate, arabicString: reqDate, language: languageChosen)
            
            cell.statusTitle.text = getString(englishString: "Status", arabicString: status, language: languageChosen)
            cell.statusLabel.text = getString(englishString: status, arabicString: "الحاله", language: languageChosen)
            cell.pendingByTitle.text = getString(englishString: "PendingBy", arabicString: "معلق من", language: languageChosen)
            cell.pendingByLabel.text = pendingBy
            cell.commentTitle.text = getString(englishString: "Comment", arabicString: "ملاحظات", language: languageChosen)
            cell.commentLabel.text = comment
            
            cell.viewOutlet.addTarget(self, action: #selector(viewButtonTapped(sender:)), for: .touchUpInside)
            cell.viewOutlet.tag = indexPath.row
            
            urlString.append(salesArray[indexPath.row].URL)
            
            return cell
        }
        return UITableViewCell()
    }
 
    @objc func viewButtonTapped(sender: UIButton){
        rowIndexSelected = sender.tag
        performSegue(withIdentifier: "showReturnWeb", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? SalesInboxWebPageViewController{
            vc.urlString = self.urlString[rowIndexSelected]
        }
    }
}
