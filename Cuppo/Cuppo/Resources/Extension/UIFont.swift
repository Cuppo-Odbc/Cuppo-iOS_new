//
//  UIFont.swift
//  Cuppo
//
//  Created by 이하연 on 2022/03/08.
//

import UIKit

enum FontType {
    case GFReg
}
extension UIFont {
    static func TTFont(type: FontType, size: CGFloat) -> UIFont {
        var fontName = ""
        switch type {
        case .GFReg:
            fontName = "Goyang"
        }
        
        return UIFont(name: fontName, size: size) ?? UIFont.systemFont(ofSize: size)
    }
}
