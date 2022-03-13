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
    let emailObserver = BehaviorRelay<String>(value: "")
    let passwordObserver = BehaviorRelay<String>(value: "")
    
    //MARK: - 회원가입할때 필요한 email password 로직 일단 임시로 박아놓자
    var isEmailVaild: Observable<Bool> {
        return emailObserver
            .filter{ //email
                !$0.isEmpty
            }
            .map { email in
                let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}" //이메일 검증
                let emailPredicate = NSPredicate(format: "SELF MATCHES %@", regex)
                return emailPredicate.evaluate(with: email)
            }
    }

    var isPasswordValid: Observable<Bool> {
        return passwordObserver
            .filter {
                !$0.isEmpty
            }
            .map { password in
                let regex = "^(?=.*[A-Za-z])(?=.*[0-9]).{8,50}" // 8자리 ~ 50자리 영어+숫자

                let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", regex)
                return passwordPredicate.evaluate(with: password)
            }
    }
}
