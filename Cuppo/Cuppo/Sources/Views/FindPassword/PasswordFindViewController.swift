//
//  PasswordFindViewController.swift
//  Cuppo
//
//  Created by 이숭인 on 2022/03/26.
//

import UIKit
import SnapKit
import Then

class PasswordFindViewController: BaseController {
    let alertLabel = UILabel().then{
        $0.text = "가입 시 사용했던 이메일을 기입해주세요."
        $0.font = UIFont.globalFont(size: 16)
    }
    
    let emailTextField = UnderLineTextField().then{
        $0.setPlaceHolder(placeHolder: "이메일")
        $0.setAlertLabel(text: "해당 이메일로 등록된 회원 정보가 없습니다.")
    }
    
    lazy var passwordFindButton = UIButton().then{
        $0.setTitle("비밀번호 찾기", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.globalFont(size: 16)
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.backgroundColor = .white
        $0.layer.borderWidth = 1
        $0.addTarget(self, action: #selector(passwordFindButtonTapped(_:)), for: .touchUpInside)
    }
    
    lazy var closeButton = UIButton().then{
        $0.setImage(UIImage(named: "closeButton"), for: .normal)
        $0.addTarget(self, action: #selector(closeButtonTapped(_:)), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .systemBackground
        
        setLayout()
        self.dismissKeyboardWhenTappedAround()
    }
    
    func setLayout(){
        [closeButton, alertLabel, emailTextField, passwordFindButton].forEach {
            self.view.addSubview($0)
        }
        
        closeButton.snp.makeConstraints{
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(20)
            $0.leading.equalToSuperview().offset(30)
            $0.width.height.equalTo(15)
        }
        
        alertLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(37)
            $0.trailing.equalToSuperview().offset(-38)
            $0.bottom.equalTo(emailTextField.snp.top).offset(-32)
        }
        
        emailTextField.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(37)
            $0.trailing.equalToSuperview().offset(-38)
            $0.bottom.equalTo(passwordFindButton.snp.top).offset(-22)
        }
        
        passwordFindButton.snp.makeConstraints{
            $0.centerY.equalToSuperview().multipliedBy(1.2)
            $0.leading.equalToSuperview().offset(37)
            $0.trailing.equalToSuperview().offset(-38)
            $0.height.equalTo(50)
        }
    }
    
    @objc
    func passwordFindButtonTapped(_ sender: UIButton){
        
    }
    
    @objc
    func closeButtonTapped(_ sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }
}
