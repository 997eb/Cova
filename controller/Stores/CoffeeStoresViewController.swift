//
//  CoffeeStoresViewController.swift
//  Cova
//
//  Created by Ebtsam alkhuzai on 20/08/1441 AH.
//  Copyright © 1441 Ebtsam alkhuzai. All rights reserved.
//

import UIKit
import SVProgressHUD


class CoffeeStoresViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // to assign store informations

    var storesObj : storeEncode?
    var storeData: [storeEncode.orderStore]?
    var categoriesDate : [storeEncode.orderStore.categories]?
    
    //interface componenet
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var streetName: UILabel!
    @IBOutlet weak var locationText: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //additional styles to the tableview
        tableview.tableFooterView = UIView()
        tableview.separatorInset = .zero
        tableview.contentInset = .zero
        tableview.separatorStyle = .none
        
        
        //call the RefreshStores function to bring the stores
        RefreshStores()
        
        //to fill the data into the interface
        self.cityName.text = userSetting.getCityLocation()
        self.streetName.text = userSetting.getStreetLocation()
        
        
    }
    
    // bring the stores near to user from an api
    private func RefreshStores(){
        
        API.userLocation(lat: userSetting.getLat()!, long: userSetting.getLong()!) { (error:Error?, stores: storeEncode? ) in
            
            if stores?.data?.count == 0{
                SVProgressHUD.showError(withStatus:" لا توجد مقاهي بالقرب منك")
                
            }else{
               if let store = stores {
                self.storesObj = store
                self.storeData = self.storesObj?.data
                DispatchQueue.main.async {
                    self.tableview.reloadData()
                    
                }
                }
                
            }
        }
    }

    
    
    @IBAction func updateLocation(_ sender: Any) {
        self.performSegue(withIdentifier: "updateLocation", sender: nil)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storeData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! coffeeStoreaTableViewCell
        
        cell.storeName.text =  self.storeData?[indexPath.row].name
        cell.tagLine.text =
            self.storeData?[indexPath.row].tagline
        cell.logo.contentMode = .scaleAspectFill
        cell.header.contentMode = .scaleAspectFill
        cell.header.downloaded(from: self.storeData?[indexPath.row].categories?[indexPath.row].image_url ?? "")
        cell.logo.downloaded(from: (self.storeData?[indexPath.row].image_url) ?? "" )
       
        cell.Time.text =  "\(String(describing: self.storeData![indexPath.row].opens_at!)) - \(String(describing: self.storeData![indexPath.row].closes_at))"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "homePage", bundle: nil)
        let destination = storyboard.instantiateViewController(withIdentifier: "menu") as! menuViewController
        Stores.saveStore(name:self.storeData?[indexPath.row].name ?? "" ,tagLine:self.storeData?[indexPath.row].tagline ?? "",
                         headerImg:self.storeData?[indexPath.row].categories?[indexPath.row].image_url ?? "" ,
                         logo:self.storeData?[indexPath.row].image_url ?? "",
                         id:(self.storeData?[indexPath.row].id)!)
        Stores.saveCategories(categories: self.storeData?[indexPath.row].categories ?? [])
        
        self.navigationController?.pushViewController(destination, animated: true)
        
    }
}


extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        
        contentMode = UIView.ContentMode.scaleToFill
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

