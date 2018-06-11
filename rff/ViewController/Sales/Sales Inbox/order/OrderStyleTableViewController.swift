//
//  OrderStyleTableViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 06/06/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class OrderStyleTableViewController: UITableViewController {

    // -- MARK: Variables
    
    let cellId = "cell_orderStyle"
    let cellId_pages = "cell_pages"
    var listIndexSelected: Int = 0
    var searchMessage: String = ""
    let salesWebservice: Sales = Sales()
    
    var salesArray: [SalesModel] = [SalesModel]()
    var newSalesArray: [SalesModel] = [SalesModel]()
    var preSalesArray: [SalesModel] = [SalesModel]()
    
    var urlString: [String] = [String]()
    var rowIndexSelected = 0
    
    let languageChosen = LoginViewController.languageChosen
    
    var currentIndex: Int = 0
    var previousIndex: Int = 0
    var totalRow = 0
    var currentRow = "0"
    var isSalesArrayEmpty = true
    
    var lastIndex: Int = 0
    var reminder: Int = 0
    
    // -- MARK: viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCustomNav(navItem: navigationItem, title: "Order List")
        view.backgroundColor = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1.0)
        
        preSalesArray = salesArray
        
        if salesArray.count != 0 {
            isSalesArrayEmpty = false
            totalRow = salesArray[0].totalrows
            currentRow = salesArray[0].currentrows
        }
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
        if isSalesArrayEmpty{
            emptyMessage(message: "No Data", viewController: self, tableView: tableView)
            return salesArray.count
        }
        return salesArray.count + 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == salesArray.count {
            if let cell = tableView.dequeueReusableCell(withIdentifier: cellId_pages, for: indexPath) as? OrderPagesCell{
                if isSalesArrayEmpty{
                    return UITableViewCell()
                }
                cell.firstPage.addTarget(self, action: #selector(firstButtonTapped), for: .touchUpInside)
                cell.previousPage.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
                cell.nextPage.addTarget(self, action: #selector(forwardButtonTapped), for: .touchUpInside)
                cell.lastPage.addTarget(self, action: #selector(lastButtonTapped), for: .touchUpInside)
                
                cell.pageNum.text = "\(currentRow) out of \(totalRow)"
                
                return cell
            }
        } else if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? OrderStyleCell{
            print(indexPath.row)
            let id = "\(salesArray[indexPath.row].ID)"
            let empCreated = salesArray[indexPath.row].EmpCreated
            let date = salesArray[indexPath.row].date
            let items = salesArray[indexPath.row].Items
            let status = salesArray[indexPath.row].Status
            let pendingBy = salesArray[indexPath.row].PendingBy
            let comment = salesArray[indexPath.row].Comment
            let customerName = salesArray[indexPath.row].CustomerName
            
            cell.idTitle.text = getString(englishString: "ID", arabicString: "انشاء الموظف" , language: languageChosen)
            cell.idLabel.text = getString(englishString: id, arabicString: empCreated, language: languageChosen)
            cell.empCreatedTitle.text = getString(englishString: "Emp Created", arabicString: "الرقم", language: languageChosen)
            cell.empCreatedLabel.text = getString(englishString: empCreated, arabicString: id, language: languageChosen)
            cell.custNameTitle.text = getString(englishString: "Customer Name", arabicString: "اسم العميل", language: languageChosen)
            cell.custNameLabel.text = customerName
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
            
            cell.viewOutlet.addTarget(self, action: #selector(viewButtonTapped(sender:)), for: .touchUpInside)
            cell.viewOutlet.tag = indexPath.row
            
            urlString.append(salesArray[indexPath.row].URL)
            
            return cell
            
        }
        return UITableViewCell()
    }
    
    // -- MARK: objc function
    
    @objc func viewButtonTapped(sender: UIButton){
        rowIndexSelected = sender.tag
        performSegue(withIdentifier: "showOrderWeb", sender: nil)
    }
    
    @objc func firstButtonTapped(){
        if currentIndex != 0{
            currentIndex = 0
            updateTableView(currentIndex: currentIndex)
        }
    }
    
    @objc func backButtonTapped(){
        if currentIndex > 0{
            currentIndex -= 1
            updateTableView(currentIndex: currentIndex)
        }
    }
    
    @objc func forwardButtonTapped(){
        currentIndex += 1
        updateTableView(currentIndex: currentIndex)
    }
    
    @objc func lastButtonTapped(){
        (lastIndex, reminder) = (salesArray[0].totalrows).quotientAndRemainder(dividingBy: 10)
        currentIndex = lastIndex
        
        updateTableView(currentIndex: currentIndex)
    }
    
    func updateTableView(currentIndex: Int){
        if let userId = AuthServices.currentUserId{
            newSalesArray = salesWebservice.GetSalesInbox(id: listIndexSelected, emp_id: userId, searchtext: searchMessage, index: currentIndex)
            if newSalesArray.count != 0{
                currentRow = newSalesArray[0].currentrows
                salesArray = newSalesArray
                tableView.reloadData()
                
                let indexPath = IndexPath(row: 0, section: 0)
                tableView.scrollToRow(at: indexPath, at: .top, animated: true)
            } else {
                salesArray = preSalesArray
                return
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? SalesInboxWebPageViewController{
            vc.urlString = self.urlString[rowIndexSelected]
        }
    }
}












