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
    let passwordFindViewModel = PasswordFindViewModel()
    
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
    
    func popupSuccessAlertView(){
        let popupView = AlertView(frame: view.bounds)
        popupView.popupAlert(firstBtnTitle: nil, secondBtnTitle: "네", content: "이메일 전송 성공\n전송된 메일을 통해 비밀번호를 재설정 해주세요.", myView: popupView)
        popupView.cancelButton.isHidden = true
        popupView.delegate = self
        self.view.addSubview(popupView)
        self.view.layoutIfNeeded()
    }
    
    @objc
    func passwordFindButtonTapped(_ sender: UIButton){
        if let text = self.emailTextField.textField.text {
            self.passwordFindViewModel.requestFindPassword(email: text) { isSuccess in
                if isSuccess {
                    //TODO: 이메일 전송 성공
                    self.emailTextField.alertLabel.isHidden = true
                    self.popupSuccessAlertView()
                }else{
                    //TODO: 등록되지 않은 이메일 혹은 실패
                    self.emailTextField.alertLabel.isHidden = false
                }
            }
        }
    }
    
    @objc
    func closeButtonTapped(_ sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }
}

extension PasswordFindViewController: CustomAlertProtocol {
    func cancleButtonTapped(_ popupView: UIView) {
        popupView.removeFromSuperview()
    }

    func okButtonTapped(_ popupView: UIView, _ year: String?, _ month: String?) {
        popupView.removeFromSuperview()
        self.dismiss(animated: true, completion: nil)
    }

}
