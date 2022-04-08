//
//  CalendarService.swift
//  Cuppo
//
//  Created by 이하연 on 2022/04/03.
//

import Alamofire



class CardService {
    
    static let shared = CardService()
    private init() {}
    
    // MARK: - 전체 카드 조회
    func requestCardList(year: Int, month: Int ,completion: @escaping (CardListResponse)->(Void)){
        let URL = Constant.BasicURL + "/cards?year=\(year)&month=\(month)"
        let HEADER: HTTPHeaders = [
            "accept":           "application/json",
            "Authorization":     "Bearer \(Constant.jwt)"
        ]
        
        AF.request(URL, method: .get ,headers: HEADER).validate().responseDecodable(of:CardListResponse.self) { response in
            switch response.result {
            case .success(let response) :
                completion(response)
            case .failure(let error) :
                print(" 카드 조회 네트워크 실패: ",error.localizedDescription)
            }
        }
    }
    
    // MARK: - 특정 카드 조회
    func requestSelectCard(year: Int, month: Int, day: Int,completion: @escaping (CardListResponse)->(Void)){
        let URL = Constant.BasicURL + "/cards?year=\(year)&month=\(month)&day=\(day)"
        let HEADER: HTTPHeaders = [
            "accept":           "application/json",
            "Authorization":     "Bearer \(Constant.jwt)"
        ]
        
        AF.request(URL, method: .get ,headers: HEADER).validate().responseDecodable(of:CardListResponse.self) { response in
            switch response.result {
            case .success(let response) :
                completion(response)
            case .failure(let error) :
                print(" 특정 카드 조회 네트워크 실패: ",error.localizedDescription)
            }
        }
    }
    
    
    // MARK: - 특정 카드 조회2
    func requestSelectCard(cardId: String,completion: @escaping (Card)->(Void)){
        let URL = Constant.BasicURL + "/cards/\(cardId)"
        let HEADER: HTTPHeaders = [
            "accept":           "application/json",
            "Authorization":     "Bearer \(Constant.jwt)"
        ]
        
        AF.request(URL, method: .get ,headers: HEADER).validate().responseDecodable(of:Card.self) { response in
            switch response.result {
            case .success(let response) :
                completion(response)
            case .failure(let error) :
                print(" 특정 카드 조회2 네트워크 실패: ",error.localizedDescription)
            }
        }
    }
    
    
    // MARK: - 카드 삭제
    func requestDeleteCard(cardId:String, completion: @escaping (CardDeleteResponse)->(Void)){
        
        let URL = Constant.BasicURL + "/cards/\(cardId)"
        let HEADER: HTTPHeaders = [
            "accept":        "application/json",
            "Content-Type":  "application/json",
            "Authorization": "Bearer \(Constant.jwt)"
        ]
        
        AF.request(URL, method: .delete ,headers: HEADER ).validate().responseDecodable(of:CardDeleteResponse.self) { response in
            switch response.result {
            case .success(let response) :
                completion(response)
            case .failure(let error) :
                print(" 카드 삭제 네ㅡ워크 실패: ",error.localizedDescription)
            }
        }
    }
    
    // MARK: - 카드 수정
    func requestModifyCard(cardId:String, para: CardModifyRequest, completion: @escaping (Card)->(Void)){
        let URL = Constant.BasicURL + "/cards/\(cardId)"
        let HEADER: HTTPHeaders = [
            "accept":        "application/json",
            "Content-Type":  "application/json",
            "Authorization": "Bearer \(Constant.jwt)"
        ]
    
        AF.request(URL, method: .patch, parameters: para, encoder: JSONParameterEncoder(), headers: HEADER ).validate().responseDecodable(of:Card.self) { response in
            switch response.result {
            case .success(let response) :
                completion(response)
            case .failure(let error) :
                print(" 카드 수정 네ㅡ워크 실패: ",error.localizedDescription)
            }
        }
    }
    
    // MARK: - 카드 등록
    func requestAddCard(para: CardAddRequest, completion: @escaping (Card)->(Void)){
        let URL = Constant.BasicURL + "/cards"
        let HEADER: HTTPHeaders = [
            "accept":        "application/json",
            "Content-Type":  "application/json",
            "Authorization": "Bearer \(Constant.jwt)"
        ]
    
        AF.request(URL, method: .post, parameters: para, encoder: JSONParameterEncoder(), headers: HEADER ).validate().responseDecodable(of:Card.self) { response in
            switch response.result {
            case .success(let response) :
                completion(response)
            case .failure(let error) :
                print(" 카드 추가 네ㅡ워크 실패: ",error.localizedDescription)
            }
        }
    }
    
}
