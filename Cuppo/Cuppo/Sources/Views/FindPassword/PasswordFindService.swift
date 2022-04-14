//
//  PasswordFindService.swift
//  Cuppo
//
//  Created by 이숭인 on 2022/04/09.
//

import UIKit
import Alamofire

class PasswordFindService {
    let headers: HTTPHeaders = [
        "accept":           "application/json",
        "Content-Type":     "application/json"
    ]
    
    let url = "\(Constant.BasicURL)/auth/reset-password"
    
    func requestPasswordFind(email: String, completion: @escaping ((Bool)->(Void))) {
        AF.request(self.url,
                   method: .post,
                   parameters: PasswordFindRequest(email: email).toDict,
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
