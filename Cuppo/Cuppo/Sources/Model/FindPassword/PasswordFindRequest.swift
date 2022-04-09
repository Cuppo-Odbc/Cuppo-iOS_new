//
//  PasswordFindRequest.swift
//  Cuppo
//
//  Created by 이숭인 on 2022/04/09.
//

import UIKit

struct PasswordFindRequest: Codable {
    var email: String
    
    var toDict: [String:String] {
        let dict: [String:String] = ["username":self.email]
        
        return dict
    }
    
    init(email: String){
        self.email = email
    }
}
