//
//  CardModifyResponse.swift
//  Cuppo
//
//  Created by 이하연 on 2022/04/04.
//

import Foundation

struct CardModifyResponse: Decodable {
    let id: String
    let title: String
    let content: String
    let coffee: String
    let created_at: String
    let date: String
}
