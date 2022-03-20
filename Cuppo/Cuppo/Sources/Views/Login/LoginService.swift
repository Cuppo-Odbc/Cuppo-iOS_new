//
//  LoginService.swift
//  Cuppo
//
//  Created by 이숭인 on 2022/03/13.
//

import UIKit
import Alamofire

class LoginService {
    let headers: HTTPHeaders = [
        "accept":           "application/json",
        "Content-Type":     "application/json"
    ]
    let url = "http://cuppotest-env.eba-ag42sqsg.ap-northeast-2.elasticbeanstalk.com/auth/signin"
    
    func requestLogin(email: String, password: String, completion: @escaping ((LoginResponse)->(Void))){
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
                            do{
                                let jsonData = try JSONSerialization.data(withJSONObject: response.value!, options: .prettyPrinted)
                                let json = try JSONDecoder().decode(LoginResponse.LoginSuccess.self, from: jsonData)
                                
                                completion(LoginResponse(type: .success, successObj: json))
                            }catch let error {
                                print("parsing error -> \(error.localizedDescription)")
                            }
                            break
                        case 400:
                            do{
                                let jsonData = try JSONSerialization.data(withJSONObject: response.value!, options: .prettyPrinted)
                                let json = try JSONDecoder().decode(LoginResponse.LoginFail.self, from: jsonData)
                                completion(LoginResponse(type: .fail, failureObj: json))
                            }catch let error {
                                print("parsing error -> \(error.localizedDescription)")
                            }
                            break
                        default:
                            print("예상치 못한 에러")
                            completion(LoginResponse(type: .fail, failureObj: nil))
                            break
                        }
                    }
                case .failure:
                    print("fail , statusCode --> \(response.result)")
                }
            }
    }
}
