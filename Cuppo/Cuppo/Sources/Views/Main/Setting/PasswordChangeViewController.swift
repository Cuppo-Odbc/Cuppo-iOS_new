//
//  PasswordChangeViewController.swift
//  Cuppo
//
//  Created by 이숭인 on 2022/03/26.
//

import UIKit

class PasswordChangeViewController: UIViewController {
    let currentPasswordTextField = UnderLineTextField().then{
        $0.setPlaceHolder(placeHolder: "현재 비밀번호")
        $0.setAlertLabel(text: "비밀번호가 다릅니다")
        $0.textField.isSecureTextEntry = true
    }
    
    let newPasswordTextField = UnderLineTextField().then{
        $0.setPlaceHolder(placeHolder: "새 비밀번호 (영문, 숫자 포함 8자리 이상)")
        $0.setAlertLabel(text: "비밀번호를 입력해주세요 (영문, 숫자 포함 8자리 이상)")
        $0.textField.isSecureTextEntry = true
    }
    
    let newPasswordCheckTextField = UnderLineTextField().then{
        $0.setPlaceHolder(placeHolder: "새 비밀번호 확인")
        $0.setAlertLabel(text: "비밀번호가 다릅니다")
        $0.textField.isSecureTextEntry = true
    }
    
    lazy var passwordChangeButton = UIButton().then{
        $0.setTitle("비밀번호 변경", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.TTFont(type: .GFReg, size: 16)
        $0.layer.borderColor = UIColor.black.cgColor
        $0.layer.borderWidth = 1.0
    }
    
    lazy var passwordStackView = UIStackView().then{
        $0.axis = .vertical
        $0.spacing = 12
        $0.distribution = .equalSpacing
        $0.addArrangedSubview(currentPasswordTextField)
        $0.addArrangedSubview(newPasswordTextField)
        $0.addArrangedSubview(newPasswordCheckTextField)
    }
    
    lazy var closeButton = UIButton().then{
        $0.setImage(UIImage(systemName: "star"), for: .normal)
        $0.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground
        
        setLayout()
    }
    
    func setLayout(){
        [passwordStackView, passwordChangeButton, closeButton].forEach {
            self.view.addSubview($0)
        }
        
        passwordStackView.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(37)
            $0.trailing.equalToSuperview().offset(-38)
        }
        
        passwordChangeButton.snp.makeConstraints{
            $0.centerY.equalToSuperview().multipliedBy(1.7)
            $0.leading.equalToSuperview().offset(37)
            $0.trailing.equalToSuperview().offset(-38)
            $0.height.equalTo(50)
        }
        
        closeButton.snp.makeConstraints{
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(20)
            $0.leading.equalToSuperview().offset(30)
            $0.width.height.equalTo(15)
        }
    }
    
    @objc
    func closeButtonTapped(_ sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }
}
