//
//  API.swift
//  Cova
//
//  Created by Ebtsam alkhuzai on 18/08/1441 AH.
//  Copyright © 1441 Ebtsam alkhuzai. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD

class API: NSObject {
    
    
    // connect with API to log in user to the application
    class func login (phone: String, password:String ,  completion : @escaping(_ error: Error?,_ success: Bool) -> Void){
        
        let url = "https://covaappapi.com/api/login"
        let header = ["Accept" : "application/json"]
        
        let parameters = [
            "email":phone,
            "password":password,
            "role":"customer"
            ] as [String : Any]
        
        Alamofire.request(url, method: .post, parameters:parameters,encoding: URLEncoding.default, headers: header ).validate(statusCode: 200..<300)
            .responseJSON{ response in
                switch response.result {
                case . failure(let error):
                    completion(error, false)
                    SVProgressHUD.showError(withStatus:"The given data was invalid")
                    
                case .success( let value):
                    let json = JSON(value)
                    let api_token = json["token"].string
                    userSetting.saveApiToken(token: api_token!)
                    completion(nil, true)
                    
                }
                
        }
        
    }
    
    // connect with API to sign up user to the application
    class func signup (name: String, password:String ,  email: String, phone:String,  completion : @escaping(_ error: Error?,_ success: Bool) -> Void){
        
        let url = "https://covaappapi.com/api/register"
        let header = ["Accept" : "application/json"]
        
        let parameters = [
            "name" :name,
            "email" :email,
            "mobile_number":phone,
            "password":password,
            "role": "customer"
            ] as [String : Any]
        
        Alamofire.request(url, method: .post, parameters:parameters,encoding: URLEncoding.default, headers: header ).validate(statusCode: 200..<300)
            .responseJSON{ response in
                switch response.result {
                case . failure(let error):
                    completion(error, false)
                    SVProgressHUD.showError(withStatus:"المعلومات المدخله غير صحيحة")
                    
                    
                case .success( let value):
                    let json = JSON(value)
                    let api_token = json["token"].string
                    userSetting.saveApiToken(token: api_token!)
                    completion(nil, true)
                    
                    
                }
        }
    }
    
    // connect with API to bring stores based on user location ..
    class func userLocation (lat:String, long:String ,completion : @escaping(_ error: Error?,_ stores: [Stores]?) -> Void){
        
        let url = "https://covaappapi.com/api/customer/store?lat=0.0000000&long=0.0000000"
        
        //   let url = "https://covaappapi.com/api/customer/store?lat=\(lat)&long=\(long)"
        
        
        var request = URLRequest(url:  NSURL(string: url)! as URL)
        
        request.httpMethod = "GET"
        request.setValue("Bearer \(userSetting.getApiToken()!)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        Alamofire.request(request).responseJSON { (response) -> Void in
            
            
            switch response.result {
            case . failure(let error):
                completion(error, nil)
                SVProgressHUD.showError(withStatus:"المعلومات المدخله غير صحيحة")
                
            case .success( let value):
                let json = JSON(value)
                
                
                guard let dataArr = json["data"].array else {
                    completion(nil,nil)
                    return
                }
                var stores = [Stores]()
                for data in dataArr{
                    guard let data = data.dictionary else {return}
                    let store = Stores()
                    
                    store.id = data["id"]?.int ?? 0
                    store.name = data["name"]?.string ?? ""
                    store.tagline = data["tagline"]?.string ?? ""
                    store.logo = data["image_url"]?.string ?? ""
                    store.header = data["image_header_url"]?.string ?? ""
                    let open = data["opens_at"]?.string ?? ""
                    let close = data["closes_at"]?.string ?? ""
                    store.date = open + "-" + close
                    
                    
                    stores.append(store)
                }
                
                
                completion(nil,stores)
                
            }
        }
    }
    
    // UN COMPLETEd !!!
    
    class func addressAPI (title:String,completion : @escaping(_ error: Error?,_ done: Bool?) -> Void) {
        
        let url = "https://covaappapi.com/api/customer/address"
        
