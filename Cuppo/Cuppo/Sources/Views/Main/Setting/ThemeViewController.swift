//
//  ThemeViewController.swift
//  Cuppo
//
//  Created by 이숭인 on 2022/03/26.
//

import UIKit

protocol ThemeViewDelegate {
    func radioButtonTapped(tag: Int) // 라이트 / 다크 모드 전환
}

class ThemeViewController: BaseController {
    //MARK: - UI Components
    lazy var lightModeView = RadioViewButton().then{
        $0.themeType = .light
        $0.themeDelegate = self
        $0.radioButton.tag = 1
        $0.setTitleLabel(text: "라이트 모드", font: UIFont.globalFont(size: 16))
    }
    
    lazy var darkModeView = RadioViewButton().then{
        $0.themeType = .dark
        $0.themeDelegate = self
        $0.radioButton.tag = 2
        $0.setTitleLabel(text: "다크 모드", font: UIFont.globalFont(size: 16))
    }
    
    lazy var themeStackView = UIStackView().then{
        $0.axis = .vertical
        $0.spacing = 36
        $0.distribution = .equalSpacing
        $0.addArrangedSubview(lightModeView)
        $0.addArrangedSubview(darkModeView)
    }
    
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground
        self.navigationItem.title = "테마"
        
        setThemeButton()
        setLayout()
    }
    
    func setThemeButton(){
        if UserDataCenter.shared.getUserInterfaceStyle() {
            self.lightModeView.radioButton.isSelected = false
            self.darkModeView.radioButton.isSelected = true
        }else{
            self.lightModeView.radioButton.isSelected = true
            self.darkModeView.radioButton.isSelected = false
        }
    }
    
    func setLayout(){
        [themeStackView].forEach {
            self.view.addSubview($0)
        }
        
        themeStackView.snp.makeConstraints{
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(41)
            $0.leading.equalToSuperview().offset(30)
            $0.trailing.equalToSuperview().offset(-30)
        }
    }
}


extension ThemeViewController: ThemeViewDelegate {
    func radioButtonTapped(tag: Int) {
        if tag == 1 {
            // 라이트
            self.lightModeView.radioButton.isSelected = true
            self.darkModeView.radioButton.isSelected = false
        }else{
            // 다크
            self.darkModeView.radioButton.isSelected = true
            self.lightModeView.radioButton.isSelected = false
        }
    }
}
