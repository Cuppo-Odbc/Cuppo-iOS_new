//
//  ThemeViewController.swift
//  Cuppo
//
//  Created by 이숭인 on 2022/03/26.
//

import UIKit

class ThemeViewController: UIViewController {
    //MARK: - UI Components
    let lightModeView = RadioViewButton().then{
        $0.setTitleLabel(text: "라이트 모드", font: .TTFont(type: .GFReg, size: 16))
    }
    
    let darkModeView = RadioViewButton().then{
        $0.setTitleLabel(text: "다크 모드", font: .TTFont(type: .GFReg, size: 16))
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
        
        setLayout()
    }
    
    func setLayout(){
        [themeStackView].forEach {
            self.view.addSubview($0)
        }
        
        themeStackView.snp.makeConstraints{
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(86)
            $0.leading.equalToSuperview().offset(30)
            $0.trailing.equalToSuperview().offset(-30)
        }
    }
}
