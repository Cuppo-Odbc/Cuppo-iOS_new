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
                    do{
                        let jsonData = try JSONSerialization.data(withJSONObject: response.value!, options: .prettyPrinted)
                        let json = try JSONDecoder().decode(LoginResponse.self, from: jsonData)
                        completion(json)
                    }catch let error {
                        print("parsing error -> \(error.localizedDescription)")
                    }
                case .failure:
                    print("fail , statusCode --> \(response.result)")
                }
            }
    }
    
    func decode<T>(from data: Data) -> T {
        return LoginResponse(accessToken: "aa", tokenType: "b") as! T
    }
}
