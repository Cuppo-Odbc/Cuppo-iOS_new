//
//  LetterStyleViewController.swift
//  Cuppo
//
//  Created by 이숭인 on 2022/03/25.
//

import UIKit
import SnapKit
import Then

class LetterStyleViewController: BaseController {
    //MARK: - Properties
    let guideLabel = UILabel().then{
        $0.text = "커피 한 잔에 담긴, 오롯이 나만의 시간"
        $0.textAlignment = .center
        $0.font = .TTFont(type: .GFReg, size: 16)
    }
    
    let dividerView = UIView().then{
        $0.backgroundColor = .secondaryLabel
    }
    
    let fontLabel = UILabel().then{
        $0.text = "글꼴"
        $0.font = .TTFont(type: .GFReg, size: 18)
    }
    
    lazy var systemFontButton = RadioViewButton().then{
        $0.setTitleLabel(text: "시스템 폰트", font: .TTFont(type: .GFReg, size: 14))
    }
    
    lazy var basicFontButton = RadioViewButton().then{
        $0.setTitleLabel(text: "기본 글씨체", font: .TTFont(type: .GFReg, size: 14))
    }
    
    lazy var fontStackView = UIStackView().then{
        $0.axis = .vertical
        $0.spacing = 32
        $0.distribution = .equalSpacing
        $0.addArrangedSubview(systemFontButton)
        $0.addArrangedSubview(basicFontButton)
    }
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .systemBackground
        self.customNavigationBarAttribute(.clear, .black)
        self.navigationItem.title = "글자 스타일"
        
        setLayout()
    }
    
    func setLayout(){
        [guideLabel, dividerView, fontLabel, fontStackView].forEach {
            self.view.addSubview($0)
        }
        
        guideLabel.snp.makeConstraints{
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(81)
            $0.leading.trailing.equalToSuperview()
        }
        
        dividerView.snp.makeConstraints{
            $0.top.equalTo(guideLabel.snp.bottom).offset(60)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        fontLabel.snp.makeConstraints{
            $0.top.equalTo(dividerView.snp.bottom).offset(30)
            $0.leading.equalToSuperview().offset(30)
        }
        
        fontStackView.snp.makeConstraints{
            $0.top.equalTo(fontLabel.snp.bottom).offset(30)
            $0.leading.equalToSuperview().offset(30)
            $0.trailing.equalToSuperview().offset(-30)
        }
    }
}
