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
    
    func anonymousLogin(completion: @escaping ((LoginResponse)->(Void))){
//        1단계 검증
        if let memberInfo = self.userDataCenter.getNonMemberInfo() { // 로그인 이력 있음
            // 로그인 api 쏘기
            self.loginService.requestLogin(email: memberInfo.email, password: memberInfo.password) { response in
                completion(response)
            }
        }else{ // 최초 로그인
            // 비회원 로그인 api 쏘고 응답 온걸로 로그인 api 쏘기
            self.loginService.requestAnonymouseLogin { response in
                if let response = response {
                    self.userDataCenter.setNonMemberInfo(email: response.email, password: response.email) // 최초 로그인 성공했으니 UserDefaults에 정보 저장
                    self.loginService.requestLogin(email: response.email, password: response.email) { response in
                        completion(response)
                    }
                }
            }
        }
    }
    
    func setAccessTokenForUser(token: String){
        self.userDataCenter.setAccessToken(token: token)
    }
    
    func setMemberInfo(memberType: MemberType){
        self.userDataCenter.setMemberInfo(memberType: memberType)
    }
}
