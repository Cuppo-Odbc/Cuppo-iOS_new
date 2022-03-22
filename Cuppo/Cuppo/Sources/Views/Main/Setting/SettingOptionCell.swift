//
//  SettingOptionCell.swift
//  Cuppo
//
//  Created by 이숭인 on 2022/03/23.
//

import UIKit
import SnapKit
import Then

class SettingOptionCell: UITableViewCell {
    static let identifier = "settingOptionCell"
    
    let optionLabel = UILabel().then{
        $0.font = UIFont.TTFont(type: .GFReg, size: 16.0)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(optionModel: String){
        self.optionLabel.text = optionModel
    }
    
    
    func setLayout(){
        [optionLabel].forEach {
            self.contentView.addSubview($0)
        }
        
        optionLabel.snp.makeConstraints{
            $0.leading.equalTo(self.contentView.safeAreaLayoutGuide).offset(30.0)
            $0.centerY.equalToSuperview()
        }
    }
    
}
