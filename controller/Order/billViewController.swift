//
//  billViewController.swift
//  Cova
//
//  Created by Ebtsam alkhuzai on 14/09/1441 AH.
//  Copyright © 1441 Ebtsam alkhuzai. All rights reserved.
//

import UIKit
import SVProgressHUD


class billViewController: UIViewController {
    
    
    @IBOutlet weak var location: UILabel!
    var itemsObj = Items()
    var items: [String] = []
    var quantity: [Int] = []
    var prices: [Int] = []
    @IBOutlet weak var deliveryTime: UILabel!
    @IBOutlet weak var currentDay: UILabel!
    @IBOutlet weak var totalDeliveryPrice: UILabel!
    @IBOutlet weak var itemsTotalPrice: UILabel!
    @IBOutlet weak var deliveryAddress: UILabel!
    @IBOutlet weak var storeName: UILabel!
    @IBOutlet weak var billLabelView: UIView!
    @IBOutlet weak var deliveryLabelView: UIView!
    @IBOutlet weak var deliveryView: UIView!
    
    
    @IBOutlet weak var height: NSLayoutConstraint!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var billView: UIView!
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableview.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        tableview.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        self.tableview.removeObserver(self, forKeyPath: "contentSize")
        
    }
    
    override  func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        
        if keyPath == "contentSize" {
            
            if let newValue = change?[.newKey]{
                let newSize = newValue as! CGSize
                self.height.constant = newSize.height
                
            }
        }
    }
    
    @IBAction func submitTheOrder(_ sender: Any) {
        
        
        let quantityItems = itemsObj.getOrder()
        
        API.orderAPI(quantityItems:quantityItems) {(error:Error?, done: Bool?) in
            
            if  done == true {
                self.performSegue(withIdentifier: "done", sender: nil)
                self.navigationController?.setNavigationBarHidden(true, animated: true)
                
            }else {
                SVProgressHUD.showError(withStatus:"عذرا, لايمكن اتمام الطلب")
            }
            
            self.clearCart()
            
        }
        
    }
    
    func clearCart(){
        let def = UserDefaults.standard
        
        def.removeObject(forKey: "order")
        def.removeObject(forKey: "storeID_Menu")
        def.removeObject(forKey: "itemName")
        def.removeObject(forKey: "items")
        def.removeObject(forKey: "prices")
        def.removeObject(forKey: "total")
        def.removeObject(forKey: "quantity")
        def.removeObject(forKey: "itemQuantity")
        
    }
    
    func mapItemQuantity() -> [Order.items]{
        
        let quantityArr = itemsObj.getquantity()
        let itemArr = itemsObj.getItems()
        var quantityItems = [Order.items]()
        
        for (id, quantity) in zip(itemArr, quantityArr) {
            
            
            let orders = Order.items(menu_item_id: id , quantity: quantity, choices: [])
            quantityItems.append(orders)
        }
        return quantityItems
    }
    
    
    func combinePrices() -> Int{
        
        let priceArr = self.itemsObj.getRricesArray()
        var total:Int = 0
        for price in priceArr {
            total = price + total
        }
        return total
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var date = Date()
        
        let format = DateFormatter()
        format.dateFormat = "EEEE, MMM d, yyyy"
        format.locale = Locale(identifier: "ar")
        let formattedDate = format.string(from: date)
        self.currentDay.text = formattedDate
        
        let format2 = DateFormatter()
        format2.dateFormat = "HH:mm a"
        format2.locale = Locale(identifier: "en")
        date.addTimeInterval(60 * 60)
        let formattedDate2 = format2.string(from: date)
        self.deliveryTime.text = formattedDate2
        
        self.location.text = "\(userSetting.getCityLocation()!) - \(userSetting.getStreetLocation()!)"
        
        
        self.items = itemsObj.getItemsNames()
        self.quantity = itemsObj.getquantity()
        self.prices = itemsObj.getRricesArray()
        
        let total = self.combinePrices() + 5
        self.totalDeliveryPrice.text = "\(total)"
        self.storeName.text = Stores.getStoreName()
        self.itemsTotalPrice.text = "\(self.combinePrices())"
        
        billLabelView.layer.cornerRadius = 10
        billLabelView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        deliveryLabelView.layer.cornerRadius = 10
        deliveryLabelView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        deliveryView.layer.cornerRadius = 10
        deliveryView.layer.shadowColor = UIColor.lightGray.cgColor
        deliveryView.layer.shadowOpacity = 0.2
        deliveryView.layer.shadowRadius = 1
        deliveryView.layer.shadowOffset = .zero
        deliveryView.layer.shadowPath = UIBezierPath(rect: deliveryView.bounds).cgPath
        deliveryView.layer.shouldRasterize = true
        
        billView.layer.cornerRadius = 10
        billView.layer.shadowColor = UIColor.lightGray.cgColor
        billView.layer.shadowOpacity = 0.2
        billView.layer.shadowRadius = 1
        billView.layer.shadowOffset = .zero
        billView.layer.shadowPath = UIBezierPath(rect: billView.bounds).cgPath
        billView.layer.shouldRasterize = true
        
        
        tableview.isScrollEnabled = false
        tableview.layoutIfNeeded()
        
        
    }
    
}

extension billViewController:UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
        
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if  let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? billCell {
            
            cell.itemName.text = "\(self.items[indexPath.row])"
            cell.itemPrice.text = "\(self.prices[indexPath.row])"
            cell.itemQuantity.text = " الكمية: \(self.quantity[indexPath.row])"
            return cell
        }
        
        return UITableViewCell()
    }
    
    
}
