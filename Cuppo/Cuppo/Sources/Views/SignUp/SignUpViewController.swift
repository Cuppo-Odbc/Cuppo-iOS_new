//
//  SignUpViewController.swift
//  Cuppo
//
//  Created by 이숭인 on 2022/03/13.
//

import UIKit
import SnapKit
import Then
import RxSwift

class SignUpViewController: UIViewController {
    let disposeBag = DisposeBag()
    let viewModel = SignUpViewModel()
    
    //MARK: - UI Components
    let emailTextField = UnderLineTextField().then{
        $0.setPlaceHolder(placeHolder: "이메일")
        $0.setAlertLabel(text: "올바른 형식의 이메일을 입력해주세요.")
    }
    
    let passwordTextField = UnderLineTextField().then{
        $0.setPlaceHolder(placeHolder: "비밀번호 (영문, 숫자 포함 8자리 이상)")
        $0.setAlertLabel(text: "비밀번호를 입력해주세요. (영문, 숫자 포함 8자리 이상)")
        $0.textField.isSecureTextEntry = true
    }
    
    let passwordCheckTextField = UnderLineTextField().then{
        $0.setPlaceHolder(placeHolder: "비밀번호 확인")
        $0.setAlertLabel(text: "비밀번호가 일치하지 않습니다.")
        $0.textField.isSecureTextEntry = true
    }
    
    lazy var inputStackView = UIStackView().then{
        $0.axis = .vertical
        $0.distribution = .equalSpacing
        $0.spacing = 12.0
        $0.addArrangedSubview(emailTextField)
        $0.addArrangedSubview(passwordTextField)
        $0.addArrangedSubview(passwordCheckTextField)
    }
    
    let signUpButton = UIButton().then{
        $0.setTitle("회원가입", for: .normal)
        $0.titleLabel?.font = UIFont.TTFont(type: .GFReg, size: 16)
        $0.setTitleColor(.black, for: .normal)
        $0.backgroundColor = .white
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white

        setLayout()
        bind()
    }
    
    //MARK: - Functions
    func bind(){
        self.signUpButton.rx.tap
            .bind{
                let emailIsHidden = self.viewModel.verifyEmail(email: self.emailTextField.textField.text ?? "")
                let passwordIsHidden = self.viewModel.verifyPassword(password: self.passwordTextField.textField.text ?? "")
                let passwordCheckIsHidden = self.viewModel.verifyPasswordCheck(password: self.passwordTextField.textField.text ?? "", passwordCheck: self.passwordCheckTextField.textField.text ?? "")
                
                self.emailTextField.alertLabel.isHidden = emailIsHidden
                self.passwordTextField.alertLabel.isHidden = passwordIsHidden
                self.passwordCheckTextField.alertLabel.isHidden = passwordCheckIsHidden

                if [emailIsHidden, passwordIsHidden, passwordCheckIsHidden].contains(false) {
                    //TODO: false 가 존재한다면, 잘못된 입력 얼럿 띄우기
                    print("잘못된 입력입니다. 얼럿")
                }else{
                    //TODO: false 가 존재하지 않는다면, 회원가입 성공, 메인으로 이동
                    print("회원가입 성공, 메인화면으로 이동")
                    let sb = UIStoryboard(name: "TabBar", bundle: nil)
                    let tabbarVC = sb.instantiateViewController(withIdentifier: "tabbarViewController")
                    
                    self.view.window?.rootViewController = tabbarVC
                }
            }
            .disposed(by: disposeBag)
            
    }
    
    func setLayout(){
        [inputStackView, signUpButton].forEach {
            self.view.addSubview($0)
        }
        
        inputStackView.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().multipliedBy(0.7)
            $0.leading.equalToSuperview().offset(50)
            $0.trailing.equalToSuperview().offset(-50)
        }
        
        signUpButton.snp.makeConstraints{
            $0.top.equalTo(inputStackView.snp.bottom).offset(20.0)
            $0.leading.equalToSuperview().offset(50.0)
            $0.trailing.equalToSuperview().offset(-50)
            $0.height.equalTo(50.0)
        }
    }
}
