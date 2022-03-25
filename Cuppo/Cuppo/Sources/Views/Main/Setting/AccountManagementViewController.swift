//
//  AccountManagementViewController.swift
//  Cuppo
//
//  Created by 이숭인 on 2022/03/26.
//

import UIKit

class AccountManagementViewController: UIViewController {
    
    lazy var passwordChangeButton = UILabel().then{
        $0.text = "비밀번호 변경"
        $0.font = UIFont.TTFont(type: .GFReg, size: 16)
        $0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(passwordChangeBtnTapped(_:))))
    }
    
    lazy var withdrawalButton = UILabel().then{
        $0.text = "회원 탈퇴"
        $0.font = UIFont.TTFont(type: .GFReg, size: 16)
        $0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(withdrawalBtnTapped(_:))))
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
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(46)
            $0.leading.equalToSuperview().offset(30)
            $0.trailing.equalToSuperview().offset(-30)
        }
    }
    
    @objc
    func passwordChangeBtnTapped(_ sender: UITapGestureRecognizer){
        
    }
    
    @objc
    func withdrawalBtnTapped(_ sender: UITapGestureRecognizer){
        
    }
}
