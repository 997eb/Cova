//
//  menuCell.swift
//  Cova
//
//  Created by Ebtsam alkhuzai on 24/08/1441 AH.
//  Copyright © 1441 Ebtsam alkhuzai. All rights reserved.
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
        
   /*view.layer.cornerRadius = 10
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.shadowOpacity = 0.3
        view.layer.shadowRadius = 1
        view.layer.shadowOffset = .zero
        view.layer.shadowPath = UIBezierPath(rect: view.bounds).cgPath
        view.layer.shouldRasterize = true
*/
    }
    
 
}
