//
//  UserDataCenter.swift
//  Cuppo
//
//  Created by 이숭인 on 2022/03/26.
//

import UIKit
import SwiftUI

enum UserDefaultsKeys: String {
    case globalAppearanceMode
    case globalFont
}

enum GlobalAppearanceMode: String {
    case light = "light"
    case dark = "dark"
}

enum GlobalFontType: String {
    case systemFont = "systemFont"
    case goyangFont = "goyangFont"
    case dovemayo = "dovemayo"
    case dovemayoBold = "dovemayoBold"
    case kyoboHandwriting2019 = "kyoboHandwriting2019"
}

enum MemberType: String {
    case member // 회원
    case nonMember // 비회원
}

class UserDataCenter {
    static let shared = UserDataCenter()
    
    var accessToken: String?
    var memberType: MemberType?
    
    private init() { }
    
    //MARK: - Functions
    func setAccessToken(token: String){
        self.accessToken = token
    }
    
    func setMemberInfo(memberType: MemberType){
        self.memberType = memberType
    }
    
    /// 다크 모드 설정
    func setDarkMode(){
        UserDefaults.standard.set(true, forKey: "GlobalAppearanceMode")
        UserDefaults.standard.synchronize()
        
        let sceneDelegate = UIApplication.shared.connectedScenes.first!.delegate as! SceneDelegate
        sceneDelegate.window?.overrideUserInterfaceStyle = .dark
    }
        
    /// 라이트 모드 설정
    func setLightMode(){
        // 설정 저장
        UserDefaults.standard.set(false, forKey: "GlobalAppearanceMode")
        UserDefaults.standard.synchronize()
        
        let sceneDelegate = UIApplication.shared.connectedScenes.first!.delegate as! SceneDelegate
        sceneDelegate.window?.overrideUserInterfaceStyle = .light
    }
    
    func setGlobalFont(type: GlobalFontType){
        switch type {
        case .systemFont:
            let font = GlobalFont(type: GlobalFontType.systemFont.rawValue)
            let propertyEncoder = try? PropertyListEncoder().encode(font)
            UserDefaults.standard.set(propertyEncoder, forKey: UserDefaultsKeys.globalFont.rawValue)
            UserDefaults.standard.synchronize()
            break
        case .goyangFont:
            let font = GlobalFont(type: GlobalFontType.goyangFont.rawValue)
            let propertyEncoder = try? PropertyListEncoder().encode(font)
            UserDefaults.standard.set(propertyEncoder, forKey: UserDefaultsKeys.globalFont.rawValue)
            UserDefaults.standard.synchronize()
            break
        case .dovemayo:
            let font = GlobalFont(type: GlobalFontType.dovemayo.rawValue)
            let propertyEncoder = try? PropertyListEncoder().encode(font)
            UserDefaults.standard.set(propertyEncoder, forKey: UserDefaultsKeys.globalFont.rawValue)
            UserDefaults.standard.synchronize()
            break
        case .dovemayoBold:
            let font = GlobalFont(type: GlobalFontType.dovemayoBold.rawValue)
            let propertyEncoder = try? PropertyListEncoder().encode(font)
            UserDefaults.standard.set(propertyEncoder, forKey: UserDefaultsKeys.globalFont.rawValue)
            UserDefaults.standard.synchronize()
            break
        case .kyoboHandwriting2019:
            let font = GlobalFont(type: GlobalFontType.kyoboHandwriting2019.rawValue)
            let propertyEncoder = try? PropertyListEncoder().encode(font)
            UserDefaults.standard.set(propertyEncoder, forKey: UserDefaultsKeys.globalFont.rawValue)
            UserDefaults.standard.synchronize()
            break
        }
    }
    
    func getUserInterfaceStyle() -> Bool {
        return UserDefaults.standard.bool(forKey: "GlobalAppearanceMode")
    }
    
    func getGlobalFont() -> GlobalFontType {
        guard let _ = UserDefaults.standard.object(forKey: UserDefaultsKeys.globalFont.rawValue) else {
            return GlobalFontType.systemFont
        }
        
        guard let fontData = UserDefaults.standard.value(forKey: UserDefaultsKeys.globalFont.rawValue) as? Data else {
            return GlobalFontType.systemFont
        }
        
        if let font = try? PropertyListDecoder().decode(GlobalFont.self, from: fontData) {
            switch font.getFontType() {
            case .systemFont:
                return GlobalFontType.systemFont
            case .goyangFont:
                return GlobalFontType.goyangFont
            case .dovemayo:
                return GlobalFontType.dovemayo
            case .dovemayoBold:
                return GlobalFontType.dovemayoBold
            case .kyoboHandwriting2019:
                return GlobalFontType.kyoboHandwriting2019
            }
        }
        
        return GlobalFontType.systemFont
    }
}

struct GlobalFont: Codable {
    var fontType: String
    
    init(type: String){
        self.fontType = type
    }
    
    func getFontType() -> GlobalFontType{
        switch self.fontType {
        case GlobalFontType.systemFont.rawValue:
            return GlobalFontType.systemFont
        case GlobalFontType.goyangFont.rawValue:
            return GlobalFontType.goyangFont
        case GlobalFontType.dovemayo.rawValue:
            return GlobalFontType.dovemayo
        case GlobalFontType.dovemayoBold.rawValue:
            return GlobalFontType.dovemayoBold
        case GlobalFontType.kyoboHandwriting2019.rawValue:
            return GlobalFontType.kyoboHandwriting2019
        default:
            return GlobalFontType.systemFont
        }
    }
}
