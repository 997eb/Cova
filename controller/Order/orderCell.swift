//
//  orderCell.swift
//  Cova
//
//  Created by Ebtsam alkhuzai on 01/09/1441 AH.
//  Copyright © 1441 Ebtsam alkhuzai. All rights reserved.
//

import UIKit

class orderCell: UICollectionViewCell {
    
    @IBOutlet weak var additionPrice: UILabel!
    @IBOutlet weak var additionName: UILabel!
    @IBOutlet weak var viewContainer: UIView!
    
    
    @IBOutlet weak var rs: UILabel!
    override func awakeFromNib() {
          super.awakeFromNib()
        viewContainer.layer.borderWidth = 0.5
        viewContainer.layer.borderColor = UIColor.gray.cgColor
          
    }
}
