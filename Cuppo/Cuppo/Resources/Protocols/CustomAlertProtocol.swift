//
//  CustomAlertProtocol.swift
//  Cuppo
//
//  Created by 이하연 on 2022/03/29.
//

import UIKit

protocol CustomAlertProtocol {
    func cancleButtonTapped(_ popupView: UIView)
    func okButtonTapped(_ popupView: UIView, _ year: String?, _ month: String?)
}
