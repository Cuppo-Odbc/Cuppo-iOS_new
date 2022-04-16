//
//  SettingViewController.swift
//  Cuppo
//
//  Created by 이하연 on 2022/03/08.
//

import UIKit
import SnapKit
import Then
import SwiftUI
import SafariServices

enum Menu: String {
    case fontStyle = "글자 스타일"
    case theme = "테마"
    case instargram = "인스타그램"
    case serviceInfo = "서비스 정보"
    case accountManagement = "계정 관리"
}

class SettingViewController: BaseController {
    //MARK: - Properties
    var menus: [Menu] = [.fontStyle, .theme, .instargram, .serviceInfo, .accountManagement]
    
    //MARK: - UI Components
    lazy var topSettingView = UIStackView().then{
        $0.axis = .vertical
        $0.spacing = 36
        $0.distribution = .equalSpacing
        $0.addArrangedSubview(fontMenu)
        $0.addArrangedSubview(themeMenu)
        $0.addArrangedSubview(instarMenu)
    }
    
    lazy var bottomSettingView = UIStackView().then{
        $0.axis = .vertical
        $0.spacing = 36
        $0.distribution = .equalSpacing
        $0.addArrangedSubview(serviceMenu)
        $0.addArrangedSubview(accountManagement)
    }
    
    lazy var fontMenu = SettingActionView().then{
        $0.actionDelegate = self
        $0.type = .fontStyle
        $0.setTitleLabel(text: Menu.fontStyle.rawValue, font: UIFont.globalFont(size: 16))
    }
    
    lazy var themeMenu = SettingActionView().then{
        $0.actionDelegate = self
        $0.type = .theme
        $0.setTitleLabel(text: Menu.theme.rawValue, font: UIFont.globalFont(size: 16))
        
    }
    lazy var instarMenu = SettingActionView().then{
        $0.actionDelegate = self
        $0.type = .instargram
        $0.setTitleLabel(text: Menu.instargram.rawValue, font: UIFont.globalFont(size: 16))
    }
    
    let viewDivider = UIView().then{
        $0.backgroundColor = UIColor(named: "cuppoColor10")
    }
    
    lazy var serviceMenu = SettingActionView().then{
        $0.actionDelegate = self
        $0.type = .serviceInfo
        $0.setTitleLabel(text: Menu.serviceInfo.rawValue, font: UIFont.globalFont(size: 16))
    }
    lazy var accountManagement = SettingActionView().then{
        $0.actionDelegate = self
        $0.type = .accountManagement
        $0.setTitleLabel(text: Menu.accountManagement.rawValue, font: UIFont.globalFont(size: 16))
    }
    
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground
        self.navigationController?.navigationBar.topItem?.title = "설정"
        self.customNavigationBarAttribute(.clear, UIColor(named: "cuppoColor1")!)
        setLayout()
    }
    
    //MARK: - Functions
    func setLayout(){
        [topSettingView, viewDivider, bottomSettingView].forEach {
            self.view.addSubview($0)
        }
        
        topSettingView.snp.makeConstraints{
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(41)
            $0.leading.equalTo(self.view.safeAreaLayoutGuide).offset(30)
            $0.trailing.equalTo(self.view.safeAreaLayoutGuide).offset(-30)
        }
        
        viewDivider.snp.makeConstraints{
            $0.top.equalTo(topSettingView.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        bottomSettingView.snp.makeConstraints{
            $0.top.equalTo(viewDivider.snp.bottom).offset(30)
            $0.leading.equalTo(self.view.safeAreaLayoutGuide).offset(30)
            $0.trailing.equalTo(self.view.safeAreaLayoutGuide).offset(-30)
        }
    }
}

extension SettingViewController: SettingActionDelegate {
    func tapMenu(menuType: Menu) {
        //TODO: 타입에 맞는 뷰컨으로 이동
        switch menuType {
        case .fontStyle:
            let letterVC = LetterStyleViewController()
            self.navigationController?.pushViewController(letterVC, animated: true)
        case .theme:
            let themeVC = ThemeViewController()
            self.navigationController?.pushViewController(themeVC, animated: true)
            break
        case .instargram:
            guard let instarUrl = URL(string: "https://www.instagram.com/cupp.o_/") else { return }
            let instarSafariView: SFSafariViewController = SFSafariViewController(url: instarUrl)
            DispatchQueue.main.async { [weak self] in
                self?.present(instarSafariView, animated: true, completion: nil)
            }
            break
        case .serviceInfo:
            guard let serviceUrl = URL(string: "https://charmed-veil-c90.notion.site/76b42075857548c1b032e90985857bbd") else { return }
            let serviceSafariView: SFSafariViewController = SFSafariViewController(url: serviceUrl)
            DispatchQueue.main.async { [weak self] in
                self?.present(serviceSafariView, animated: true, completion: nil)
            }
            break
        case .accountManagement:
            let accountVC = AccountManagementViewController()
            self.navigationController?.pushViewController(accountVC, animated: true)
            break
        }
    }
}
