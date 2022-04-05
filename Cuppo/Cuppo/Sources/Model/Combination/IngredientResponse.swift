//
//  IngredientResponse.swift
//  Cuppo
//
//  Created by 이하연 on 2022/04/05.
//

import Foundation

struct IngredientResponse: Decodable {
    let temperature: [Ingredient]
    let milk: [Ingredient]
    let syrup: [Ingredient]
    let decoration: [Ingredient]
}

struct Ingredient: Decodable {
    let description: String
    let key: String
    let image: String
}
