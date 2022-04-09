//
//  PasswordFindViewModel.swift
//  Cuppo
//
//  Created by 이숭인 on 2022/04/09.
//

import UIKit

class PasswordFindViewModel {
    let passwordFindService = PasswordFindService()
    
    func requestFindPassword(email: String, completion: @escaping (Bool)->(Void)){
        self.passwordFindService.requestPasswordFind(email: email) {
            completion(true)
        }
    }
}
