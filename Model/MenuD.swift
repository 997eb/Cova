//
//  MenuD.swift
//  Cova
//
//  Created by Ebtsam alkhuzai on 18/09/1441 AH.
//  Copyright © 1441 Ebtsam alkhuzai. All rights reserved.
//

import Foundation



struct MenuD: Codable {

    var id :Int
    var title:String
    var detail:String
    var specification:String
    var image_url:String
    var price: Int
    var is_available:Int
    var is_non_veg:Int;
    var status: String
    var store_id :Int
    var specification_id:Int
    var created_at:String
    var updated_at:String
    var categories:Array<String>
    var menu_item_groups:[Groups]
           
    
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
