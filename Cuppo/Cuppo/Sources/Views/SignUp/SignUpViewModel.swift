//
//  SignUpViewModel.swift
//  Cuppo
//
//  Created by 이숭인 on 2022/03/13.
//

import UIKit
import RxSwift
import RxRelay

/**
 TODOLIST
 
 1. 회원가입시에 이메일, 패스워드 조건에 맞는지 검증 절차 추가해야함
    ---> 버튼을 눌렀을때 검증 후, 검증완료 -> 회원가입 / 검증 실패 -> 회원가입 실패 Alert
 2. 회원가입 취소하는걸 버튼을 따로 만들던가 아니면 네이게이션 바의 백버튼을 눌렀을때 취소하고 돌아가던가 만들어야함
 */

class SignUpViewModel {
    let disposeBag = DisposeBag()
    let emailObserver = BehaviorRelay<String>(value: "")
    let passwordObserver = BehaviorRelay<String>(value: "")
    let passwordCheckObserver = BehaviorRelay<String>(value: "")
    var signUpService = SignUpService()
    
    var isEmailVaild: Observable<Bool> {
        return emailObserver
            .map { email in
                let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}" //이메일 검증
                let emailPredicate = NSPredicate(format: "SELF MATCHES %@", regex)
                
                return email.isEmpty ? false : emailPredicate.evaluate(with: email)
            }
    }

    var isPasswordValid: Observable<Bool> {
        return passwordObserver
            .map { password in
                let regex = "^(?=.*[A-Za-z])(?=.*[0-9]).{8,50}" // 8자리 ~ 50자리 영어+숫자
                
                let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", regex)
                return password.isEmpty ? false : passwordPredicate.evaluate(with: password)
            }
    }
    var isPasswordCheckValid: Observable<Bool> {
        return Observable
            .combineLatest(self.passwordObserver, self.passwordCheckObserver)
            .map { password, passwordCheck -> Bool in
                if password.isEmpty || passwordCheck.isEmpty{
                    return false
                }
                
                return password == passwordCheck ? true : false
            }
    }

    //MARK: - Functions
    func signUp(email: String, password: String, completion: @escaping ((Bool)->(Void))) {
        self.signUpService.requestSignUp(email: email, password: password) { response in
            if response {
                //TODO: 회원가입 성공
                completion(true)
            }else{
                //TODO: 회원가입 실패
                completion(false)
            }
        }
    }
    
    func verifyEmail(email: String) -> Bool {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}" //이메일 검증
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", regex)
        
        return emailPredicate.evaluate(with: email)
    }
    
    func verifyPassword(password: String) -> Bool {
        let regex = "^(?=.*[A-Za-z])(?=.*[0-9]).{8,50}" // 8자리 ~ 50자리 영어+숫자
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", regex)
        
        return passwordPredicate.evaluate(with: password)
    }
    
    func verifyPasswordCheck(password: String, passwordCheck: String) -> Bool {
        if password.isEmpty || passwordCheck.isEmpty {
            return false
        }
        
        return password == passwordCheck ? true : false
    }
}
