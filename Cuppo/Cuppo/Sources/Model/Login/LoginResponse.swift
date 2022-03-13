//
//  LoginResponse.swift
//  Cuppo
//
//  Created by 이숭인 on 2022/03/13.
//

import UIKit

struct LoginResponse: Codable {
    var accessToken: String
    var tokenType: String
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
    }
}
