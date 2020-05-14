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
    var stores = [Stores]()
    
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
    
    
    // bring the stores near to me from an api
    private func RefreshStores(){
        
        API.userLocation(lat: userSetting.getLat()!, long: userSetting.getLong()!) { (error:Error?, stores: [Stores]?) in
            if stores!.isEmpty{
                SVProgressHUD.showError(withStatus:" لا توجد كافيهات بالقرب منك")}
            else{ let storess = stores
                self.stores = storess!
                self.tableview.reloadData()
                
            }
        }
    }
    
    
    @IBAction func updateLocation(_ sender: Any) {
        self.performSegue(withIdentifier: "updateLocation", sender: nil)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stores.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! coffeeStoreaTableViewCell
        
        cell.storeName.text = stores[indexPath.row].name
        cell.tagLine.text = stores[indexPath.row].tagline
        cell.logo.contentMode = .scaleAspectFill
        cell.header.contentMode = .scaleAspectFill
        cell.header.downloaded(from: stores[indexPath.row].header)
        cell.logo.downloaded(from: stores[indexPath.row].logo)
        cell.Time.text = stores[indexPath.row].date
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "homePage", bundle: nil)
        let destination = storyboard.instantiateViewController(withIdentifier: "menu") as! menuViewController
        
        //if user select a store, save the store information .. 
        Stores.saveStore(name:stores[indexPath.row].name,tagLine:stores[indexPath.row].tagline, headerImg:stores[indexPath.row].header,logo:stores[indexPath.row].logo,id:stores[indexPath.row].id)
        
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

