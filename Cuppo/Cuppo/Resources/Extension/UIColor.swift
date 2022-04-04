//
//  UIColor.swift
//  Cuppo
//
//  Created by 이하연 on 2022/03/08.
//
import UIKit

extension UIColor {
    // MARK: hex code를 이용하여 정의
    convenience init(hex: UInt, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hex & 0x0000FF) / 255.0,
            alpha: CGFloat(alpha)
        )
    }
    
    // MARK: 메인 테마 색 또는 자주 쓰는 색을 정의합시다
    class var bgColor: UIColor { UIColor(hex: 0xE5E5E5) }
    class var cuppoGray: UIColor { UIColor(hex: 0xAEAEAE)}
}
