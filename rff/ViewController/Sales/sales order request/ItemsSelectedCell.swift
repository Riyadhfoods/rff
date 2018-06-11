//
//  ItemsSelectedCell.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 07/06/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class ItemsSelectedCell: UITableViewCell {

    @IBOutlet weak var num: UILabel!
    @IBOutlet weak var itemId: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var showPCSPickerTextField: UITextField!
    @IBOutlet weak var PCSTextfield: UITextField!
    @IBOutlet weak var qtyTextfield: UITextField!
    @IBOutlet weak var unitPriceTextfield: UITextField!
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var holderView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        holderView.layer.cornerRadius = 5.0
        holderView.layer.borderColor = UIColor(red: 105/255, green: 132/255, blue: 92/255, alpha: 1.0).cgColor
        holderView.layer.borderWidth = 1
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
