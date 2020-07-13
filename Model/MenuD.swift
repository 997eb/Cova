//
//  MenuD.swift
//  Cova
//
//  Created by Ebtsam alkhuzai on 18/09/1441 AH.
//  Copyright © 1441 Ebtsam alkhuzai. All rights reserved.
//

import Foundation

struct MenuD: Codable {

    
    var menu_items:[menu]
    
    struct menu :Codable{
  
    var id :Int
    var title:String
    var detail:String
    var specification:String
    var image_url:String
    var image_thumbnail_url:String?
        //thumbnail 
    var price: Int
    var is_available:Int
    var is_non_veg:Int
    var status: String
    var store_id :Int
    var created_at:String
    var updated_at:String
    var categories : [categories]?
    var menu_item_groups:[Groups]
           
    struct categories: Codable {
      
      var created_at:String?
      var id :Int?
      var image_url:String?
      var image_thumbnail_url:String?
      var title:String?
              }
    
    struct Groups:Codable{
        
        var id:Int
        var title:String
        var max_choices:Int
        var created_at:String
        var menu_item_id:Int
        var updated_at:String
        var min_choices:Int
        var menu_item_choices:[choices]
        
        struct choices:Codable{

               var price:Int
               var menu_item_group_id:Int
               var title:String
               var created_at:String
               var updated_at:String
               var id:Int
             }
          
    }

}
}
/*
 "menu_items": [
        {
            "id": 18,
            "title": "بن اسبرسو",
            "detail": "Espresso",
            "specification": "hot coffee",
            "image_url": "https://covaappapi.com//storage/uploads/RnCq0dwo2UfbacFSFkbgcoexNMwOTUuFuod9CslQ.jpeg",
            "image_thumbnail_url": null,
            "price": 49,
            "is_available": 1,
            "is_non_veg": 0,
            "status": "approved",
            "store_id": 1,
            "created_at": "2020-06-02 09:56:03",
            "updated_at": "2020-06-19 09:39:23",
            "categories": [
                {
                    "id": 3,
                    "title": "حلويات و مخبوزات",
                    "image_url": "https://covaappapi.com//storage/uploads/rq9XpoAWIQLaYfnpkleX0wioswDRPjAU87tTnjck.jpeg",
                    "image_thumbnail_url": null,
                    "created_at": "2020-06-02 07:51:40",
                    "updated_at": "2020-06-02 07:51:40"
                }
            ],
            "menu_item_groups": []
 */
