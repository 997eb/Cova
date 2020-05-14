//
//  coffeeStoreaTableViewCell.swift
//  Cova
//
//  Created by Ebtsam alkhuzai on 21/08/1441 AH.
//  Copyright © 1441 Ebtsam alkhuzai. All rights reserved.
//

import UIKit

class coffeeStoreaTableViewCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        header.layer.cornerRadius = 10
        header.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        cellView.layer.cornerRadius = 10
        cellView.layer.shadowColor = UIColor.lightGray.cgColor
        cellView.layer.shadowOpacity = 0.2
        cellView.layer.shadowRadius = 1
        cellView.layer.shadowOffset = .zero
        cellView.layer.shadowPath = UIBezierPath(rect: cellView.bounds).cgPath
        cellView.layer.shouldRasterize = true
        
        logo.layer.borderWidth = 1
        logo.layer.masksToBounds = false
        logo.layer.borderColor = UIColor.black.cgColor
        logo.layer.cornerRadius = logo.frame.height/2
        logo.clipsToBounds = true
        
    }
    
    
    
    @IBOutlet weak var storeName: UILabel!
    @IBOutlet weak var tagLine: UILabel!
    @IBOutlet weak var Time: UILabel!
    @IBOutlet weak var header: UIImageView!
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var cellView: UIView!
    
}
