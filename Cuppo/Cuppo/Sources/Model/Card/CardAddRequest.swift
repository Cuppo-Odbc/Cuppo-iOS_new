//
//  CardAddRequest.swift
//  Cuppo
//
//  Created by 이하연 on 2022/04/08.
//

import Foundation

struct CardAddRequest: Encodable {
    let title: String
    let content: String
    let coffee: String
    let date: String
}

