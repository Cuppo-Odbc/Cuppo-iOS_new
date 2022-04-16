//
//  TabBarViewController.swift
//  Cuppo
//
//  Created by 이하연 on 2022/03/21.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        self.tabBar.backgroundImage = UIImage(named: "basicLightMode.jpeg")
    }
}
