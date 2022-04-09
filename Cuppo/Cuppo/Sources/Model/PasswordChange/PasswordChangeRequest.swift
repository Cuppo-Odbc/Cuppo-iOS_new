//
//  PasswordChangeRequest.swift
//  Cuppo
//
//  Created by 이숭인 on 2022/04/09.
//

import UIKit

struct PasswordChangeRequest {
    var password: String
    
    var toDict: [String:String] {
        let dict: [String:String] = ["password":self.password]
        
        return dict
    }
    
    init(password: String){
        self.password = password
    }
}
