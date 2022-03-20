//
//  LoginResponse.swift
//  Cuppo
//
//  Created by 이숭인 on 2022/03/13.
//

import UIKit

enum LoginResponseType {
    case success
    case fail
}

enum LoginFailureType: String {
    case emailNotFound = "EMAIL_NOT_FOUND"
    case invalidPassword = "INVALID_PASSWORD"
    case exception
}

struct LoginResponse {
    var type: LoginResponseType
    var loginSuccess: LoginSuccess?
    var loginFailure: LoginFail?
    
    struct LoginSuccess: Codable {
        var accessToken: String
        var tokenType: String
        
        enum CodingKeys: String, CodingKey {
            case accessToken = "access_token"
            case tokenType = "token_type"
        }
    }
    
    struct LoginFail: Codable {
        /**
            로그인이 실패했을 경우
         1. 이메일이 올바르지 않을 경우 -> "EMAIL_NOT_FOUND"
         2. 패스워드가 올바르지 않을 경우 -> "INVALID_PASSWORD"
         */
        var detail: String
        
        func getFailureType() -> LoginFailureType {
            switch self.detail {
            case LoginFailureType.emailNotFound.rawValue:
                return .emailNotFound
            case LoginFailureType.invalidPassword.rawValue:
                return .invalidPassword
            default:
                return .exception
            }
        }
    }
    
    init(type: LoginResponseType, successObj: LoginSuccess?){
        self.type = type
        self.loginSuccess = successObj
    }
    
    init(type: LoginResponseType, failureObj: LoginFail?){
        self.type = type
        self.loginFailure = failureObj
    }
    
}
