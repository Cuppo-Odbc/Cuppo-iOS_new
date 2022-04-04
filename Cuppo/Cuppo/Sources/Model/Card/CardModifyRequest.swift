//
//  CardModifyRequest.swift
//  Cuppo
//
//  Created by 이하연 on 2022/04/04.
//

import Foundation

struct CardModifyRequest: Encodable {
    let title: String
    let content: String
    let coffee: String
}
