//
//  CombinationResponse.swift
//  Cuppo
//
//  Created by 이하연 on 2022/04/05.
//

struct CombinationResponse: Decodable {
    let content: [Combination]
}

struct Combination: Decodable {
    let name: String
    let name_ko: String
    let image: String
    let combination: IngredientInCombination
}

struct IngredientInCombination: Decodable {
    let temperature: String
    let milk: String
    let syrup: String
    let decoration: String
}
