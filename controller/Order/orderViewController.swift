//
//  orderViewController.swift
//  Cova
//
//  Created by Ebtsam alkhuzai on 01/09/1441 AH.
//  Copyright © 1441 Ebtsam alkhuzai. All rights reserved.
//

import UIKit

protocol orderViewControllerDelegate : class  {
    
    func passConfirmed(confirmed: Bool ,storeID: Int , totalPrice: Int , quantityCounter:Int, itemID: Int, itemName:String, choices:[Order.items.choices])
    
}


class orderViewController: UIViewController , UITableViewDelegate,UITableViewDataSource{
    
    
    @IBOutlet weak var cancelView: UIView!
    @IBAction func cancel(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var priceLabel: UILabel!
    var menuImgL:String = ""
    
    @IBOutlet weak var tableview: UITableView!
    
    var delegate:orderViewControllerDelegate?
    
    var choices = [Order.items.choices]()
    var item = Items()
    var additions = [MenuD.Groups]()
    var choicesItems = [Int]()
    
    var totalPrice:Int = 0
    var itemID : Int = 0
    var quantityCounter:Int = 1
    var quantityArr =  [Int:Int]()
    var quantity:Int = 0
    
    var menuItemLabel:String = ""
    var itemDescriptionLabel:String = ""
    
    @IBOutlet weak var addIItemView: UIView!
    @IBOutlet weak var quantityText: UILabel!
    var itemPrice:Int = 0
    
    var largePrice:Int = 21
    var mediumPrice:Int = 17
    var smallprice:Int = 13
    
    var storeId: Int = 0
    
    @IBOutlet weak var quantitySubtract: UIButton!
    @IBOutlet weak var quantityAdd: UIButton!
    @IBOutlet weak var itemDescription: UILabel!
    @IBOutlet weak var menuItem: UILabel!
    @IBOutlet weak var menuImg: UIImageView!
    @IBOutlet weak var orderView: UIView!
    @IBOutlet weak var coffeeAdditiions: UICollectionView!
    @IBOutlet weak var small: UIView!
    @IBOutlet weak var medium: UIView!
    @IBOutlet weak var large: UIView!
    @IBOutlet weak var smallPriceLabel: UILabel!
    @IBOutlet weak var smallLabel: UILabel!
    @IBOutlet weak var largePriceLabel: UILabel!
    @IBOutlet weak var largeLabel: UILabel!
    @IBOutlet weak var mediumPriceLabel: UILabel!
    @IBOutlet weak var mediumLabel: UILabel!
    
    @IBOutlet weak var quantityView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableview.tableFooterView = UIView()
        tableview.separatorInset = .zero
        tableview.contentInset = .zero
        tableview.separatorStyle = .none
        tableview.allowsMultipleSelection = true
        
        
        self.quantityText.text = "\(self.quantityCounter)"
        
        
        //assign the values ..
        menuItem.text = self.menuItemLabel
        itemDescription.text = self.itemDescriptionLabel
        self.priceLabel.text = "\(self.itemPrice)"
        self.totalPrice = self.itemPrice
        
        cancelView.layer.borderWidth = 0.5
        cancelView.layer.masksToBounds = false
        cancelView.layer.cornerRadius = quantitySubtract.frame.height/2
        cancelView.clipsToBounds = true
        
        quantitySubtract.layer.borderWidth = 0
        quantitySubtract.layer.masksToBounds = false
        quantitySubtract.layer.cornerRadius = quantitySubtract.frame.height/2
        quantitySubtract.clipsToBounds = true
        
        quantityAdd.layer.borderWidth = 0
        quantityAdd.layer.masksToBounds = false
        
        quantityAdd.layer.cornerRadius = quantityAdd.frame.height/2
        quantityAdd.clipsToBounds = true
        
        addIItemView.layer.cornerRadius = 10
        
        menuImg.downloaded(from: menuImgL)
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return additions.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return additions[section].menu_item_choices.count
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width - 15 , height: 40))
        view.backgroundColor =  .white
        let lbl = UILabel(frame:CGRect(x: 15, y: 0, width: view.frame.width - 15 , height: 40))
        lbl.text = additions[section].title
        
        lbl.textAlignment = .right
        view.addSubview(lbl)
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! OrderaCell
        
        cell.additionName.text = additions[indexPath.section].menu_item_choices[indexPath.row].title
        
        cell.additionPrice.text = "\(additions[indexPath.section].menu_item_choices[indexPath.row].price)"
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell:OrderaCell = tableView.cellForRow(at: indexPath) as! OrderaCell
        cell.check.setImage(UIImage(named: "check-mark.png"), for: .normal)
        
        self.totalPrice = self.totalPrice + additions[indexPath.section].menu_item_choices[indexPath.row].price
        
        
        self.priceLabel.text = ("\(self.totalPrice)")
        let choice =  Order.items.choices.init(menu_item_choice_id: additions[indexPath.section].menu_item_choices[indexPath.row].id)
            self.choices.append(choice)
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell:OrderaCell = tableView.cellForRow(at: indexPath) as! OrderaCell
        cell.check.setImage(UIImage(named: "check-mark-3"), for: .normal)
        self.totalPrice = self.totalPrice -  additions[indexPath.section].menu_item_choices[indexPath.row].price
        self.priceLabel.text = ("\(self.totalPrice)")

        let choice =  Order.items.choices.init(menu_item_choice_id: additions[indexPath.section].menu_item_choices[indexPath.row].id)
        
        if let index = self.choices.firstIndex(of: choice) {
            self.choices.remove(at: index)
        }
        
      
    }
    
    @IBAction func addQuantity(_ sender: Any) {
        
        self.quantityCounter += 1;
        self.totalPrice = self.totalPrice + self.itemPrice
        self.priceLabel.text = "\(totalPrice)"
        self.quantityText.text = "\(self.quantityCounter)"
        
    }
    
    @IBAction func subtractQuantitiy(_ sender: Any) {
        
        if quantityCounter != 1 {
            self.quantityCounter -= 1;
             self.totalPrice = self.totalPrice - itemPrice
        }
            self.quantityText.text = "\(self.quantityCounter)"
            self.priceLabel.text = "\(self.totalPrice)"
      
    }
    
    @IBAction func addItem(_ sender: Any) {
        
        if let delegate = self.delegate {
            
            delegate.passConfirmed(confirmed: true ,storeID: self.storeId , totalPrice: self.totalPrice ,quantityCounter:self.quantityCounter , itemID: self.itemID, itemName: self.menuItemLabel, choices: self.choices)
            
            dismiss(animated: true, completion: nil)
            
        }
    }
}
