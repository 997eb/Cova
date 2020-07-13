//
//  billCell.swift
//  Cova
//
//  Created by Ebtsam alkhuzai on 14/09/1441 AH.
//  Copyright © 1441 Ebtsam alkhuzai. All rights reserved.
//

import UIKit

class billCell: UITableViewCell {
    
    @IBOutlet weak var itemQuantity: UILabel!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
    viewBill.layer.cornerRadius = 10
 
    }
    
    @IBOutlet weak var deleteMenu: UIButton!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var quantity: UILabel!
    @IBOutlet weak var menuName: UILabel!
    @IBOutlet weak var viewBill: UIView!
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
