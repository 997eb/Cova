//
//  SignUpViewController.swift
//  Cova
//
//  Created by Ebtsam alkhuzai on 29/07/1441 AH.
//  Copyright © 1441 Ebtsam alkhuzai. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD


class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var scrollview: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        name.layer.cornerRadius = 15.0
        name.layer.borderWidth = 1
        name.layer.borderColor = UIColor.orange.cgColor
        name.clipsToBounds = true
        
        password.layer.cornerRadius = 15.0
        password.layer.borderWidth = 0.5
        password.layer.borderColor = UIColor.orange.cgColor
        password.clipsToBounds = true
        
        email.layer.cornerRadius = 15.0
        email.layer.borderWidth = 0.5
        email.layer.borderColor = UIColor.orange.cgColor
        email.clipsToBounds = true
        
        phone.layer.cornerRadius = 15.0
        phone.layer.borderWidth = 0.5
        phone.layer.borderColor = UIColor.orange.cgColor
        phone.clipsToBounds = true
        
        self.name.delegate = self
        self.password.delegate = self
        self.email.delegate = self
        self.phone.delegate = self
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if
            
            (textField == self.name) {
            self.email.becomeFirstResponder()
            
        }
        if  (textField == self.email){
            self.phone.becomeFirstResponder()
            
        }
        if  (textField == self.phone){
            self.password.becomeFirstResponder()
            
        }
        if  (textField == self.password) {
            // self.signup(.)
        }
        
        return true
    }
    
    
    
    //user information ..
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var phone: UITextField!
    
    @IBAction func signup(_ sender: Any) {
        
        guard let nameIF = name.text , !nameIF.isEmpty else {return}
        guard let emailIF = email.text, !emailIF.isEmpty else {return}
        guard let phoneIF = phone.text, !phoneIF.isEmpty else {return}
        guard let passwordIF = password.text, !passwordIF.isEmpty else {return}
        
        
        SVProgressHUD.show()
        API.signup(name: name.text!, password: password.text!, email: email.text!, phone: phone.text!) { (error:Error?, success: Bool) in
            
            if success {
                SVProgressHUD.showSuccess(withStatus: "تم التسجيل بنجاح")
                
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

