//
//  UIFont.swift
//  Cuppo
//
//  Created by 이하연 on 2022/03/08.
//

import UIKit

enum FontType {
    case GFReg
    case dovemayo
    case dovemayoBold
    case kyoboHandwriting2019
}
extension UIFont {
    static func TTFont(type: FontType, size: CGFloat) -> UIFont {
        var fontName = ""
        switch type {
        case .GFReg:
            fontName = "Goyang"
            break
        case .dovemayo:
            fontName = "dovemayo"
            break
        case .dovemayoBold:
            fontName = "devemayo_bold"
            break
        case .kyoboHandwriting2019:
            fontName = "Kyobo Handwriting 2019"
            break
        }
        
        return UIFont(name: fontName, size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    static func globalFont(size: CGFloat) -> UIFont {
        switch UserDataCenter.shared.getGlobalFont() {
        case .systemFont:
            return UIFont.systemFont(ofSize: size)
        case .goyangFont:
            return UIFont(name: "Goyang", size: size) ?? UIFont.systemFont(ofSize: size)
        case .dovemayo:
            return UIFont(name: "dovemayo", size: size) ?? UIFont.systemFont(ofSize: size)
        case .dovemayoBold:
            return UIFont(name: "devemayo_bold", size: size) ?? UIFont.systemFont(ofSize: size)
        case .kyoboHandwriting2019:
            return UIFont(name: "Kyobo Handwriting 2019", size: size) ?? UIFont.systemFont(ofSize: size)
        }
    }
}
