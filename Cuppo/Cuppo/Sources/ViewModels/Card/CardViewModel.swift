//
//  CardViewModel.swift
//  Cuppo
//
//  Created by 이하연 on 2022/04/04.
//

import Foundation

class CardViewModel {
    let cardDataManger = CardService.shared
    
    var cardInfo: Observable2<Card> = Observable2(value: Card())
    
    // 카드 고유의 아이디 PK
    var cardId: String {
        return cardInfo.value.id
    }
    
    // 카드 정보 불러오기
    func getCardInfo() -> Card {
        self.cardInfo.value
    }
    
    func getCardDate() -> String {
        self.getCardInfo().date.substring(from: 0, to: 9)
    }
    
    // 카드 정보 변경
    func setCardInfo(newCardInfo: Card) {
        self.cardInfo.value = newCardInfo
    }
    
    // 삭제
    func deleteCard(){
        cardDataManger.requestDeleteCard(cardId: cardId) { response in
            print(response)
        }
        // API
    }
    
}
