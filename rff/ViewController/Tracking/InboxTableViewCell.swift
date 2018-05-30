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
    @IBOutlet weak var empIdEnglish: UILabel!
    @IBOutlet weak var empNameEnglish: UILabel!
    @IBOutlet weak var dateEnglish: UILabel!
    @IBOutlet weak var viewForm: UIButton!
    
    @IBOutlet weak var empIdArabic: UILabel!
    @IBOutlet weak var empNameArabic: UILabel!
    @IBOutlet weak var dateArabic: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        if LoginViewController.languageChosen == 1 {
            changeTextAligment(textAligment: .left)
        } else {
            changeTextAligment(textAligment: .right)
        }
    }
    
    func changeTextAligment(textAligment: NSTextAlignment){
        empIdEnglish.textAlignment = textAligment
        empNameEnglish.textAlignment = textAligment
        dateEnglish.textAlignment = textAligment
        
        empIdArabic.textAlignment = textAligment
        empNameArabic.textAlignment = textAligment
        dateArabic.textAlignment = textAligment
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