        let parameters = [
            "title" : title,
            "address" : "\(userSetting.getCityLocation()!) - \(userSetting.getStreetLocation()!)",
            "latitude" : userSetting.getLat()!,
            "longitude":userSetting.getLong()!,
            ] as [String : Any]
        
        
        let headers = [
            "Authorization": "Bearer \(userSetting.getApiToken()!)",
            "Accept": "application/json",
        ]
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.httpBody,headers: headers).responseJSON
            {
                response in
                // print(response)
                switch response.result {
                case . failure(let error):
                    completion(error, false)
                    SVProgressHUD.showError(withStatus:" الرجاء اعادة المحاولة ")
                    
                    
                case .success( let value):
                    let json = JSON(value)
                    print(json)
                    
                    guard let id = json["id"].int else {
                        completion(nil,false)
                        return
                    }
                    userSetting.saveAddressID(id: id)
                    completion(nil,true)
                    
                }
                
        }
    }
    
    // connect with API to send user Order  ..
    class func orderAPI (quantityItems:[Order.items],completion : @escaping(_ error: Error?,_ done: Bool?) -> Void){
        
        
        let url = "https://covaappapi.com/api/customer/order"
        
        
        var request = URLRequest(url:  NSURL(string: url)! as URL)
        
        request.httpMethod = "POST"
        request.setValue("Bearer \(userSetting.getApiToken()!)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        let myOrder = Order(discount: 0,
                            special_instructions:"empty",
                            address_id:userSetting.getAddressID()!,
                            store_id:Stores.getStoreId()!,
                            payment_method_id:1,
                            items: quantityItems
        )
        
        do{
            let jsonBody = try JSONEncoder().encode(myOrder)
            
            request.httpBody = jsonBody
            
        }catch{
            print(error)
        }
        
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, _, _) in
            do{
                let response = try JSONSerialization.jsonObject(with: data!, options: [])
                print(response)
                
                
            }catch{
                completion(nil,false)
                
            }
            
        }
        
        completion(nil,true)
        task.resume()
        
    }
    
    // connect with API to bring the store's specifications
    class func specificationAPI (completion : @escaping(_ error: Error?,_ specification: [Specification]?) -> Void){
        
        
        let url = "https://covaappapi.com/api/specification"
        
        
        var request = URLRequest(url:  NSURL(string: url)! as URL)
        
        request.httpMethod = "GET"
        request.setValue("Bearer \(userSetting.getApiToken()!)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        Alamofire.request(request).responseJSON { (response) -> Void in
            
            switch response.result {
            case . failure(let error):
                print(error)
            case .success( let value):
                let json = JSON(value)
                
                //for menus
                guard let sepcArr = json[].array else {
                    completion(nil,nil)
                    return
                }
                
                
                var specifications = [Specification]()
                
                
                for data in sepcArr{
                    guard let data = data.dictionary else {return}
                    let specification = Specification()
                    
                    specification.id = data["id"]?.int ?? 0
                    specification.name_ar = data["name_ar"]?.string ?? ""
                    specification.name_en = data["name_en"]?.string ?? ""
                    
                    specifications.append(specification)
                    
                    
                }
                completion(nil,specifications)
                
                
            }
        }
    }
    
    // connect with API to bring menu for specific specification
    class func menuSpecAPI (Sid:Int ,SpeId:Int ,completion : @escaping(_ error: Error?,_ menu: [MenuD]?) -> Void){
        
        
        let url = "https://covaappapi.com/api/getOrdersBySpec"
        
        var request = URLRequest(url:  NSURL(string: url)! as URL)
        
        request.httpMethod = "POST"
        request.setValue("Bearer \(userSetting.getApiToken()!)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let menuEnd = MenuEncode(spec_id:SpeId,
                                 store_id:Sid  )
        
        do{
            let jsonBody = try JSONEncoder().encode(menuEnd)
            
            request.httpBody = jsonBody
            
        }catch{
            print("error")
        }
        
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, _, _) in
            do{
                
                let response = try JSONDecoder().decode([MenuD].self, from: data!)
                completion(nil,response)
                
            }catch{
                completion(nil,nil)
                
            }
            
        }
        
        task.resume()
        
    }
}
