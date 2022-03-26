//
//  LoginViewModel.swift
//  Cuppo
//
//  Created by 이숭인 on 2022/03/13.
//

import UIKit
import RxSwift
import RxRelay

class LoginViewModel {
    var loginService = LoginService()
    let userDataCenter = UserDataCenter.shared
    //MARK: - 회원가입할때 필요한 email password 로직 일단 임시로 박아놓자
    
    //MARK: - Functions
    func login(email: String, password: String, completion: @escaping ((LoginResponse)->(Void))){
        self.loginService.requestLogin(email: email, password: password){ response in
            //TODO: access token 값 저장
            completion(response)
        }// response
    }
    
    func setAccessTokenForUser(token: String){
        self.userDataCenter.setAccessToken(token: token)
    }
}
