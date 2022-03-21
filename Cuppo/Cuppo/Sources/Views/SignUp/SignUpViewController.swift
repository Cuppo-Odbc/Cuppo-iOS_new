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
        self.emailTextField.textField.rx.text
            .orEmpty
            .bind(to: viewModel.emailObserver)
            .disposed(by: disposeBag)
        
        self.passwordTextField.textField.rx.text
            .orEmpty
            .bind(to: viewModel.passwordObserver)
            .disposed(by: disposeBag)

        self.passwordCheckTextField.textField.rx.text
            .orEmpty
            .bind(to: viewModel.passwordCheckObserver)
            .disposed(by: disposeBag)
        
        self.viewModel.isEmailVaild
            .bind(to: self.emailTextField.alertLabel.rx.isHidden)
            .disposed(by: disposeBag)

        self.viewModel.isPasswordValid
            .bind(to: self.passwordTextField.alertLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        self.viewModel.isPasswordCheckValid
            .bind(to: self.passwordCheckTextField.alertLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        self.signUpButton.rx.tap
            .bind{
                //TODO: 성공 메인으로 이동
                Observable.combineLatest(self.viewModel.isEmailVaild,
                                         self.viewModel.isPasswordValid,
                                         self.viewModel.isPasswordCheckValid)
                    .subscribe(onNext: { email, password, passwordCheck in
                        if email && password && passwordCheck {
                            print("회원가입 성공, 메인으로 이동")
                        }else {
                            //TODO: 잘못된 입력 alert
                            print("잘못된 입력 alert")
                        }
                    })
                    .disposed(by: self.disposeBag)
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
