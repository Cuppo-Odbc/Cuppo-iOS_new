//
//  LoginViewController.swift
//  Cuppo
//
//  Created by 이숭인 on 2022/03/13.
//

import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

class LoginViewController: BaseController {
    //MARK: - Properties
    let disposeBag = DisposeBag()
    let viewModel = LoginViewModel()
    
    //MARK: - UI Components
    let emailTextField = UnderLineTextField().then{
        $0.setPlaceHolder(placeHolder: "이메일")
        $0.setAlertLabel(text: "해당 이메일로 등록된 회원 정보가 없습니다.")
    }
    
    let passwordTextField = UnderLineTextField().then{
        $0.setPlaceHolder(placeHolder: "비밀번호")
        $0.setAlertLabel(text: "비밀번호가 다릅니다.")
//        $0.textField.isSecureTextEntry = true
    }
    
    lazy var inputStackView = UIStackView().then{
        $0.axis = .vertical
        $0.distribution = .equalSpacing
        $0.spacing = 12.0
        $0.addArrangedSubview(emailTextField)
        $0.addArrangedSubview(passwordTextField)
    }
    
    let loginButton = UIButton().then {
        $0.setTitle("로그인", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.TTFont(type: .GFReg, size: 16)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.backgroundColor = .white
    }
    
    let passwordFindButton = UIButton().then{
        $0.setTitle("비밀번호 찾기", for: .normal)
        $0.setTitleColor(.lightGray, for: .normal)
        $0.titleLabel?.font = UIFont.TTFont(type: .GFReg, size: 12)
    }
    
    let signUpButton = UIButton().then{
        $0.setTitle("회원가입", for: .normal)
        $0.setTitleColor(.lightGray, for: .normal)
        $0.titleLabel?.font = UIFont.TTFont(type: .GFReg, size: 12)
    }
    
    let separaterView = UIView().then{
        $0.backgroundColor = .lightGray
    }
    
    let startWithoutLoginButton = UIButton().then{
        $0.setTitle("로그인 없이 시작하기", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.TTFont(type: .GFReg, size: 16)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.black.cgColor
    }
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        setLayout()
        bind()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    //MARK: - Functions
    func bind(){
        self.loginButton.rx.tap
            .bind{
                //TODO: 로그인 검증 로직
                self.viewModel.login(email: self.emailTextField.textField.text ?? "",
                                     password: self.passwordTextField.textField.text ?? ""){ response in
                    switch response.type {
                    case .success:
                        //TODO: 로그인 성공, 메인화면으로 전환 and 인디케이터 넣어도 좋음
                        // 타입별로 구분해서 하면됨 1. 성공, 2 실패, 오류
                        let sb = UIStoryboard(name: "TabBar", bundle: nil)
                        let tabbarVC = sb.instantiateViewController(withIdentifier: "tabbarViewController")
                        
                        self.view.window?.rootViewController = tabbarVC
                        break
                    case .fail:
                        guard let failureType = response.loginFailure?.getFailureType() else { return }
                        switch failureType {
                        case .invalidPassword:
                            //TODO: 패스워드 올바르지않음 얼럿
                            self.passwordTextField.alertLabel.isHidden = false
                            print("패스워드 올바르지 않음")
                            break
                        case .emailNotFound:
                            //TODO: 이메일 올바르지 않음 alert
                            self.emailTextField.alertLabel.isHidden = false
                            print("이메일 올바르지 않음")
                            break
                        case .exception:
                            //TODO: 예외 얼럿
                            self.emailTextField.alertLabel.isHidden = false
                            print("이메일 올바르지 않음")
                            break
                        }
                    } //switch
                }
            }
            .disposed(by: disposeBag)
        
        self.startWithoutLoginButton.rx.tap
            .bind{
                let sb = UIStoryboard(name: "TabBar", bundle: nil)
                let tabbarVC = sb.instantiateViewController(withIdentifier: "tabbarViewController")
                
                self.view.window?.rootViewController = tabbarVC
            }
            .disposed(by: disposeBag)
        
        self.signUpButton.rx.tap
            .bind{
                //TODO: 회원가입 화면으로 이동
                self.navigationController?.pushViewController(SignUpViewController(), animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    func setLayout(){
        [inputStackView, loginButton,
         passwordFindButton, separaterView, signUpButton, startWithoutLoginButton].forEach {
            self.view.addSubview($0)
        }
        
        inputStackView.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().multipliedBy(0.7)
            $0.leading.equalToSuperview().offset(50)
            $0.trailing.equalToSuperview().offset(-50)
        }
        
        loginButton.snp.makeConstraints{
            $0.top.equalTo(inputStackView.snp.bottom).offset(16.0)
            $0.leading.equalToSuperview().offset(50)
            $0.trailing.equalToSuperview().offset(-50)
            $0.height.equalTo(50.0)
        }
        
        passwordFindButton.snp.makeConstraints{
            $0.centerX.equalTo(loginButton.snp.centerX).multipliedBy(0.6)
            $0.top.equalTo(loginButton.snp.bottom).offset(10)
        }
        
        signUpButton.snp.makeConstraints{
            $0.centerX.equalTo(loginButton.snp.centerX).multipliedBy(1.4)
            $0.top.equalTo(loginButton.snp.bottom).offset(10)
        }
        
        separaterView.snp.makeConstraints{
            $0.centerX.equalTo(loginButton.snp.centerX)
            $0.centerY.equalTo(passwordFindButton.snp.centerY)
            $0.height.equalTo(12.0)
            $0.width.equalTo(1)
        }
        
        startWithoutLoginButton.snp.makeConstraints{
            $0.top.equalTo(loginButton.snp.bottom).offset(100)
            $0.leading.equalToSuperview().offset(50)
            $0.trailing.equalToSuperview().offset(-50)
            $0.height.equalTo(50.0)
        }
    }
}
