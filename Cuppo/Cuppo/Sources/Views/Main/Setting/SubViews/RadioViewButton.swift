//
//  RadioViewButton.swift
//  Cuppo
//
//  Created by 이숭인 on 2022/03/25.
//

import UIKit

class RadioViewButton: UIView {
    var themeType: GlobalAppearanceMode?
    var themeDelegate: ThemeViewDelegate?
    var letterDelegate: LetterViewDelegate?
    
    let menuLabel = UILabel()
    lazy var radioButton = UIButton().then {
        $0.setImage(UIImage(named: "selectedRadio"), for: .selected)
        $0.setImage(UIImage(named: "unselectedRadio"), for: .normal)
        $0.addTarget(self, action: #selector(radioTapped(_:)), for: .touchUpInside)
        $0.isSelected = false
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Functions
    func setTitleLabel(text: String, font: UIFont){
        self.menuLabel.text = text
        self.menuLabel.font = font
    }
    
    func setLayout(){
        [menuLabel, radioButton].forEach {
            self.addSubview($0)
        }
        
        menuLabel.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview()
        }
        
        radioButton.snp.makeConstraints{
            $0.top.bottom.trailing.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(18.0)
        }
    }
    
    @objc
    func radioTapped(_ sender: UIButton){
        // selected 설정 변경
        if let themeType = self.themeType {
            guard let themeDelegate = self.themeDelegate else { return }
            switch themeType {
            case .light:
                UserDataCenter.shared.setLightMode()
            case .dark:
                UserDataCenter.shared.setDarkMode()
            }
            
            themeDelegate.radioButtonTapped(tag: sender.tag)
        }
        
        if let letterDelegate = self.letterDelegate {
            letterDelegate.radioButtonTapped(tag: self.tag)
        }
        
    }
}
