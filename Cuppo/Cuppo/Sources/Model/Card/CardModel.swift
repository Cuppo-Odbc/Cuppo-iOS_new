//
//  CardModel.swift
//  Cuppo
//
//  Created by 이하연 on 2022/04/08.
//

import Foundation

struct CoffeeModel {
    var date: String
    var name: String
    var imgUrl: String
    var content: String

    init(date: String = "", name: String = "", imgUrl: String = "", content: String = ""){
        self.date = date
        self.name = name
        self.imgUrl = imgUrl
        self.content = content
    }
}
