//
//  LoginService.swift
//  Cuppo
//
//  Created by 이숭인 on 2022/03/13.
//

import UIKit
import Alamofire

class LoginService {
    let signInHeaders: HTTPHeaders = [
        "accept":           "application/json",
        "Content-Type":     "application/json"
    ]
    
    let anonymousHeaders: HTTPHeaders = [
        "accept":           "application/json"
    ]
    
    let signInURL = "\(Constant.BasicURL)/auth/signin"
    let anonymousURL = "\(Constant.BasicURL)/auth/signup/anonymous"
        
    func requestLogin(email: String, password: String, completion: @escaping ((LoginResponse)->(Void))){
        AF.request(self.signInURL,
                   method: .post,
                   parameters: LoginRequest(email: email, password: password).toDict,
                   encoding: JSONEncoding.default, headers: self.signInHeaders)
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
    
    func requestAnonymouseLogin(completion: @escaping (AnonymousLoginResponse?)->(Void)){
        AF.request(self.anonymousURL,
                   method: .post,
                   encoding: JSONEncoding.default, headers: self.anonymousHeaders)
            .responseJSON { response in
                switch response.result {
                case .success:
                    if let statusCode = response.response?.statusCode {
                        switch statusCode {
                        case 200:
                            do{
                                let jsonData = try JSONSerialization.data(withJSONObject: response.value!, options: .prettyPrinted)
                                let json = try JSONDecoder().decode(AnonymousLoginResponse.self, from: jsonData)
                                
                                completion(json)
                            }catch let error {
                                print("parsing error -> \(error.localizedDescription)")
                            }
                            break
                        default:
                            print("예상치 못한 에러")
                            completion(nil)
                            break
                        }
                    }
                case .failure:
                    print("fail , statusCode --> \(response.result)")
                }
            }
    }
}
