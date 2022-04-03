//
//  CalendarService.swift
//  Cuppo
//
//  Created by 이하연 on 2022/04/03.
//

import Alamofire

class CalendarService {
    
    static let shared = CalendarService()
    private init() {}
    
    // MARK: - 전체 카테고리 조회
    func requestCardList(completion: @escaping (CardListResponse)->(Void)){
        let URL = "http://cuppotest-env.eba-ag42sqsg.ap-northeast-2.elasticbeanstalk.com/cards?year=2022&month=3"
        let HTTP_HEADERS: HTTPHeaders = ["X-ACCESS-TOKEN":"Bearer eyJhbGciOiJSUzI1NiIsImtpZCI6IjQ2NDExN2FjMzk2YmM3MWM4YzU5ZmI1MTlmMDEzZTJiNWJiNmM2ZTEiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vY3VwcG8tdGVzdCIsImF1ZCI6ImN1cHBvLXRlc3QiLCJhdXRoX3RpbWUiOjE2NDg5OTczNjksInVzZXJfaWQiOiJ3c3lxWGtUOHdCUXZTRW50eVh0V0ZuSXlWMHAxIiwic3ViIjoid3N5cVhrVDh3QlF2U0VudHlYdFdGbkl5VjBwMSIsImlhdCI6MTY0ODk5NzM2OSwiZXhwIjoxNjQ5MDAwOTY5LCJlbWFpbCI6ImhheWVvbjJAZXhhbXBsZS5jb20iLCJlbWFpbF92ZXJpZmllZCI6ZmFsc2UsImZpcmViYXNlIjp7ImlkZW50aXRpZXMiOnsiZW1haWwiOlsiaGF5ZW9uMkBleGFtcGxlLmNvbSJdfSwic2lnbl9pbl9wcm92aWRlciI6InBhc3N3b3JkIn19.BuBFAV7JDRhYIiiUa7fTGNvN9I8lwZN3UFtoALMU3r_xGEug4J-EPW859aHJ3Tc2TMX4WD9xGzH9_FHI3KKDqJdKbizdF0joicAQe_w5O10p917LAkz3MsONzIzyYu8f3vRhUH6NjIn2z-4P05oIlZzSX6bSu1dCh4RxjXENbkVED-FoVegBsNKOt6Xh8W-cATMrbWF_1qsgAwzeeb-ninGIu6DfypMv-ok6IKgC8WhbdrHA1l4NXxUQ5Buk0Di1i3DJLqVbCdCU3ERaViSjhXD-eUIUUpqvYSbZNxc3cyXK1iVU--4Jcr_TFtIt3ODUGVyPrS-Zy5-hPUQYQvQmJg"]
        
        AF.request(URL, method: .get ,headers: HTTP_HEADERS ).validate().responseDecodable(of:CardListResponse.self) { response in
            switch response.result {
            case .success(let response) :
                completion(response)
            case .failure(let error) :
                print(" 네트워크 실패: ",error.localizedDescription)
            }
        }
    }
}

struct CardListResponse: Decodable {
    let content: [Card]
}

struct Card: Decodable {
    let date: String
    let title: String
    let coffee: String
    let created_at: String
    let id: String
    let content: String
    let owner: String
}
