//
//  AccountManagementViewController.swift
//  Cuppo
//
//  Created by 이숭인 on 2022/03/26.
//

import UIKit
import Then
import SnapKit

enum AccountManagementMenu {
    case changePassword // 비밀번호 변경
    case withdrawl // 회원 탈퇴
}

class AccountManagementViewController: UIViewController {
    
    lazy var passwordChangeButton = SettingActionView().then{
        $0.accountDelegate = self
        $0.accountMenuType = .changePassword
        $0.setTitleLabel(text: "비밀번호 변경", font: .TTFont(type: .GFReg, size: 16))
    }
    
    lazy var withdrawalButton = SettingActionView().then{
        $0.accountDelegate = self
        $0.accountMenuType = .withdrawl
        $0.setTitleLabel(text: "회원 탈퇴", font: .TTFont(type: .GFReg, size: 16))
    }
    
    lazy var accountStackView = UIStackView().then{
        $0.axis = .vertical
        $0.spacing = 36
        $0.distribution = .equalSpacing
        $0.addArrangedSubview(passwordChangeButton)
        $0.addArrangedSubview(withdrawalButton)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .systemBackground
        self.navigationItem.title = "계정 관리"
        setLayout()
    }
    
    func setLayout(){
        [accountStackView].forEach {
            self.view.addSubview($0)
        }
        
        accountStackView.snp.makeConstraints{
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(86)
            $0.leading.equalToSuperview().offset(30)
            $0.trailing.equalToSuperview().offset(-30)
        }
    }
}

extension AccountManagementViewController: SettingAccountDelegate {
    func tapMenu(menuType: AccountManagementMenu) {
        switch menuType {
        case .changePassword:
            let passwordChangeVC = PasswordChangeViewController()
            passwordChangeVC.modalPresentationStyle = .overFullScreen
            self.present(passwordChangeVC, animated: true, completion: nil)
            break
        case .withdrawl:
            //TODO: 회원 탈퇴 화면 이동
            break
        }
    }
}
