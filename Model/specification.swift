//
//  specification.swift
//  Cova
//
//  Created by Ebtsam alkhuzai on 12/09/1441 AH.
//  Copyright © 1441 Ebtsam alkhuzai. All rights reserved.
//

import Foundation


class Specification:NSObject{
    
    var id :Int = 0
    var name_en:String = ""
    var name_ar:String = ""
    
    override init() {
        
    }
    
    func saveSpecification(specification:Int){
        let def = UserDefaults.standard
        def.set(specification, forKey: "specification")
        def.synchronize()
    }
    
    func getSpecification() -> Int?{
        let def = UserDefaults.standard
        return def.object(forKey: "specification")  as? Int ?? 10
    }
    
 
}

