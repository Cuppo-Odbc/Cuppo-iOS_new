//
//  LetterStyleViewController.swift
//  Cuppo
//
//  Created by 이숭인 on 2022/03/25.
//

import UIKit
import SnapKit
import Then

protocol LetterViewDelegate {
    func radioButtonTapped(tag: Int) /// 폰트 설정
}

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
        $0.letterDelegate = self
        $0.tag = 1
    }
    
    lazy var basicFontButton = RadioViewButton().then{
        $0.setTitleLabel(text: "기본 글씨체", font: .TTFont(type: .GFReg, size: 14))
        $0.letterDelegate = self
        $0.tag = 2
    }
    
    lazy var dovemayoFontButton = RadioViewButton().then{
        $0.setTitleLabel(text: "Dovemayo", font: .TTFont(type: .dovemayo, size: 14))
        $0.letterDelegate = self
        $0.tag = 3
    }
    
    lazy var dovemayoBoldFontButton = RadioViewButton().then{
        $0.setTitleLabel(text: "DovemayoBold", font: .TTFont(type: .dovemayoBold, size: 14))
        $0.letterDelegate = self
        $0.tag = 4
    }
    
    lazy var kyoboFontButton = RadioViewButton().then{
        $0.setTitleLabel(text: "kyoboHandwriting2019", font: .TTFont(type: .kyoboHandwriting2019, size: 14))
        $0.letterDelegate = self
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
        self.navigationItem.title = "글자 스타일"
        
        setLetterButton()
        setLayout()
        setNavigationButton()
    }
    
    func setLetterButton(){
        switch UserDataCenter.shared.getGlobalFont() {
        case .systemFont:
            self.systemFontButton.radioButton.isSelected = true
            break
        case .goyangFont:
            self.basicFontButton.radioButton.isSelected = true
            break
        case .dovemayo:
            self.dovemayoFontButton.radioButton.isSelected = true
            break
        case .dovemayoBold:
            self.dovemayoBoldFontButton.radioButton.isSelected = true
            break
        case .kyoboHandwriting2019  :
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
    func back(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func setNavigationButton(){
        let backbutton = UIBarButtonItem(image: UIImage(named: "backButton"), style: .done, target: self, action: #selector(back))
        self.navigationItem.leftBarButtonItem = backbutton
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor(named: "cuppoColor1")
    }
    
    func popupAlertView(){
        let popupView = AlertView(frame: view.bounds)
        popupView.popupAlert(firstBtnTitle: nil, secondBtnTitle: "확인", content: "설정된 글꼴은 앱 재시작시 적용됩니다.", myView: popupView)
        popupView.cancelButton.isHidden = true
        popupView.delegate = self
        self.view.addSubview(popupView)
    }
    
    private func checkSeletedButton(tag: Int){
        [systemFontButton, basicFontButton, dovemayoFontButton, dovemayoBoldFontButton, kyoboFontButton].forEach { button in
            button.radioButton.isSelected = button.tag == tag ? true : false
        }
    }
}

extension LetterStyleViewController: LetterViewDelegate {
    func radioButtonTapped(tag: Int) {
        // 폰트설정 and 버튼 속성 변경
        switch tag {
        case 1:
            UserDataCenter.shared.setGlobalFont(type: .systemFont)
            self.guideLabel.font = UIFont.globalFont(size: 16)
            checkSeletedButton(tag: tag)
            self.popupAlertView()
            break
        case 2:
            UserDataCenter.shared.setGlobalFont(type: .goyangFont)
            self.guideLabel.font = UIFont.globalFont(size: 16)
            checkSeletedButton(tag: tag)
            self.popupAlertView()
            break
        case 3:
            UserDataCenter.shared.setGlobalFont(type: .dovemayo)
            self.guideLabel.font = UIFont.globalFont(size: 16)
            checkSeletedButton(tag: tag)
            self.popupAlertView()
            break
        case 4:
            UserDataCenter.shared.setGlobalFont(type: .dovemayoBold)
            self.guideLabel.font = UIFont.globalFont(size: 16)
            checkSeletedButton(tag: tag)
            self.popupAlertView()
            break
        case 5:
            UserDataCenter.shared.setGlobalFont(type: .kyoboHandwriting2019)
            self.guideLabel.font = UIFont.globalFont(size: 16)
            checkSeletedButton(tag: tag)
            self.popupAlertView()
            break
        default:
            UserDataCenter.shared.setGlobalFont(type: .systemFont)
            self.guideLabel.font = UIFont.globalFont(size: 16)
            checkSeletedButton(tag: tag)
            self.popupAlertView()
            break
        }
    }
}

extension LetterStyleViewController: CustomAlertProtocol {
    func cancleButtonTapped(_ popupView: UIView) {
        popupView.removeFromSuperview()
    }

    func okButtonTapped(_ popupView: UIView, _ year: String?, _ month: String?) {
        popupView.removeFromSuperview()
    }

}
