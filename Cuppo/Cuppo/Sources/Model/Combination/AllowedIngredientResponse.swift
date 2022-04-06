//
//  NoIngredientResponse.swift
//  Cuppo
//
//  Created by 이하연 on 2022/04/05.
//

import Foundation

struct AllowedIngredientResponse: Decodable {
    let content: [AllowedResult]
}

struct AllowedResult: Decodable {
    let combination: SelectCombination
    let allowed: AllowedIngredient
}


struct SelectCombination: Decodable {
    let temperature: String
    let milk: String
    let syrup: String
}

struct AllowedIngredient: Decodable {
    let decoration: [String]
}


