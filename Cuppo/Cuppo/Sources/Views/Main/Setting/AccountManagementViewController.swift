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
    case logout // 로그아웃
    case converMember // 회원으로 전환
    case withdrawl // 회원 탈퇴
}

class AccountManagementViewController: BaseController {
    
    lazy var passwordChangeButton = SettingActionView().then{
        $0.accountDelegate = self
        $0.accountMenuType = .changePassword
        $0.setTitleLabel(text: "비밀번호 변경", font: UIFont.globalFont(size: 16))
    }
    
    lazy var logoutButton = SettingActionView().then{
        $0.accountDelegate = self
        $0.accountMenuType = .logout
        $0.setTitleLabel(text: "로그아웃", font: UIFont.globalFont(size: 16))
    }
    
    lazy var converMemberButton = SettingActionView().then{
        $0.accountDelegate = self
        $0.accountMenuType = .converMember
        $0.setTitleLabel(text: "회원으로 전환", font: UIFont.globalFont(size: 16))
    }
    
    lazy var withdrawalButton = SettingActionView().then{
        $0.accountDelegate = self
        $0.accountMenuType = .withdrawl
        $0.setTitleLabel(text: "회원 탈퇴", font: UIFont.globalFont(size: 16))
    }
    
    lazy var accountStackView = UIStackView().then{
        $0.axis = .vertical
        $0.spacing = 36
        $0.distribution = .equalSpacing
        $0.addArrangedSubview(passwordChangeButton)
        $0.addArrangedSubview(converMemberButton)
        $0.addArrangedSubview(logoutButton)
        $0.addArrangedSubview(withdrawalButton)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.navigationItem.title = "계정 관리"
        setLayout()
        checkCurrentUserInfo()
        setNavigationButton()
    }
    
    @objc
    func back(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func setNavigationButton(){
        let backbutton = UIBarButtonItem(image: UIImage(named: "backButton"), style: .done, target: self, action: #selector(back))
        self.navigationItem.leftBarButtonItem = backbutton
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor(named: "cuppoColor1")
    }
    
    func popupNonMemberLogoutAlertView(){
        let popupView = AlertView(frame: view.bounds)
        popupView.popupAlert(firstBtnTitle: "아니요", secondBtnTitle: "네", content: "로그아웃 하시겠습니까?", myView: popupView)
        popupView.delegate = self
        self.view.addSubview(popupView)
    }
    
    func checkCurrentUserInfo(){
        if let memberType = UserDataCenter.shared.memberType {
            switch memberType {
            case .member: // 현재 유저가 회원이라면
                self.converMemberButton.isHidden = true
            case .nonMember: // 현재 유저가 비회원이라면
                self.withdrawalButton.isHidden = true
                self.passwordChangeButton.isHidden = true
            }
        }
    }
    
    func setLayout(){
        [accountStackView].forEach {
            self.view.addSubview($0)
        }
        
        accountStackView.snp.makeConstraints{
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(41)
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
        case .logout:
            //TODO: 로그아웃 확인 얼럿 띄우고, 로그인 화면으로 루트뷰 변경하자
            popupNonMemberLogoutAlertView()
            break
        case .converMember:
            //TODO: 회원으로 전환 뷰로 이동
            let convertMemberVC = ConverMemberViewController()
            convertMemberVC.modalPresentationStyle = .overFullScreen
            self.present(convertMemberVC, animated: true, completion: nil)
            break
        case .withdrawl:
            let widthdrawlVC = WithdrawalViewController()
            widthdrawlVC.modalPresentationStyle = .overFullScreen
            self.present(widthdrawlVC, animated: true, completion: nil)
            break
        }
    }
}


extension AccountManagementViewController: CustomAlertProtocol {
    func cancleButtonTapped(_ popupView: UIView) {
        popupView.removeFromSuperview()
    }

    func okButtonTapped(_ popupView: UIView, _ year: String?, _ month: String?) {
        popupView.removeFromSuperview()
        self.dismiss(animated: true, completion: nil)
        
        self.view.window?.rootViewController = UINavigationController(rootViewController: LoginViewController())
    }

}
