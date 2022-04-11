//
//  TestViewController.swift
//  Cuppo
//
//  Created by 이하연 on 2022/04/11.
//

import UIKit
import SnapKit
import Then

class TestViewController: UIViewController {
    
    lazy var popupButton = UIButton().then {
        $0.setTitle("안녕", for: .normal)
        $0.addTarget(self, action: #selector(popupAlert(_:)), for: .touchUpInside)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
    }
    
    func setLayout(){
        [popupButton].forEach {
            self.view.addSubview($0)
        }
        
        popupButton.snp.makeConstraints{
            $0.centerX.centerY.equalToSuperview()
        }
    }
    
    @objc func popupAlert(_ sender: UIButton){
        backPopupView()
    }
    
    func backPopupView(){
        let popupView = AlertView(frame: view.bounds)
        popupView.popupAlert(firstBtnTitle: "아니요", secondBtnTitle: "예", content: "보이나요?", myView: popupView)
        popupView.delegate = self
        view.addSubview(popupView)
    }
}

extension TestViewController: CustomAlertProtocol {
    func cancleButtonTapped(_ popupView: UIView) {
        popupView.removeFromSuperview()
    }
    
    func okButtonTapped(_ popupView: UIView, _ year: String?, _ month: String?) {
        print("오케이")
        popupView.removeFromSuperview()
    }
}

