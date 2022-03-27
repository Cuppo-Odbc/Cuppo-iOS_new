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
        
        let sceneDelegate = UIApplication.shared.connectedScenes.first!.delegate as! SceneDelegate
        sceneDelegate.window?.overrideUserInterfaceStyle = .dark
    }
        
    /// 라이트 모드 설정
    func setLightMode(){
        // 설정 저장
        UserDefaults.standard.set(false, forKey: "GlobalAppearanceMode")
        
        let sceneDelegate = UIApplication.shared.connectedScenes.first!.delegate as! SceneDelegate
        sceneDelegate.window?.overrideUserInterfaceStyle = .light

    }
}
