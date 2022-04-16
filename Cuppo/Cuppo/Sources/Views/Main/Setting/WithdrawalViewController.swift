//
//  WithdrawalViewController.swift
//  Cuppo
//
//  Created by 이숭인 on 2022/03/26.
//

import UIKit
import SnapKit
import Then

class RectViewButton: UIView {
    let rectButton = UIButton().then{
        $0.setImage(UIImage(named: "unselectedRectButton"), for: .normal)
        $0.setImage(UIImage(named: "selectedRectButton"), for: .selected)
    }
    
    let checkLabel = UILabel().then{
        $0.text = "위 내용을 모두 확인했습니다."
        $0.font = UIFont.globalFont(size: 16)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.rectButton.addTarget(self, action: #selector(tapped(_:)), for: .touchUpInside)
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapped(_:))))
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLayout(){
        [rectButton, checkLabel].forEach {
            self.addSubview($0)
        }
        
        rectButton.snp.makeConstraints{
            $0.top.leading.bottom.equalToSuperview()
            $0.width.height.equalTo(20)
        }
        
        checkLabel.snp.makeConstraints{
            $0.leading.equalTo(rectButton.snp.trailing).offset(14)
            $0.centerY.equalTo(rectButton.snp.centerY)
        }
    }
    
    @objc
    func tapped(_ sender: UITapGestureRecognizer){
        //TODO: button selected change ok
        self.rectButton.isSelected = !self.rectButton.isSelected
    }
}

class WithdrawalViewController: BaseController {
    //MARK: - Properties
    let viewModel = WithdrawalViewModel()
    
    let alertText = "탈퇴한 계정 및 이용 내역은 복구나 재사용이 불가능하니 탈퇴 시 유의하시기 바랍니다.\n\n탈퇴 시, 구매 내역은 모두 소멸되며 환불할 수 없습니다. 또한 다른 계정으로 양도할 수 없습니다."
    
    lazy var alertLabel = UILabel().then{
        $0.numberOfLines = 0
        $0.text = alertText
        $0.font = UIFont.globalFont(size: 16)
    }
    
    lazy var closeButton = UIButton().then{
        $0.setImage(UIImage(named: "closeButton"), for: .normal)
        $0.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
    }
    
    let checkViewButton = RectViewButton()
    
    lazy var withdrawalButton = UIButton().then{
        $0.setTitle("회원탈퇴", for: .normal)
        $0.setTitleColor(UIColor(named: "cuppoColor14"), for: .normal)
        $0.titleLabel?.font = UIFont.globalFont(size: 16)
        $0.layer.borderColor = UIColor(named: "cuppoColor14")?.cgColor
        $0.layer.borderWidth = 1.0
        $0.addTarget(self, action: #selector(withdrawalButtonTapped(_:)), for: .touchUpInside)
    }
    
    let navigationTitleLabel = UILabel().then{
        $0.text = "회원탈퇴"
        $0.font = UIFont.globalFont(size: 18)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        setLayout()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        self.withdrawalButton.layer.borderColor = UIColor(named: "cuppoColor14")?.cgColor
    }

    func popupSuccessAlertView(){
        let popupView = AlertView(frame: view.bounds)
        popupView.popupAlert(firstBtnTitle: nil, secondBtnTitle: "확인", content: "회원탈퇴가 완료되었습니다.", myView: popupView)
        popupView.delegate = self
        popupView.cancelButton.isHidden = true
        self.view.addSubview(popupView)
    }
    
    func popupFailureAlertView(){
        let popupView = AlertView(frame: view.bounds)
        popupView.popupAlert(firstBtnTitle: nil, secondBtnTitle: "확인", content: "회원탈퇴 실패\n다시 시도해주세요.", myView: popupView)
        popupView.delegate = self
        popupView.cancelButton.isHidden = true
        self.view.addSubview(popupView)
    }
    
    func popupWaringAlertView(){
        let popupView = AlertView(frame: view.bounds)
        popupView.popupAlert(firstBtnTitle: "확인", secondBtnTitle: nil, content: "약관 확인 후 동의해주세요.", myView: popupView)
        popupView.delegate = self
        popupView.okButton.isHidden = true
        self.view.addSubview(popupView)
    }
    
    func setLayout(){
        [alertLabel, closeButton, checkViewButton, withdrawalButton, navigationTitleLabel].forEach {
            self.view.addSubview($0)
        }
        
        closeButton.snp.makeConstraints{
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(20)
            $0.leading.equalToSuperview().offset(30)
            $0.width.height.equalTo(15)
        }
        
        alertLabel.snp.makeConstraints{
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(185.0)
            $0.leading.equalToSuperview().offset(38)
            $0.trailing.equalToSuperview().offset(-37)
        }
        
        checkViewButton.snp.makeConstraints{
            $0.top.equalTo(alertLabel.snp.bottom).offset(88)
            $0.leading.equalToSuperview().offset(38)
            $0.trailing.equalToSuperview().offset(-37)
        }
        
        withdrawalButton.snp.makeConstraints{
            $0.centerY.equalToSuperview().multipliedBy(1.7)
            $0.leading.equalToSuperview().offset(38)
            $0.trailing.equalToSuperview().offset(-37)
            $0.height.equalTo(50)
        }
        
        navigationTitleLabel.snp.makeConstraints{
            $0.centerY.equalTo(closeButton.snp.centerY)
            $0.centerX.equalToSuperview()
        }
    }
    
    @objc
    func closeButtonTapped(_ sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc
    func withdrawalButtonTapped(_ sender: UIButton){
        if self.checkViewButton.rectButton.isSelected {
            self.viewModel.requestWithdrawal { isSuccess in
                if isSuccess { //TODO: 회원 탈퇴 완료 얼럿, 로그인 화면으로 전환
                    print("회원탈퇴 성공")
                    self.popupSuccessAlertView()
                } else{ // 회원 탈퇴 실패 얼럿
                    self.popupFailureAlertView()
                    print("회원탈퇴 실패")
                }
            }
        }else{
            //TODO: 체크해달라는 alert 띄워야함
            print("약관 동의 해주세영")
            self.popupWaringAlertView()
        }
    }
}

extension WithdrawalViewController: CustomAlertProtocol {
    func cancleButtonTapped(_ popupView: UIView) {
        popupView.removeFromSuperview()
    }

    func okButtonTapped(_ popupView: UIView, _ year: String?, _ month: String?) {
        popupView.removeFromSuperview()
        self.dismiss(animated: true, completion: nil)
        
        self.view.window?.rootViewController = UINavigationController(rootViewController: LoginViewController())
    }

}
