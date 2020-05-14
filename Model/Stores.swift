//
//  stores.swift
//  Cova
//
//  Created by Ebtsam alkhuzai on 21/08/1441 AH.
//  Copyright © 1441 Ebtsam alkhuzai. All rights reserved.
//

import Foundation


class Stores{
    var id: Int = 0
    var name : String = ""
    var tagline : String = ""
    var logo : String = ""
    var date : String = ""
    var header : String = ""
    var categore : String = ""
    
    
    init() {
      
    }
    
    
    class func saveStore(name:String,tagLine:String, headerImg:String,logo:String,id:Int){
           let def = UserDefaults.standard
       
           def.set(name, forKey: "logo")
           def.set(name, forKey: "storeName")
           def.set(tagLine, forKey: "tagLine")
           def.set(headerImg, forKey: "headerImg")
           def.set(id, forKey: "storeId")
           def.synchronize()
       }
      
      class func getStoreName() -> String?{
           let def = UserDefaults.standard
           return def.object(forKey: "storeName") as? String
       }
      
      class func getStoreId() -> Int?{
              let def = UserDefaults.standard
              return def.object(forKey: "storeId") as? Int
          }
      
      class func getStoreTagLinee() -> String?{
             let def = UserDefaults.standard
             return def.object(forKey: "tagLine") as? String
         }
      
      class func getStoreHeaderImg() -> String?{
             let def = UserDefaults.standard
             return def.object(forKey: "headerImg") as? String
         }
    
    class func getStoreLogoImg() -> String?{
                let def = UserDefaults.standard
                return def.object(forKey: "logo") as? String
            }

    
}
