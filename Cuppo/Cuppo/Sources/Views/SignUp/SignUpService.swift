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
    let url = "http://cuppotest-env.eba-ag42sqsg.ap-northeast-2.elasticbeanstalk.com/auth/signup"
    
    func requestSignUp(email: String, password: String, completion: @escaping ((Bool)->(Void))) {
        AF.request(self.url,
                   method: .post,
                   parameters: LoginRequest(email: email, password: password).toDict,
                   encoding: JSONEncoding.default, headers: self.headers)
            .responseJSON { response in
                switch response.result {
                case .success:
                    completion(true)
                case .failure:
                    completion(false)
                    print("fail , statusCode --> \(response.result)")
                }
            }
    }
}
