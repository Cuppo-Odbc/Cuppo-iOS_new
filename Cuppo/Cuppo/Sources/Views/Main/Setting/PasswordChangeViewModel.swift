//
//  PasswordChangeViewModel.swift
//  Cuppo
//
//  Created by 이숭인 on 2022/04/09.
//

import UIKit

class PasswordChangeViewModel {
    let passwordChangeService = PasswordChangeService()
    
    func requestPasswordChange(password: String, completion: @escaping ((Bool)->(Void))){
        self.passwordChangeService.requestChangePassword(password: password) { isSuccess in
            if isSuccess {
                completion(true)
            }else{
                completion(false)
            }
        }
    }
}
