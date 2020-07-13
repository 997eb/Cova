//
//  coffeeStoreaTableViewCell.swift
//  Cova
//
//  Created by Ebtsam alkhuzai on 21/08/1441 AH.
//  Copyright © 1441 Ebtsam alkhuzai. All rights reserved.


import UIKit

class coffeeStoreaTableViewCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        

        header.layer.cornerRadius = 10
        header.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        cellView.layer.cornerRadius = 10
      
        
        logo.layer.borderWidth = 1
        logo.layer.masksToBounds = false
        logo.layer.borderWidth = 0.1
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
