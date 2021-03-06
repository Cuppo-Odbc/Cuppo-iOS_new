//
//  SettingActionView.swift
//  Cuppo
//
//  Created by 이숭인 on 2022/03/25.
//

import UIKit
import SnapKit
import Then

protocol SettingActionDelegate {
    func tapMenu(menuType: Menu) /// 탭 이벤트 수행할 delegate 메소드
}

protocol SettingAccountDelegate {
    func tapMenu(menuType: AccountManagementMenu) ///
}

class SettingActionView: UIView {
    //MARK: - Properties
    var actionDelegate: SettingActionDelegate?
    var accountDelegate: SettingAccountDelegate?
    var type: Menu?
    var accountMenuType: AccountManagementMenu?
    //MARK: - UI Components
    let menuLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tap(_:)))
        self.addGestureRecognizer(tapGesture)
        
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTitleLabel(text: String, font: UIFont){
        self.menuLabel.text = text
        self.menuLabel.font = font
        self.menuLabel.adjustsFontForContentSizeCategory = true
    }
    
    @objc
    func tap(_ sender: UITapGestureRecognizer){
        if let tapDelegate = self.actionDelegate {
            guard let type = self.type else { return }
            
            tapDelegate.tapMenu(menuType: type)
        }
        
        if let accountDelegate = self.accountDelegate {
            guard let accountMenuType = accountMenuType else { return }

            accountDelegate.tapMenu(menuType: accountMenuType)
        }
        
        
    }
    
    func setLayout(){
        self.addSubview(menuLabel)
        
        menuLabel.snp.makeConstraints{
            $0.top.bottom.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }
}
