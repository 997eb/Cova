//
//  TypeCell.swift
//  Cova
//
//  Created by Ebtsam alkhuzai on 24/08/1441 AH.
//  Copyright © 1441 Ebtsam alkhuzai. All rights reserved.
//

import UIKit

class TypeCell: UICollectionViewCell {
    
    @IBOutlet weak var containerView: UIView!
    // @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var TypeImg: UIImageView!

   
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = 10
        containerView.layer.borderWidth = 0.5
        containerView.layer.borderColor = UIColor.gray.cgColor
       // TypeImg.image = UIImage(named: "food.png")
        

    }
    
    override var isSelected: Bool{
        willSet{
            super.isSelected = newValue
            
            if newValue
            {
                
            containerView.backgroundColor = UIColor(rgb: 0x45193e)
                type.textColor = UIColor.white
               // TypeImg.image = UIImage(named: "food-2.png")
                
            }
            else
            {
                containerView.backgroundColor = UIColor.clear
                type.textColor = UIColor.gray
               // TypeImg.image = UIImage(named: "food.png")
            }
        }
    }
    
    
}
