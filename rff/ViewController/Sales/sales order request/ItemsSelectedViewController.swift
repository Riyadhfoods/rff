//
//  ItemsSelectedViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 07/06/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class ItemsSelectedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // -- MARK: IBOutlets
    
    @IBOutlet weak var itemsTableView: UITableView!
    
    // -- MARK: Variables
    
    let cellId = "cell_addedItem"
    
    // -- MARk: viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // -- MARK: Tableview data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? ItemsSelectedCell{
            
            return cell
        }
        return UITableViewCell()
    }
    
    // -- MARK: IBOutlets
    
    @IBAction func sendButtonTapped(_ sender: Any) {
    }
    
}
