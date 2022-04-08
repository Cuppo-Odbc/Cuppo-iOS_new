//
//  DiaryViewModel.swift
//  Cuppo
//
//  Created by 이하연 on 2022/04/05.
//

import Foundation

class DiaryViewModel {
    let cardDataManger = CardService.shared
    
    var type: Observable2<DiaryType> = Observable2(value: .addCard)
    
    func getType() -> DiaryType {
        self.type.value
    }
    
    func setType(cardType: DiaryType) {
        type.value = cardType
    }
    
    
    // 커피 등록할 때
    var coffeeInfo: Observable2<CoffeeModel> = Observable2(value: CoffeeModel())
    
    // 등록 API
    func requestAddCardAPI(){
        let para: CardAddRequest = CardAddRequest(title: getNewCardTitle(), content: getNewCardContent(), coffee: getNewCardImageURL(), date: getNewCoffeeDate())
        print(para)
        cardDataManger.requestAddCard(para: para) { response in
            print("\(response)")
        }
    }
    
    
    func getCoffeeInfo() -> CoffeeModel {
        self.coffeeInfo.value
    }
    
    func setCoffeeInfo(newCoffeeInfo: CoffeeModel) {
        coffeeInfo.value = newCoffeeInfo
    }
    
    func getNewCoffeeDate() -> String {
        self.getCoffeeInfo().date.substring(from: 0, to: 9)
    }
    
    func getNewCardTitle() -> String {
        self.getCoffeeInfo().name
    }
    
    func getNewCardImageURL() -> String {
        self.getCoffeeInfo().imgUrl
    }
    
    func getNewCardContent() -> String {
        self.getCoffeeInfo().content
    }
    
    func setNewCardTitle(title: String) {
        self.coffeeInfo.value.name = title
    }
    
    func setNewCardContent(content: String) {
        self.coffeeInfo.value.content = content
    }
    
    func setNewCardCoffeeURL(url: String) {
        self.coffeeInfo.value.imgUrl = url
    }
    
    
    // 카드 수정할 때
    var cardInfo: Observable2<Card> = Observable2(value: Card())
    
    // 수정 API
    func requestModifyCardAPI(){
        let para: CardModifyRequest = CardModifyRequest(title: getCardTitle(), content: getCardContent(), coffee: getCardImageURL())
        cardDataManger.requestModifyCard(cardId: cardId, para: para) { response in
            self.cardInfo.value = response
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
        self.getCardInfo().date.substring(from: 0, to: 9)
    }
    
    func getCardTitle() -> String {
        self.getCardInfo().title
    }
    
    func getCardImageURL() -> String {
        self.getCardInfo().coffee
    }
    
    func getCardContent() -> String {
        self.getCardInfo().content
    }
    
    func setCardTitle(title: String) {
        self.cardInfo.value.title = title
    }
    
    func setCardContent(content: String) {
        self.cardInfo.value.content = content
    }
    
    func setCardCoffeeURL(url: String) {
        self.cardInfo.value.coffee = url
    }
    
    // 카드 정보 변경
    func setCardInfo(newCardInfo: Card) {
        self.cardInfo.value = newCardInfo
    }

    
}
