//
//  CalendarViewModel.swift
//  Cuppo
//
//  Created by 이하연 on 2022/04/01.
//

import Foundation

class CalendarViewModel {
    let cardDataManger = CardService.shared
    
    var cardList: Observable2<[Card]> = Observable2(value: [Card]())
    var selectedDate: Observable2<Date> = Observable2(value: Date())
    var cellArea: Observable2<[DayModel]> = Observable2(value:[DayModel]())
    
    var fullDateString: Observable2<String> = Observable2(value: "")
    var cardPK: Observable2<String> = Observable2(value: "")
    
    func getFullDateString() -> String {
        self.fullDateString.value
    }
    
    func setFullDateString(day: String) {
        let getDay: String = day.count < 2 ? "0"+day : day

        self.fullDateString.value = "\(getYear())-\(getNumberMonth())-\(getDay)"
    }
    
    
    func requestCardListAPI(){
        //TODO: API 호출해서 응답값 받고, 그걸 우리가쓸 모델형태로 변경 후 그걸 cardList에 넣어주자.
        cardDataManger.requestCardList(year: Int(getYear())!, month: Int(getNumberMonth())!) { response in
            let newCardList = response.content
            self.cardList.value = newCardList
            self.setCardInDay()
        }
    }
    
    func requestDetailCardAPI(day: String){
        cardDataManger.requestSelectCard(year: Int(getYear())!, month: Int(getNumberMonth())!, day: Int(day)!) { response in
            self.cardPK.value = response.content[0].id
        }
    }
    
    
    // MARK: - selectedDate
    
    /* 선택된 날짜 가져오기 */
    func getSelectedDate() -> Date {
        self.selectedDate.value
    }
    
    /* 선택된 날짜로 교체 */
    func setSelectedDate(selectedDate: Date){
        self.selectedDate.value = selectedDate
    }
    
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
    
    
    // MARK: - cellArea
    
    /* 셀 갯수 */
    var cellAreaCount: Int {
        cellArea.value.count
    }

    /* 선택 셀 정보 (날짜) */
    func getCellData(idx: Int)-> DayModel {
        self.cellArea.value[idx]
    }
    
    /* 셀 공간 리셋하기 */
    func deleteCellArea(){
        cellArea.value.removeAll()
    }
    
    /* 해당 월에 날짜 넣기 */
    func appendCellDate(day: String) {
        let touch: Bool = day != "" ? compareNow(getDay: day) : false

        cellArea.value.append(DayModel(dayName: day, isExist: false, isTouch: touch))
    }
    
    /* 선택한 년,월에 해당하는 일 대입 */
    func setDayInCellArea(){
        var count: Int = 0

        let daysInMonth = CalendarHelper().daysInMonth(date: selectedDate.value)
        let firstDayOfMonth = CalendarHelper().firstOfMonth(date: selectedDate.value)
        let startingSpaces = CalendarHelper().weekDay(date: firstDayOfMonth)
        
        while count < 42 {
            let dayLocation = count - startingSpaces

            if(dayLocation < 0 || dayLocation >= daysInMonth){
                appendCellDate(day: "")
            } else {
                appendCellDate(day: String(dayLocation+1))
            }
            count += 1
        }
    }
    
    /* Cell에 카드가 존재하는지 확인 -> isExist 변경 */
    func setCardInDay(){
        cardList.value.forEach { card in
            let day = card.date.substring(from: 8, to: 9)
            
            // cellArea의 isExist를 true로 바꾸기
            if let idx = cellArea.value.firstIndex(where: { $0.dayName == String(Int(day)!) }) {
                cellArea.value[idx].isExist = true
            }
        }
    }
    
    // MARK: - 기타
    
    /* 현재 날짜와 비교하기 */
    func compareNow(getDay: String) -> Bool{
        let nowDate = CalendarHelper().changeDate2(getYear(), getMonth(), getDay)
        if Date().dateCompare(fromDate: nowDate) == "Future" { return false }
        return true
    }
    
}
