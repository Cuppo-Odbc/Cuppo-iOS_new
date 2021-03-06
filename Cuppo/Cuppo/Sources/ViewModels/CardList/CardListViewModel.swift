//
//  CardViewModel.swift
//  Cuppo
//
//  Created by 이하연 on 2022/04/04.
//

import Foundation

class CardListViewModel {
    let cardDataManger = CardService.shared
    
    var selectedDate: Observable2<Date> = Observable2(value: Date())
    var cardList: Observable2<[Card]> = Observable2(value: [Card]())
    var addStartStatus: Observable2<Bool> = Observable2(value: false)
    
    func requestCardListAPI(){
        //TODO: API 호출해서 응답값 받고, 그걸 우리가쓸 모델형태로 변경 후 그걸 cardList에 넣어주자.
        cardDataManger.requestCardList(year: Int(getYear())!, month: Int(getNumberMonth())!) { response in
            let newCardList = response.content
            self.cardList.value = newCardList
        }
    }
    
    // MARK: - selectedDate
    
    /* 선택된 년도 가져오기 */
    func getYear() -> String {
        CalendarHelper().yearString(date: selectedDate.value)
    }
    
    /* 선택된 월 영어로 가져오기 */
    func getMonth() -> String {
        CalendarHelper().monthString(date: selectedDate.value).uppercased()
    }
    
    /* 선택된 월 숫자로 가져오기 */
    func getNumberMonth() -> String {
        CalendarHelper().month2String(date: selectedDate.value)
    }
    
    /* 날짜 변경하기 */
    func changeSelectedDate(year: String, month: String) {
        selectedDate.value = CalendarHelper().changeDate(year, month)
    }
    
    // MARK: - cardList
    
    /* 카드 리스트의 개수 */
    var cardListCount: Int {
        cardList.value.count
    }
    
    /* 특정 카드의 정보 */
    func getCardData(idx: Int)-> Card {
        self.cardList.value[idx]
    }
    
    /* 특정 카드의 id */
    func getCardId(idx: Int) -> String {
        self.cardList.value[idx].id
    }
    
    func getCardDate(dateString: String) -> String {
        return getFormattedDate(dateString: dateString)
    }
    
    func getFormattedDate(dateString: String) -> String{
        let testDate = dateString.substring(from: 0, to: 9)
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "yyyy.MM.dd"
        let date: Date? = dateFormatterGet.date(from: testDate)
        return dateFormatterPrint.string(from: date!)
    }
}
