//
//  WithdrawalViewModel.swift
//  Cuppo
//
//  Created by 이숭인 on 2022/04/09.
//

import UIKit

class WithdrawalViewModel {
    let withdrawalService = WithdrawalService()
    
    func requestWithdrawal(completion: @escaping ((Bool)->(Void))){
        self.withdrawalService.requestWithdrawal { isSuccess in
            if isSuccess { // 탈퇴성공
                completion(true)
            }else{ // 탈퇴 실패
                completion(false)
            }
        }
    }
}
