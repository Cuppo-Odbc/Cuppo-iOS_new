//
//  PasswordChangeViewController.swift
//  Cuppo
//
//  Created by 이숭인 on 2022/03/26.
//

import UIKit

class PasswordChangeViewController: BaseController {
    let passwordChangeViewModel = PasswordChangeViewModel()
    
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
        $0.setTitleColor(UIColor(named: "cuppoColor14"), for: .normal)
        $0.titleLabel?.font = UIFont.globalFont(size: 16)
        $0.layer.borderColor = UIColor(named: "cuppoColor14")?.cgColor
        $0.layer.borderWidth = 1.0
        $0.addTarget(self, action: #selector(passwordChangeButtonTapped(_:)), for: .touchUpInside)
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
        $0.setImage(UIImage(named: "closeButton"), for: .normal)
        $0.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
    }
    
    let navigationTitleLabel = UILabel().then{
        $0.text = "비밀번호 변경"
        $0.font = UIFont.globalFont(size: 18)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground
        
        setLayout()
        setNavigationButton()
        self.dismissKeyboardWhenTappedAround()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        self.passwordChangeButton.layer.borderColor = UIColor(named: "cuppoColor14")?.cgColor
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
    
    func setLayout(){
        [passwordStackView, passwordChangeButton, closeButton, navigationTitleLabel].forEach {
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
        
        navigationTitleLabel.snp.makeConstraints{
            $0.centerY.equalTo(closeButton.snp.centerY)
            $0.centerX.equalToSuperview()
        }
    }
    
    func popupSuccessAlertView(){
        let popupView = AlertView(frame: view.bounds)
        popupView.popupAlert(firstBtnTitle: nil, secondBtnTitle: "확인", content: "비밀번호가 성공적으로 변경되었습니다.", myView: popupView)
        popupView.cancelButton.isHidden = true
        popupView.delegate = self
        self.view.addSubview(popupView)
    }
    
    func popupFailureAlertView(){
        let popupView = AlertView(frame: view.bounds)
        popupView.popupAlert(firstBtnTitle: nil, secondBtnTitle: "확인", content: "비밀번호 변경 실패\n올바른 비밀번호를 입력해주세요.", myView: popupView)
        popupView.cancelButton.isHidden = true
        popupView.delegate = self
        self.view.addSubview(popupView)
    }
    
    @objc
    func passwordChangeButtonTapped(_ sender: UIButton){
        // 임시 조건: 새 비번, 새 비번확인 같은경우 -> 나중엔 현재비번 검증 and 새 비번, 새 비번확인 같은경우로 수정해야함
        if self.newPasswordTextField.textField.text == self.newPasswordCheckTextField.textField.text {
            self.passwordChangeViewModel.requestPasswordChange(password: self.newPasswordTextField.textField.text ?? "") { isSuccess in
                if isSuccess { // 비밀번호 변경 성공 -> 성공 얼럿 띄우고, ok액션에 dismiss.
                    print("비밀번호 변경 성공")
                    self.newPasswordCheckTextField.alertLabel.isHidden = true
                    self.popupSuccessAlertView()
                }else{ // 비밀번호 변경 실패 다시시도해주세요~
                    print("비밀번호 변경 실패")
                    self.newPasswordCheckTextField.alertLabel.isHidden = true
                    self.popupFailureAlertView()
                }
            }
        }else{
            print("비번 확인 다름")
            self.newPasswordCheckTextField.alertLabel.isHidden = false
        }
        
    }
    
    @objc
    func closeButtonTapped(_ sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }
}

extension PasswordChangeViewController: CustomAlertProtocol {
    func cancleButtonTapped(_ popupView: UIView) {
        popupView.removeFromSuperview()
    }

    func okButtonTapped(_ popupView: UIView, _ year: String?, _ month: String?) {
        popupView.removeFromSuperview()
        self.dismiss(animated: true, completion: nil)
    }

}
