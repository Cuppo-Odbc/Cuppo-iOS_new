//
//  CombinationService.swift
//  Cuppo
//
//  Created by 이하연 on 2022/04/05.
//

import Alamofire

class CombinationService {
    static let shared = CombinationService()
    private init(){}
    
    // 커피 조합 조회
    func requestCombination(completion: @escaping (CombinationResponse) -> (Void)){
        let URL = Constant.BasicURL + "/coffee/combinations"
        
        AF.request(URL, method: .get).validate().responseDecodable(of: CombinationResponse.self) { response in
            switch response.result {
            case .success(let response) :
                completion(response)
            case .failure(let error) :
                print("조합 조회 네트워크 실패 : ",error.localizedDescription)
            }
        }
    }
    
    // 커피 재료 조회
    func requestIngredients(completion: @escaping (IngredientResponse) -> (Void)) {
        let URL = Constant.BasicURL + "/ingredients"
        
        AF.request(URL, method: .get).validate().responseDecodable(of: IngredientResponse.self) { response in
            switch response.result {
            case .success(let response) :
                completion(response)
            case .failure(let error) :
                print("재료 조회 네트워크 실패 : ",error.localizedDescription)
            }
        }
    }
    
    // 선택 불가능한 조합 조회
    func requestAllowedIngredients(completion: @escaping (NoIngredientResponse) -> (Void)) {
        let URL = Constant.BasicURL + "/coffee/combinations/allowed"
        
        AF.request(URL, method: .get).validate().responseDecodable(of: NoIngredientResponse.self) { response in
            switch response.result {
            case .success(let response) :
                completion(response)
            case .failure(let error) :
                print("불가능한 재료 조회 네트워크 실패 : ",error.localizedDescription)
            }
        }
    }
    
}
