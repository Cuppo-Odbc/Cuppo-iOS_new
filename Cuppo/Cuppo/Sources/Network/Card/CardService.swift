//
//  CalendarService.swift
//  Cuppo
//
//  Created by 이하연 on 2022/04/03.
//

import Alamofire

let HEADER: HTTPHeaders = [
    "accept":           "application/json",
    "Authorization":     "Bearer \(Constant.jwt)"
]

class CardService {
    
    static let shared = CardService()
    private init() {}
    
    // MARK: - 전체 카테고리 조회
    func requestCardList(year: Int, month: Int, completion: @escaping (CardListResponse)->(Void)){
        let URL = Constant.BasicURL + "/cards?year=\(year)&month=\(month)"
        
        AF.request(URL, method: .get ,headers: HEADER).validate().responseDecodable(of:CardListResponse.self) { response in
            switch response.result {
            case .success(let response) :
                completion(response)
            case .failure(let error) :
                print(" 네트워크 실패: ",error.localizedDescription)
            }
        }
    }
}

