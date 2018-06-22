//
//  ItemsSelectedViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 07/06/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

protocol ItemCountAddedDelegate {
    func setCount(count: Int)
    func itemsArrayReceived(itemsArray: [ItemsModul])
}

class ItemsSelectedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // -- MARK: IBOutlets
    
    @IBOutlet weak var itemsTableView: UITableView!
    
    // -- MARK: Variables
    
    let cellId = "cell_addedItem"
    let webservice = Sales()
    var count: Int = 0
    var delegate: ItemCountAddedDelegate?
    var itemsArray = [ItemsModul]()
    var unoits = [SalesModel]()
    
    // -- MARk: viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setDelegate()
    }
    
    func setDelegate(){
        if delegate != nil{
            delegate?.setCount(count: itemsArray.count)
            delegate?.itemsArrayReceived(itemsArray: itemsArray)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // -- MARK: Tableview data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? ItemsSelectedCell{
            cell.unoits = webservice.BindSalesOrderUnitofMeasure(itemid: itemsArray[indexPath.row].Grid_Desc)
            
            cell.num.text = "\(indexPath.row + 1)"
            cell.desc.text = itemsArray[indexPath.row].Grid_Desc
            cell.PCSTextfield.text = itemsArray[indexPath.row].Grid_UOM
            cell.qtyTextfield.text = itemsArray[indexPath.row].Grid_Qty
            cell.unitPriceTextfield.text = itemsArray[indexPath.row].Grid_UnitPrice
            cell.totalPrice.text = itemsArray[indexPath.row].Grid_TotalPrice
            cell.deleteButton.tag = indexPath.row
            cell.deleteButton.addTarget(self, action: #selector(handleDeleteAction(sender:)), for: .touchUpInside)
            
            return cell
        }
        return UITableViewCell()
    }
    
    @objc func handleDeleteAction(sender: UIButton){
        itemsArray.remove(at: sender.tag)
        itemsTableView.reloadData()
        setDelegate()
    }
    
    // -- MARK: IBOutlets
    
    @IBAction func sendButtonTapped(_ sender: Any) {
        print(itemsArray.count)
        var itemsInXml: String = "<xml>\n"
        for item in itemsArray{
            itemsInXml += " <row>\n"
            itemsInXml += "     <Grid_ItemId>\(item.Grid_ItemId)</Grid_ItemId>\n"
            itemsInXml += "     <Grid_Desc>\(item.Grid_Desc)</Grid_Desc>\n"
            itemsInXml += "     <Grid_UOM>\(item.Grid_UOM)</Grid_UOM>\n"
            itemsInXml += "     <Grid_Qty>\(item.Grid_Qty)</Grid_Qty>\n"
            itemsInXml += "     <Grid_UnitPrice>\(item.Grid_UnitPrice)</Grid_UnitPrice>\n"
            itemsInXml += "     <Grid_TotalPrice>\(item.Grid_TotalPrice)</Grid_TotalPrice>\n"
            itemsInXml += " </row>\n"
        }
        itemsInXml += "</xml>"
        print(itemsInXml)
    }
}

extension ItemsSelectedViewController{
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addObservers(onShow: { frame in
            let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: frame.height - 81, right: 0)
            self.itemsTableView.contentInset = contentInset
        }, onHide: { _ in
            self.itemsTableView.contentInset = UIEdgeInsets.zero
        })
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeObservers()
    }
}













