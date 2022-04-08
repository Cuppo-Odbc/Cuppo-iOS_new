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
        $0.font = .globalFont(size: 16)
    }
    
    let dividerView = UIView().then{
        $0.backgroundColor = .secondaryLabel
    }
    
    let fontLabel = UILabel().then{
        $0.text = "글꼴"
        $0.font = UIFont.globalFont(size: 18)
    }
    
    lazy var systemFontButton = RadioViewButton().then{
        $0.setTitleLabel(text: "시스템 폰트", font: .systemFont(ofSize: 14))
        $0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(systemFontButtonTapped(_:))))
        $0.tag = 1
    }
    
    lazy var basicFontButton = RadioViewButton().then{
        $0.setTitleLabel(text: "기본 글씨체", font: .TTFont(type: .GFReg, size: 14))
        $0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(basicFontButtonTapped(_:))))
        $0.tag = 2
    }
    
    lazy var dovemayoFontButton = RadioViewButton().then{
        $0.setTitleLabel(text: "Dovemayo", font: .TTFont(type: .dovemayo, size: 14))
        $0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(basicFontButtonTapped(_:))))
        $0.tag = 3
    }
    
    lazy var dovemayoBoldFontButton = RadioViewButton().then{
        $0.setTitleLabel(text: "DovemayoBold", font: .TTFont(type: .dovemayoBold, size: 14))
        $0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(basicFontButtonTapped(_:))))
        $0.tag = 4
    }
    
    lazy var kyoboFontButton = RadioViewButton().then{
        $0.setTitleLabel(text: "kyoboHandwriting2019", font: .TTFont(type: .kyoboHandwriting2019, size: 14))
        $0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(basicFontButtonTapped(_:))))
        $0.tag = 5
    }
    
    lazy var fontStackView = UIStackView().then{
        $0.axis = .vertical
        $0.spacing = 32
        $0.distribution = .equalSpacing
        $0.addArrangedSubview(systemFontButton)
        $0.addArrangedSubview(basicFontButton)
        $0.addArrangedSubview(dovemayoFontButton)
        $0.addArrangedSubview(dovemayoBoldFontButton)
        $0.addArrangedSubview(kyoboFontButton)
    }
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .systemBackground
        self.customNavigationBarAttribute(.clear, .black)
        self.navigationItem.title = "글자 스타일"
        
        setLetterButton()
        setLayout()
    }
    
    func setLetterButton(){
        switch UserDataCenter.shared.getGlobalFont() {
        case .systemFont:
            self.systemFontButton.radioButton.isSelected = true
            self.basicFontButton.radioButton.isSelected = false
            self.dovemayoFontButton.radioButton.isSelected = false
            self.dovemayoBoldFontButton.radioButton.isSelected = false
            self.kyoboFontButton.radioButton.isSelected = false
            break
        case .goyangFont:
            self.systemFontButton.radioButton.isSelected = false
            self.basicFontButton.radioButton.isSelected = true
            self.dovemayoFontButton.radioButton.isSelected = false
            self.dovemayoBoldFontButton.radioButton.isSelected = false
            self.kyoboFontButton.radioButton.isSelected = false
            break
        case .dovemayo:
            self.systemFontButton.radioButton.isSelected = false
            self.basicFontButton.radioButton.isSelected = false
            self.dovemayoFontButton.radioButton.isSelected = true
            self.dovemayoBoldFontButton.radioButton.isSelected = false
            self.kyoboFontButton.radioButton.isSelected = false
            break
        case .dovemayoBold:
            self.systemFontButton.radioButton.isSelected = false
            self.basicFontButton.radioButton.isSelected = false
            self.dovemayoFontButton.radioButton.isSelected = false
            self.dovemayoBoldFontButton.radioButton.isSelected = true
            self.kyoboFontButton.radioButton.isSelected = false
            break
        case .kyoboHandwriting2019  :
            self.systemFontButton.radioButton.isSelected = false
            self.basicFontButton.radioButton.isSelected = false
            self.dovemayoFontButton.radioButton.isSelected = false
            self.dovemayoBoldFontButton.radioButton.isSelected = false
            self.kyoboFontButton.radioButton.isSelected = true
            break
        }
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
    
    @objc
    func systemFontButtonTapped(_ sender: UITapGestureRecognizer){
        // 폰트설정 and 버튼 속성 변경
        UserDataCenter.shared.setGlobalFont(type: .systemFont)
        
        self.systemFontButton.radioButton.isSelected = true
        self.basicFontButton.radioButton.isSelected = false
        self.guideLabel.font = UIFont.globalFont(size: 16)
    }
    
    @objc
    func basicFontButtonTapped(_ sender: UITapGestureRecognizer){
        // 폰트설정 and 버튼 속성 변경
        switch sender.view?.tag {
        case 1:
            UserDataCenter.shared.setGlobalFont(type: .systemFont)
            break
        case 2:
            UserDataCenter.shared.setGlobalFont(type: .goyangFont)
            break
        case 3:
            UserDataCenter.shared.setGlobalFont(type: .dovemayo)
            break
        case 4:
            UserDataCenter.shared.setGlobalFont(type: .dovemayoBold)
            break
        case 5:
            UserDataCenter.shared.setGlobalFont(type: .kyoboHandwriting2019)
            break
        case .none:
            UserDataCenter.shared.setGlobalFont(type: .systemFont)
            break
        case .some(_):
            UserDataCenter.shared.setGlobalFont(type: .systemFont)
            break
        }
        
        self.systemFontButton.radioButton.isSelected = false
        self.basicFontButton.radioButton.isSelected = true
        self.guideLabel.font = UIFont.globalFont(size: 16)
    }
}
