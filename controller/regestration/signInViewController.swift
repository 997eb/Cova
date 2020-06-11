//
//  signInViewController.swift
//  Cova
//
//  Created by Ebtsam alkhuzai on 14/08/1441 AH.
//  Copyright © 1441 Ebtsam alkhuzai. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD


class signInViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        phone.layer.cornerRadius = 15.0
        phone.layer.borderWidth = 0.5
        phone.layer.borderColor = UIColor.orange.cgColor
        phone.clipsToBounds = true
        
        password.layer.cornerRadius = 15.0
        password.layer.borderWidth = 0.5
        password.layer.borderColor = UIColor.orange.cgColor
        password.clipsToBounds = true
        
        self.hideKeyboardWhenTappedAround()
    }
    
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBAction func signin(_ sender: Any) {
        
        guard let phoneIF = phone.text , !phoneIF.isEmpty else {return}
        guard let passwordIF = password.text, !passwordIF.isEmpty else {return}
        
        API.login(phone: phone.text!, password: password.text!) { (error:Error?, success: Bool) in   if success {
    
            API.addressAPI(title:"Home") {(error:Error?, done: Bool?) in
                   
               if  done == true {
                   print("sucesss")
                   
               } else {
                   print("not sucesss")
                   }
               }
            
            self.dismiss(animated: true, completion: nil)
    }
    
}
    }
    
}
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}






