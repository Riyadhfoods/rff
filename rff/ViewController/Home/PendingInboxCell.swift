//
//  PendingInboxCell.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 13/09/1439 AH.
//  Copyright © 1439 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class PendingInboxCell: UITableViewCell {
    @IBOutlet weak var englishDescription: UILabel!
    @IBOutlet weak var arabicDescription: UILabel!
    @IBOutlet weak var count: UILabel!
    @IBOutlet weak var holderView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
