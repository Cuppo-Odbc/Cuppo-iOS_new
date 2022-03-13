//
//  LoginRequest.swift
//  Cuppo
//
//  Created by 이숭인 on 2022/03/13.
//

import UIKit

struct LoginRequest: Codable {
    let email: String
    let password: String
    
    var toDict: [String:String] {
        let dict: [String:String] = ["username":self.email,
                                     "password":self.password]
        
        return dict
    }
    
    init(email: String, password: String){
        self.email = email
        self.password = password
    }
}
