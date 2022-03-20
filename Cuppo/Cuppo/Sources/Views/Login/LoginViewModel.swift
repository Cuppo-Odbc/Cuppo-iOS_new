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
    //MARK: - 회원가입할때 필요한 email password 로직 일단 임시로 박아놓자
    
    //MARK: - Functions
    func login(email: String, password: String){
        self.loginService.requestLogin(email: email, password: password){ response in
            //TODO: access token 값 저장
            // 타입별로 구분해서 하면됨 1. 성공, 2 실패, 오류
            switch response.type {
            case .success:
                //TODO: 로그인 성공, 메인화면으로 전환
                print("로그인 성공, 메인화면을 전환")
                break
            case .fail:
                guard let failureType = response.loginFailure?.getFailureType() else { return }
                switch failureType {
                case .invalidPassword:
                    //TODO: 패스워드 올바르지않음 얼럿
                    print("패스워드 올바르지 않음")
                    break
                case .emailNotFound:
                    //TODO: 이메일 올바르지 않음 alert
                    print("이메일 올바르지 않음")
                    break
                case .exception:
                    //TODO: 예외 얼럿
                    print("예외 발생")
                    break
                }
            } //switch
        }// response
    }
}
