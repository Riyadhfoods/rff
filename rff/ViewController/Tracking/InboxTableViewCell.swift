//
//  InboxTableViewCell.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 27/08/1439 AH.
//  Copyright © 1439 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class InboxTableViewCell: UITableViewCell {

    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var InnerHolderView: UIView!
    @IBOutlet weak var empId: UILabel!
    @IBOutlet weak var empName: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var viewForm: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
