//
//  UserDataCenter.swift
//  Cuppo
//
//  Created by 이숭인 on 2022/03/26.
//

import UIKit

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
    
    func getUserInterfaceStyle() -> Bool {
        return UserDefaults.standard.bool(forKey: "GlobalAppearanceMode")
    }
    
    func getGlobalFont() -> GlobalFontType {
        let dict = [GlobalFontType.systemFont.rawValue : false,
                    GlobalFontType.goyangFont.rawValue : false]
//        var fontModel = FontModel()
//        fontModel.initDict()
        
        UserDefaults.standard.set(dict, forKey: "dictTest")
        UserDefaults.standard.synchronize()
        
        guard let fontTypeToDict = UserDefaults.standard.dictionary(forKey: "dictTest") else { return GlobalFontType.systemFont }
        
        for (key, value) in fontTypeToDict {
            if value as! Bool{
                if key == GlobalFontType.goyangFont.rawValue {
                    return GlobalFontType.goyangFont
                }else {
                    return GlobalFontType.systemFont
                }
            }
        }
        
        return GlobalFontType.systemFont
    }
}

struct FontModel {
    var dict: [String: Any]
    
    init(){
        self.dict = ["":""]
    }
    
    mutating func initDict(){
        self.dict.updateValue(false, forKey: GlobalFontType.systemFont.rawValue)
        self.dict.updateValue(false, forKey: GlobalFontType.goyangFont.rawValue)
    }
}
