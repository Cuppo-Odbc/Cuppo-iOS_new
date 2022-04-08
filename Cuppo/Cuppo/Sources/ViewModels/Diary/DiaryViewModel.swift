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
    var addEndStatus: Observable2<Bool> = Observable2(value: false)
    
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
        let para: CardAddRequest = CardAddRequest(title: getNewCardTitle(), content: getNewCardContent(), coffee: getNewCardImageURL(), date: getAddNewCoffeeDate())
        cardDataManger.requestAddCard(para: para) { response in
            self.addEndStatus.value = true
        }
    }
    
    
    func getCoffeeInfo() -> CoffeeModel {
        self.coffeeInfo.value
    }
    
    func setCoffeeInfo(newCoffeeInfo: CoffeeModel) {
        coffeeInfo.value = newCoffeeInfo
    }
    
    func getAddNewCoffeeDate() -> String {
        self.coffeeInfo.value.date.substring(from: 0, to: 9)
    }
    
    func getNewCoffeeDate() -> String {
        self.getFormattedDate(dateString: self.getCoffeeInfo().date)
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
    var editEndStatus: Observable2<Bool> = Observable2(value: false)
    
    // 수정 API
    func requestModifyCardAPI(){
        let para: CardModifyRequest = CardModifyRequest(title: getCardTitle(), content: getCardContent(), coffee: getCardImageURL())
        cardDataManger.requestModifyCard(cardId: cardId, para: para) { response in
            self.cardInfo.value = response
            self.editEndStatus.value = true
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
