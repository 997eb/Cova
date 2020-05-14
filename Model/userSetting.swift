//
//  userSetting.swift
//  Cova
//
//  Created by Ebtsam alkhuzai on 20/09/1441 AH.
//  Copyright © 1441 Ebtsam alkhuzai. All rights reserved.
//

import Foundation

class userSetting: NSObject {

    
    class func saveApiToken(token:String){
        let def = UserDefaults.standard
        def.set(token, forKey: "token")
        def.synchronize()
    }
    
    class func getApiToken() -> String?{
        let def = UserDefaults.standard
        return def.object(forKey: "token") as? String
    }
    
    class func saveStreetLocaion(street:String){
        let def = UserDefaults.standard
        def.set(street, forKey: "street")
             def.synchronize()
    }
    
    class func saveCityLocaion(city:String){
          let def = UserDefaults.standard
               def.set(city, forKey: "city")
               def.synchronize()
      }
    class func getCityLocation() -> String?{
        let def = UserDefaults.standard
        return def.object(forKey: "city") as? String
    }
    
    class func getStreetLocation() -> String?{
         let def = UserDefaults.standard
         return def.object(forKey: "street") as? String
     }
    
    
    class func saveLatandLong(lat:String,long:String){
        let def = UserDefaults.standard
        def.set(lat, forKey: "lat")
        def.set(long, forKey: "long")

             def.synchronize()
    }
    
    class func getLat() -> String?{
        let def = UserDefaults.standard
        return def.object(forKey: "lat") as? String
    }

    class func getLong() -> String?{
          let def = UserDefaults.standard
          return def.object(forKey: "long") as? String
      }
    
    class func saveAddressID(id:Int){
        let def = UserDefaults.standard
        def.set(id, forKey: "adressID")
             def.synchronize()
    }
    
    class func getAddressID() -> Int?{
        let def = UserDefaults.standard
        return def.object(forKey: "adressID") as? Int
    }
    
    
}

