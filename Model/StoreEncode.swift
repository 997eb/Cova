//
//  StoreEncode.swift
//  Cova
//
//  Created by Ebtsam alkhuzai on 11/10/1441 AH.
//  Copyright © 1441 Ebtsam alkhuzai. All rights reserved.
//

import Foundation


public struct storeEncode:Codable{
    
    var current_page: Int?
    var data :[orderStore]?
    var first_page_url: String?
    var from: Int?
    var last_page: Int?
    var last_page_url: String?
    var next_page_url: String?
    var path: String?
    var per_page: Int?
    var prev_page_url: String?
    var to: Int?
    var total:Int?

        struct orderStore: Codable {
            
            var address :String
            var area  :String
            var categories : [categories]?
            var closes_at: String
            var cost_for_two: Int
            var created_at: String
            var delivery_fee: Int?
            var delivery_limit: Int?
            var delivery_time: String
            var details: String
            var id: Int
            var image_header_url: String
            var image_url: String
            var latitude: String
            var longitude: String
            var minimum_order: Int
            var name :String
            var opens_at: String?
            var owner_id:Int?
            var preorder :Int?
            var ratings :String?
            var serves_non_veg: Int?
            var status :String?
            var tagline :String?
            var updated_at:String?
        
   struct categories: Codable {
    
    var created_at:String?
    var id :Int?
    var image_url:String?
    var title:String?
            }
            
    }
}

/*
 {
     var current_page" = 1;
     data =     (
                 {
             address = "https://goo.gl/maps/Fn13D7b51fvDnrXS7";
             area = "\U0627\U0644\U0634\U0648\U0642\U064a\U0647";
             categories =             (
                                 {
                     "created_at" = "2020-06-02 07:49:35";
                     id = 1;
                     "image_url" = "https://covaappapi.com//storage/uploads/iqQ5jV2axmmidmA4nfQsL6hvLcyzISRplZZ1WSgm.jpeg";
                     title = "\U0642\U0647\U0648\U0647 \U0633\U0627\U062e\U0646\U0647";
                     "updated_at" = "2020-06-02 07:49:35";
                 },
             );
 
             "closes_at" = "21:39:00";
             "cost_for_two" = 0;
             "created_at" = "2020-05-18 08:07:24";
             "delivery_fee" = 25;
             "delivery_limit" = 8000;
             "delivery_time" = 75;
             details = "\U0645\U0642\U0647\U0649 \U0645\U062e\U062a\U0635 \U064a\U0642\U062f\U0645 \U0623\U0644\U0630 \U0623\U0646\U0648\U0627\U0639 \U0627\U0644\U0642\U0647\U0648\U0647 \U0648 \U0627\U0644\U062d\U0644\U0648\U064a\U0627\U062a";
             distance = "113.940055097570080988589324988424777984";
             id = 1;
             "image_header_url" = "https://drive.google.com/uc?id=1TMNF6Y3N45LdKLA4dSCFi7w-QZICV_zT";
             "image_url" = "https://covaappapi.com//storage/uploads/BtxxOlWgXhnh0SOiQytFxi7P3UHY56kSmq2KcXlg.jpeg";
             latitude = "21.3855760";
             longitude = "39.7954880";
             "minimum_order" = 20;
             name = "MB coffee";
             "opens_at" = "07:05:00";
             "owner_id" = 3;
             preorder = 1;
             ratings = "<null>";
             "serves_non_veg" = 1;
             status = open;
             tagline = "\U0645\U0642\U0647\U0649 \U0645\U062e\U062a\U0635";
             "updated_at" = "2020-06-02 09:53:57";
         },
     );
     "first_page_url" = "https://covaappapi.com/api/customer/store?page=1";
     from = 1;
     "last_page" = 1;
     "last_page_url" = "https://covaappapi.com/api/customer/store?page=1";
     "next_page_url" = "<null>";
     path = "https://covaappapi.com/api/customer/store";
     "per_page" = 15;
     "prev_page_url" = "<null>";
     to = 3;
     total = 3;
 }
 */
