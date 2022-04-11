//
//  UIViewController.swift
//  Cuppo
//
//  Created by 이하연 on 2022/03/08.
//

import UIKit
import Kingfisher

extension UIViewController {
    
    // MARK: 알림창 표시 -> 형태는 나중에 바꿀 것 같습니다
    func presentAlert(title: String?, message: String?, handler: ((UIAlertAction) -> Void)? = nil){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let actionDone = UIAlertAction(title: "확인", style: .default, handler: handler)
        alert.addAction(actionDone)
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: 빈 화면을 눌렀을 때 키보드가 내려가도록 처리
    func dismissKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer =
        UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(false)
    }
    
    // MARK: 인디케이터 표시
    func showIndicator() {
        IndicatorView.shared.show()
        IndicatorView.shared.showIndicator()
    }
    
    // MARK: 인디케이터 숨김
    @objc func dismissIndicator() {
        IndicatorView.shared.dismiss()
    }
    
    // MARK: - url -> img
    func urlToImg(urlStr: String, img: UIImageView){
        if let url: URL = URL(string: urlStr ){
            img.kf.indicatorType = .activity
            img.kf.setImage(with:url)
        }
    }
    
    // MARK: 네비게이션바 색상 커스텀
        func customNavigationBarAttribute(_ backgroundColor: UIColor,
                                          _ titleColor: UIColor) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = backgroundColor
            appearance.titleTextAttributes = [.foregroundColor: titleColor, .font: UIFont.globalFont(size: 18)]
            appearance.shadowColor = .clear
            self.navigationController?.navigationBar.standardAppearance = appearance
            self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
            self.navigationController?.navigationBar.tintColor = titleColor
            let yourBackImage = UIImage(named: "backButton")
            self.navigationController?.navigationBar.backIndicatorImage = yourBackImage
            self.navigationItem.backButtonTitle = ""
        }
    
}
