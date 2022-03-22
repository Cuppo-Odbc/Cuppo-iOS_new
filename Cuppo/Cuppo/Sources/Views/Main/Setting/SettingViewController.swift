//
//  SettingViewController.swift
//  Cuppo
//
//  Created by 이하연 on 2022/03/08.
//

import UIKit
import SnapKit
import Then

class SettingViewController: BaseController {

    lazy var testButton = UIButton().then{
        $0.setTitle("전환", for: .normal)
        $0.setTitleColor(.systemBackground, for: .normal)
        $0.backgroundColor = .black
        $0.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
    }
    
    let testLable = UILabel().then{
        $0.text = "adsasdasdjasdasdjaskdas"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground
        
        setLayout()
    }
    
    func setLayout(){
        self.view.addSubview(testButton)
        self.view.addSubview(testLable)
        
        testButton.snp.makeConstraints{
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(32.0)
            $0.leading.equalToSuperview().offset(120.0)
            $0.trailing.equalToSuperview().offset(-120.0)
            $0.height.equalTo(60.0)
        }
        
        testLable.snp.makeConstraints{
            $0.top.equalTo(testButton.snp.bottom).offset(32.0)
            $0.centerX.equalToSuperview()
        }
    }
    
    @objc
    func buttonTapped(_ sender: UIButton){
        let testVC = SettingTwoViewController()
        
        self.navigationController?.pushViewController(testVC, animated: true)
    }
}
