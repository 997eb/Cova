//
//  Order.swift
//  Cova
//
//  Created by Ebtsam alkhuzai on 12/09/1441 AH.
//  Copyright © 1441 Ebtsam alkhuzai. All rights reserved.
//

import Foundation


public struct Order: Codable {
    
   
    
         var discount:Int
         var special_instructions:String
         var address_id:Int
         var store_id:Int
         var payment_method_id:Int
         var items: [items]
    
    
    struct items: Codable{

        var menu_item_id: Int
        var quantity: Int
        var choices: [choices]
        
        struct choices : Codable , Equatable{
            
            public static func == (lhs: Order.items.choices, rhs: Order.items.choices) -> Bool {
                       return (lhs.menu_item_choice_id == rhs.menu_item_choice_id)
               }
               
            var menu_item_choice_id:Int
        }
    }
    
}
