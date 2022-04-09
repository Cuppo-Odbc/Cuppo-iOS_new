//
//  PasswordChangeService.swift
//  Cuppo
//
//  Created by 이숭인 on 2022/04/09.
//

import UIKit
import Alamofire
class PasswordChangeService {
    let headers: HTTPHeaders = [
        "accept":           "application/json",
        "Content-Type":     "application/json",
        "Authorization":    "Bearer \(UserDataCenter.shared.accessToken ?? "")"
    ]
    
    let url = "\(Constant.BasicURL)/auth/update-password"
    
    func requestChangePassword(password: String, completion: @escaping ((Bool)->(Void))) {
        AF.request(self.url,
                   method: .post,
                   parameters: PasswordChangeRequest(password: password).toDict,
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
