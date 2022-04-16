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

class SignUpViewController: BaseController {
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
        $0.titleLabel?.font = UIFont.globalFont(size: 16)
        $0.setTitleColor(.black, for: .normal)
        $0.backgroundColor = .white
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    lazy var closeButton = UIButton().then{
        $0.setImage(UIImage(named: "closeButton"), for: .normal)
        $0.addTarget(self, action: #selector(closeButtonTapped(_:)), for: .touchUpInside)
    }
    
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setLayout()
        bind()
        self.dismissKeyboardWhenTappedAround()
    }
    
    //MARK: - Functions

    
    func popupSuccessAlertView(){
        let popupView = AlertView(frame: view.bounds)
        popupView.popupAlert(firstBtnTitle: nil, secondBtnTitle: "확인", content: "회원가입이 완료되었습니다.\n로그인 화면으로 이동합니다.", myView: popupView)
        popupView.cancelButton.isHidden = true
        popupView.delegate = self
        self.view.addSubview(popupView)
        self.view.layoutIfNeeded()
    }
    
    func popupFailureAlertView(){
        let popupView = AlertView(frame: view.bounds)
        popupView.popupAlert(firstBtnTitle: "확인", secondBtnTitle: nil, content: "회원가입 실패\n중복된 이메일입니다. 다시 입력해주세요.", myView: popupView)
        popupView.okButton.isHidden = true
        popupView.delegate = self
        self.view.addSubview(popupView)
        self.view.layoutIfNeeded()
    }
    
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
                    //TODO: false 가 존재한다면, 잘못된 입력 얼럿 띄우기 굳이?
                    print("잘못된 입력입니다. 얼럿")
                }else{
                    //TODO: false 가 존재하지 않는다면, 회원가입 성공, 메인으로 이동
                    self.viewModel.signUp(email: self.emailTextField.textField.text ?? "",
                                          password: self.passwordTextField.textField.text ?? "") { isSignupSuccess in
                        if isSignupSuccess {
                            //TODO: 회원가입 성공, 로그인 화면으로 이동
                            self.view.endEditing(false)
                            self.emailTextField.alertLabel.isHidden = true
                            self.popupSuccessAlertView()
                        }else{
                            //TODO: 실패 - 중복된 이메일입니다 alert 띄우기
                            self.view.endEditing(false)
                            self.emailTextField.alertLabel.isHidden = false
                            self.popupFailureAlertView()
                        }
                    }
                }
            }
            .disposed(by: disposeBag)
            
    }
    
    func setLayout(){
        [closeButton, inputStackView, signUpButton].forEach {
            self.view.addSubview($0)
        }
        
        closeButton.snp.makeConstraints{
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(20)
            $0.leading.equalToSuperview().offset(30)
            $0.width.height.equalTo(15)
        }
        
        inputStackView.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().offset(37)
            $0.trailing.equalToSuperview().offset(-38)
            $0.bottom.equalTo(signUpButton.snp.top).offset(-12)
        }
        
        signUpButton.snp.makeConstraints{
            $0.centerY.equalToSuperview().multipliedBy(1.2)
            $0.leading.equalToSuperview().offset(37)
            $0.trailing.equalToSuperview().offset(-38)
            $0.height.equalTo(50.0)
        }
    }
    
    @objc
    func closeButtonTapped(_ sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension SignUpViewController: CustomAlertProtocol {
    func cancleButtonTapped(_ popupView: UIView) {
        popupView.removeFromSuperview()
    }

    func okButtonTapped(_ popupView: UIView, _ year: String?, _ month: String?) {
        popupView.removeFromSuperview()
        self.dismiss(animated: true, completion: nil)
    }

}
