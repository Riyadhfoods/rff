//
//  TansferStyleTableViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 06/06/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class TansferStyleTableViewController: UITableViewController {

    // -- MARK: Variables
    
    let cellId = "cell_transferStyle"
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
        setCustomNav(navItem: navigationItem, title: "Transfer List")
        view.backgroundColor = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1.0)
        
        print(salesArray.count)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? TransferStyleCell{
            
            let id = "\(salesArray[indexPath.row].ID)"
            let empCreated = salesArray[indexPath.row].EmpCreated
            let date = salesArray[indexPath.row].date
            let items = salesArray[indexPath.row].Items
            let status = salesArray[indexPath.row].Status
            let pendingBy = salesArray[indexPath.row].PendingBy
            let comment = salesArray[indexPath.row].Comment
            
            cell.idTitle.text = getString(englishString: "ID", arabicString: "انشاء الموظف" , language: languageChosen)
            cell.idLabel.text = getString(englishString: id, arabicString: empCreated, language: languageChosen)
            cell.empCreatedTitle.text = getString(englishString: "Emp Created", arabicString: "الرقم", language: languageChosen)
            cell.empCreatedLabel.text = getString(englishString: empCreated, arabicString: id, language: languageChosen)
            cell.dateTitle.text = getString(englishString: "Date", arabicString: "الاصناف", language: languageChosen)
            cell.dateLabel.text = getString(englishString: date, arabicString: items, language: languageChosen)
            cell.itemsTitle.text = getString(englishString: "Items", arabicString: "التاريخ", language: languageChosen)
            cell.itemsLabel.text = getString(englishString: items, arabicString: date, language: languageChosen)
            cell.statusTitle.text = getString(englishString: "Status", arabicString: status, language: languageChosen)
            cell.statusLabel.text = getString(englishString: status, arabicString: "الحاله", language: languageChosen)
            cell.pendingByTitle.text = getString(englishString: "PendingBy", arabicString: "معلق من", language: languageChosen)
            cell.pendingByLabel.text = pendingBy
            cell.commentTitle.text = getString(englishString: "Comment", arabicString: "ملاحظات", language: languageChosen)
            cell.commentLabel.text = comment
            
            cell.selectOutlet.addTarget(self, action: #selector(selectButtonTapped(sender:)), for: .touchUpInside)
            cell.selectOutlet.tag = indexPath.row
            
            urlString.append(salesArray[indexPath.row].URL)
            
            return cell
        }
        return UITableViewCell()
    }
    
    @objc func selectButtonTapped(sender: UIButton){
        rowIndexSelected = sender.tag
        performSegue(withIdentifier: "showTransferWeb", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? SalesInboxWebPageViewController{
            vc.urlString = self.urlString[rowIndexSelected]
        }
    }

}
