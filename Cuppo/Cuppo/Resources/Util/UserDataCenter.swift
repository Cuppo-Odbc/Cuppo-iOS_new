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
}

class UserDataCenter {
    static let shared = UserDataCenter()
    
    var accessToken: String?
    
    private init() { }
    
    //MARK: - Functions
    func setAccessToken(token: String){
        self.accessToken = token
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
            let font = GlobalFont(isSystemFont: true, isGoyangFont: false)
            let propertyEncoder = try? PropertyListEncoder().encode(font)
            UserDefaults.standard.set(propertyEncoder, forKey: UserDefaultsKeys.globalFont.rawValue)
            UserDefaults.standard.synchronize()
            break
        case .goyangFont:
            let font = GlobalFont(isSystemFont: false, isGoyangFont: true)
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
            if font.isSystemFont { // 시스템 폰트 설정
                return GlobalFontType.systemFont
            } else if font.isGoyangFont { // 고양 폰트 설정
                return GlobalFontType.goyangFont
            }else { // 아무 설정도 되지 않은 초기상태라면
                return GlobalFontType.systemFont
            }
        }
        
        return GlobalFontType.systemFont
    }
}

struct GlobalFont: Codable {
    var isSystemFont: Bool
    var isGoyangFont: Bool
    
    init(isSystemFont: Bool, isGoyangFont: Bool){
        self.isSystemFont = isSystemFont
        self.isGoyangFont = isGoyangFont
    }
}
