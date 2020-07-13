//
//  menuCell.swift
//  Cova
//
//  Created by Ebtsam alkhuzai on 24/08/1441 AH.
//  Copyright © 1441 Cova. All rights reserved.
//

import UIKit

class menuCell: UICollectionViewCell {
    
    @IBOutlet weak var menuImg: UIImageView!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var typeName: UILabel!
  
    @IBOutlet weak var view: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        menuImg.layer.cornerRadius = 10
        menuImg.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]

    }
    
 
}
