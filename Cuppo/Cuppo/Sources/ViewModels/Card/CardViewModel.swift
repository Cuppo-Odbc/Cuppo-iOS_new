//
//  CardViewModel.swift
//  Cuppo
//
//  Created by 이하연 on 2022/04/04.
//

import Foundation

class CardViewModel {
    let cardDataManger = CardService.shared
    var cardPK: String = ""
    var cardInfo: Observable2<Card> = Observable2(value: Card())
    var responseEnd: Observable2<Bool> = Observable2(value: false)
    var addStartStatus: Observable2<Bool> = Observable2(value: false)
    
    func requestCardInfo(){
        cardDataManger.requestSelectCard(cardId: cardPK) { response in
            self.setCardInfo(newCardInfo: response)
        }
    }
    
    // 카드 고유의 아이디 PK
    var cardId: String {
        return cardInfo.value.id
    }
    
    // 카드 정보 불러오기
    func getCardInfo() -> Card {
        self.cardInfo.value
    }
    
    func getCardDate() -> String {
        self.getFormattedDate(dateString: self.getCardInfo().date)
    }
    
    func getFormattedDate(dateString: String) -> String{
        let testDate = dateString.substring(from: 0, to: 9)
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "yy.MM.dd"
        let date: Date? = dateFormatterGet.date(from: testDate)
        return dateFormatterPrint.string(from: date!)
    }
    
    // 카드 정보 변경
    func setCardInfo(newCardInfo: Card) {
        self.cardInfo.value = newCardInfo
    }
    
    // 삭제
    func deleteCard() {
        cardDataManger.requestDeleteCard(cardId: cardId) { response in
            print("잘 삭제되었다.")
            self.responseEnd.value = true
        }
    }
    
}
