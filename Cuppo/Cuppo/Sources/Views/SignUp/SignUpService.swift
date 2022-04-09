//
//  SignUpService.swift
//  Cuppo
//
//  Created by 이숭인 on 2022/03/13.
//

import UIKit
import Alamofire

class SignUpService {
    let headers: HTTPHeaders = [
        "accept":           "application/json",
        "Content-Type":     "application/json"
    ]
    
    let url = "\(Constant.BasicURL)/auth/signup"
    
    func requestSignUp(email: String, password: String, completion: @escaping ((Bool)->(Void))) {
        AF.request(self.url,
                   method: .post,
                   parameters: LoginRequest(email: email, password: password).toDict,
                   encoding: JSONEncoding.default, headers: self.headers)
            .responseJSON { response in
                switch response.result {
                case .success:
                    if let statusCode = response.response?.statusCode {
                        switch statusCode {
                        case 200:
                            completion(true)
                            break
                        case 400:
                            completion(false)
                            break
                        default:
                            completion(false)
                            break
                        }
                    }
                case .failure:
                    completion(false)
                    print("fail , statusCode --> \(response.result)")
                }
            }
    }
}
