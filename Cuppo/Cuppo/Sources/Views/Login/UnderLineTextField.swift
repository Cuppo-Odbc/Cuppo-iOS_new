//
//  UnderLineTextField.swift
//  Cuppo
//
//  Created by 이숭인 on 2022/03/13.
//

import UIKit
import SnapKit
import Then

class UnderLineTextField: UIView {
    //MARK: - UI Components
    let textField = UITextField().then{
        $0.textColor = .black
    }
    
    let underLine = UIView().then{
        $0.backgroundColor = .black
    }
    
    let alertLabel = UILabel().then{
        $0.textColor = .red
        $0.isHidden = true
    }
    
    //MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setLayout()
        setAttribute()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Functions
    private func setAttribute(){
        //TODO: 나중에 앱 설정을 가지고 있는 SingleTone 객체 값 받아와서 폰트, 사이즈 설정값 넣어주기    gfreg -> ???
        self.textField.font = UIFont.TTFont(type: .GFReg, size: 16)
        self.alertLabel.font = UIFont.TTFont(type: .GFReg, size: 12)
    }
    
    private func setLayout(){
        [textField, underLine, alertLabel].forEach {
            self.addSubview($0)
        }
        
        textField.snp.makeConstraints{
            $0.top.leading.trailing.equalToSuperview()
        }
        
        underLine.snp.makeConstraints{
            $0.top.equalTo(textField.snp.bottom).offset(8.0)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        alertLabel.snp.makeConstraints{
            $0.top.equalTo(underLine.snp.bottom).offset(7.0)
            $0.leading.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    /**
        UnderLine Text Field 의 Place Holder 를 설정하는 메소드
     
        - Parameter placeHolder: 지정하고자 하는 placeHolder 문자열
     */
    func setPlaceHolder(placeHolder: String) {
        self.textField.placeholder = placeHolder
    }
    
    /**
        UnderLine Text Field 의 경고 문구를 설정하는 메소드
     
        - Parameter text: 경고 문구 텍스트
     */
    func setAlertLabel(text: String) {
        self.alertLabel.text = text
    }
    
    func showAlertLabel() {
        self.alertLabel.isHidden = false
    }
    
    func hideAlertLabel() {
        self.alertLabel.alpha = 0
    }
}
