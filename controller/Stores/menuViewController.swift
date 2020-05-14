//
//  menuViewController.swift
//  Cova
//
//  Created by Ebtsam alkhuzai on 24/08/1441 AH.
//  Copyright © 1441 Ebtsam alkhuzai. All rights reserved.
//

import UIKit


class menuViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    
    var itemObj = Items()
    var specObj = Specification()
    
    var choices = [Order.items.choices]()
    var menu = [MenuD]()
    var specification = [Specification]()
    
    var items:[Int] = []
    var quatitiyArr: [Int] = []
    var collectPrices:[Int] = []
    var itemsNames: [String] = []
    
    var lastSelectedIndexPath:IndexPath?
    var itemConfirmed:Bool = false
    var itemID : Int = 0
    var totalItemPrice: Int = 0 //for specific item
    var totalPrice: Int = 0 //for all items
    var quantity : Int = 0
    var itemName : String = ""
    
    //views from controller
    @IBOutlet weak var itemNumView: UILabel!
    @IBOutlet weak var tagLineView: UILabel!
    @IBOutlet weak var storeNameView: UILabel!
    @IBOutlet weak var itemsNumView: UIView!
    
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var header: UIImageView!
    
    @IBOutlet weak var menuCollictionView: UICollectionView!
    @IBOutlet weak var typeCollictionView: UICollectionView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var cartView: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logo.layer.masksToBounds = false
        logo.layer.cornerRadius = logo.frame.height/2
        logo.clipsToBounds = true
        
        itemsNumView.layer.masksToBounds = false
        itemsNumView.layer.cornerRadius = itemsNumView.frame.height/2
        itemsNumView.clipsToBounds = true
        
        menuCollictionView.delegate = self
        menuCollictionView.dataSource = self
        typeCollictionView.dataSource = self
        typeCollictionView.delegate = self
        
        typeCollictionView.contentInset = .zero
        menuCollictionView.contentInset = .zero
        
        updateMenu()
        downloadTypes()
    }
    
    
    
    //function to download specification for stores ..
    func downloadTypes(){
        API.specificationAPI{(error:Error?, specification: [Specification]?) in
            
            self.typeCollictionView.scrollToItem(at: NSIndexPath(item: self.specification.count - 1, section: 0) as IndexPath, at: .right, animated: false)
            
            if let specification = specification {
                
                self.specification = specification
                self.typeCollictionView.reloadData()
                
            }
            
        }
        
    }
    
    //to refresh the muenu for eact specific type
    func RefreshMenue(std:Int,spId:Int ){
        API.menuSpecAPI(Sid:std, SpeId: spId){(error:Error?, menu: [MenuD]? ) in
            
            if let menu = menu {
                self.menu = menu
                DispatchQueue.main.async {
                    self.menuCollictionView.reloadData()
                }
            }
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(true)
        
        //refresh collictions views ..
        downloadTypes()
        
        
        //prepare the interface ..
        header.downloaded(from: Stores.getStoreHeaderImg()!)
        logo.downloaded(from: Stores.getStoreLogoImg()!)
        storeNameView.text = Stores.getStoreName()
        tagLineView.text = Stores.getStoreTagLinee()
        
        //this is for chart view
        if self.itemObj.getItems().count != 0 && Stores.getStoreId() == itemObj.getMenuStoreID(){
            cartView.isHidden = false
            itemNumView.text = "\(self.itemObj.getItems().count)"
            self.priceLabel.text = "\(self.itemObj.getTotalItemPrices())"
        }
        
        
        // if true .. add item to the cart ..
        if self.itemConfirmed {
            
            
            self.collectPrices = self.itemObj.getRricesArray()
            collectPrices.append(self.totalItemPrice)
            
            
            //checkTheItem(quantity:self.quantity )
            //if check item .. delete this ..
            self.quatitiyArr = self.itemObj.getquantity()
            quatitiyArr.append(self.quantity)
            
            self.items =  self.itemObj.getItems()
            self.items.append(self.itemID)
            
            self.itemsNames = self.itemObj.getItemsNames()
            self.itemsNames.append(self.itemName)
            
            self.itemObj.saveItems(storeId:Stores.getStoreId()!, total: self.totalItemPrice, quantity: self.quatitiyArr, itemsName:self.itemsNames, itemArr: self.items , totalPrices: self.collectPrices)
            
            updateMenu()
            orderItems()
            
            // to comine the total
            self.totalItemPrice = self.combinePrices(priceArr: self.collectPrices)
            self.itemObj.saveTotalItemPrices(total: totalItemPrice)
            
            cartView.isHidden = false
            itemNumView.text = "\(self.itemObj.getItems().count)"
            self.priceLabel.text = "\(self.itemObj.getTotalItemPrices())"
            
            self.itemConfirmed = false
            
            
        }
        
    }
    
    func updateMenu(){
        
        if Stores.getStoreId() != itemObj.getMenuStoreID(){
            RefreshMenue(std:Stores.getStoreId()!, spId: 10) // first selection by default
            updateCart()
        }else {
            RefreshMenue(std:Stores.getStoreId()!, spId: specObj.getSpecification()!)
        }
    }
    
    
    //function to combine all of the item prices ..
    func combinePrices(priceArr:[Int]) -> Int{
        var total:Int = 0
        for price in priceArr {
            total = price + total
        }
        return total
    }
    
    func updateCart(){
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
    
    
    // i may delete this function ..
    func checkTheItem(quantity:Int){
        
        
        //self.items =  self.itemObj.getItems()
        //self.itemsNames = self.itemObj.getItemsNames()
        
        //first item
        if self.items.count == 0 {
            
            self.quatitiyArr.append(self.quantity)
            self.items.append(self.itemID)
            self.itemsNames.append(self.itemName)
            
        } else {
            
            for id in self.items {
                
                if self.items.indices.contains(id) {
                    
                    let index = self.items.firstIndex(of: id)!
                    
                    self.quatitiyArr = self.itemObj.getquantity()
                    self.items =  self.itemObj.getItems()
                    
                    var quantity_new = self.quatitiyArr
                    
                    quantity_new[index] += quantity
                    
                    //update the quantity ..
                    let def = UserDefaults.standard
                    def.set(quantity_new, forKey: "quantity")
                    def.synchronize()
                    self.quatitiyArr = self.itemObj.getquantity()
                    
                } else {
                    self.quatitiyArr = self.itemObj.getquantity()
                    quatitiyArr.append(self.quantity)
                    
                    self.items =  self.itemObj.getItems()
                    self.items.append(self.itemID)
                    
                    self.itemsNames = self.itemObj.getItemsNames()
                    self.itemsNames.append(self.itemName)
                    
                }
                
            }
            
        }
        
    }
    
    
    //refresh the cart to add new item ..
    func orderItems()  {
        
        var quantityItems = itemObj.getOrder()
        let orders = Order.items(menu_item_id: self.itemID , quantity: self.quantity, choices:self.choices)
        quantityItems.append(orders)
        itemObj.saveOrder(order: quantityItems)
        
    }
    
    // submit the order !!
    @IBAction func submitTheOrder(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "bill", bundle: nil)
        let destination = storyboard.instantiateViewController(withIdentifier: "bill") as! billViewController
        
        self.navigationController?.pushViewController(destination, animated: true)
        
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == self.typeCollictionView {
            return  specification.count
        }
        return  menu.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.typeCollictionView {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "type", for: indexPath) as! TypeCell
            
            cell.type.text = specification[indexPath.item].name_ar
            return cell
            
        } else{
            
            let cell =
                
                collectionView.dequeueReusableCell(withReuseIdentifier: "menu", for: indexPath) as! menuCell
            
            let price = self.menu[indexPath.row].price
            
            cell.menuImg.downloaded(from: menu[indexPath.row].image_url)
            cell.price.text = "\(price)"
            cell.typeName.text = self.menu[indexPath.row].title
            
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if Stores.getStoreId() == itemObj.getMenuStoreID(){
            
            typeCollictionView.selectItem(at: itemObj.getIndexPath(), animated: true, scrollPosition: [])
        }
        
    }
    
    //select item
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == self.typeCollictionView {
            
            itemObj.saveIndexPath(indexPath: indexPath)
            specObj.saveSpecification(specification: self.specification[indexPath.row].id)
            self.RefreshMenue(std: Stores.getStoreId()!, spId: specObj.getSpecification()!)
            
        }else{
            
            // to view the details and add a specific item
            let storyboard = UIStoryboard(name: "order", bundle: nil)
            let orderVC = storyboard.instantiateViewController(withIdentifier: "order") as! orderViewController
            
            orderVC.delegate = self
            
            orderVC.menuItemLabel = self.menu[indexPath.row].title
            orderVC.itemDescriptionLabel = self.menu[indexPath.row].detail
            orderVC.itemID = self.menu[indexPath.row].id
            orderVC.itemPrice = self.menu[indexPath.row].price
            orderVC.menuImgL = self.menu[indexPath.row].image_url
            orderVC.additions = self.menu[indexPath.row].menu_item_groups
            
            self.present(orderVC, animated: true, completion:nil)
            
            
            
        }
        
    }
    
}


//to use hex colors

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}

// use delegate to recive the data from Order interface ..
extension menuViewController : orderViewControllerDelegate {
    func passConfirmed(confirmed: Bool, storeID: Int, totalPrice: Int, quantityCounter: Int, itemID: Int, itemName: String, choices: [Order.items.choices]) {
        
        itemConfirmed = confirmed
        self.choices = choices
        self.itemName = itemName
        self.totalItemPrice = totalPrice
        self.quantity = quantityCounter
        self.itemID = itemID
    }
}
