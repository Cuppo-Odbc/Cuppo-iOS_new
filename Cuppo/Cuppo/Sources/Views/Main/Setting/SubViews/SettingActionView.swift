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

class SettingActionView: UIView {
    //MARK: - Properties
    var delegate: SettingActionDelegate?
    var type: Menu?
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
        self.menuLabel.font = UIFont.TTFont(type: .GFReg, size: 16)
    }
    
    @objc
    func tap(_ sender: UITapGestureRecognizer){
        guard let tapDelegate = self.delegate else { return }
        guard let type = self.type else { return }
        
        tapDelegate.tapMenu(menuType: type)
    }
    
    func setLayout(){
        self.addSubview(menuLabel)
        
        menuLabel.snp.makeConstraints{
            $0.top.bottom.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }
}
