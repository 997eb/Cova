//
//  stores.swift
//  Cova
//
//  Created by Ebtsam alkhuzai on 21/08/1441 AH.
//  Copyright © 1441 Ebtsam alkhuzai. All rights reserved.
//

import Foundation


class Stores{
    /*
    var id: Int = 0
    var name : String = ""
    var tagline : String = ""
    var logo : String = ""
    var date : String = ""
    var header : String = ""
    var categoriesArr: [Categories] = []

    
    struct Categories : Codable{
         
           var id :Int = 0
           var name_en:String = ""
           var name_ar:String = ""
           var header_img:String = ""
    }
    */
    
    
     class   func saveFee(fee: Int){
            let def = UserDefaults.standard
            def.set(fee, forKey: "fee")
                   def.synchronize()
            
    }
    
    class func getFee() -> Int{
           let def = UserDefaults.standard
           return def.object(forKey: "fee") as? Int ?? 0
       }
    
    class func saveStore(name:String,tagLine:String, headerImg:String,logo:String,id:Int){
        let def = UserDefaults.standard
        //print(categories)
        def.set(logo, forKey: "logo")
        def.set(name, forKey: "storeName")
        def.set(tagLine, forKey: "tagLine")
        def.set(headerImg, forKey: "headerImg")
        def.set(id, forKey: "storeId")
        //def.set(categories, forKey: "categories")
        def.synchronize()
    }
    
    class func saveCategories (categories: Array<storeEncode.orderStore.categories> ){
 
        
        do {
            // Create JSON Encoder
            let encoder = JSONEncoder()
            
            // Encode Note
            let data = try encoder.encode(categories)
            
            // Write/Set Data
            UserDefaults.standard.set(data, forKey: "categories")

            
        } catch {
            print("Unable to Encode Array of Notes (\(error))")
        }
        
        
    }
    
   class func getCategories()->[storeEncode.orderStore.categories]{
         
         guard let data = UserDefaults.standard.data(forKey: "categories") else { return [] }
         let decoder = JSONDecoder()
         let categories = (try? decoder.decode([storeEncode.orderStore.categories].self, from: data)) ?? []
         
         return categories
         }
    
    
    
    
    class func getStoreName() -> String?{
        let def = UserDefaults.standard
        return def.object(forKey: "storeName") as? String
    }
    
    class func getCategories() -> Array<Any>?{
          let def = UserDefaults.standard
          return def.object(forKey: "categories") as? Array<Any>
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
