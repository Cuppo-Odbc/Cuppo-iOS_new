//
//  BaseController.swift
//  Cuppo
//
//  Created by 이하연 on 2022/03/08.
//

import UIKit
import Then
import SnapKit

class BaseController: UIViewController {
    
    private lazy var bgImgView = UIImageView().then {
        $0.image = UIImage(named: "basicLightMode.jpeg")
        $0.contentMode = .scaleToFill
    }

    override func viewDidLoad() {
        super.viewDidLoad()
//        setBackground()
    }
    
    func setBackground(){
        self.view.addSubview(bgImgView)
        
        bgImgView.snp.makeConstraints{
            $0.top.bottom.trailing.leading.equalToSuperview().offset(0)
        }
    }

}

extension BaseController: CustomAlertProtocol {
    func cancleButtonTapped(_ sender: UIButton, _ selectView: UIView) {
        selectView.removeFromSuperview()
    }
    
    func okButtonTapped(_ sender: UIButton, _ selectView: UIView) {
        selectView.removeFromSuperview()
    }
}
