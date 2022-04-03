//
//  CalendarViewModel.swift
//  Cuppo
//
//  Created by 이하연 on 2022/04/01.
//

import Foundation

class CalendarViewModel {
    
    var selectedDate: Observable2<Date> = Observable2(value: Date())
    var cellArea: Observable2<[DayModel]> = Observable2(value:[DayModel]())
    var searchedList: Observable2<[String]> = Observable2(value: [String]())
    
    func requestAPI(){
        //TODO: API 호출해서 응답값 받고, 그걸 우리가쓸 모델형태로 변경 후 그걸 searchedList에 넣어주자.
        let responseData = ["31","1","2"] // 임시
        
        searchedList.value.append(contentsOf: responseData)
    }
    
    var cellAreaCount: Int {
        cellArea.value.count
    }
    
    /* 선택 셀 정보 (날짜) */
    func getCellDate(idx: Int)-> DayModel {
        self.cellArea.value[idx]
    }
    
    /* 선택된 날짜로 교체 */
    func setSelectedDate(selectedDate: Date){
        self.selectedDate.value = selectedDate
    }
    
    /* 선택된 날짜 가져오기 */
    func getSelectedDate() -> Date {
        self.selectedDate.value
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
    
    /* 셀 공간 리셋하기 */
    func deleteCellArea(){
        cellArea.value.removeAll()
    }
    
    /* 해당 월에 날짜 넣기 */
    func appendCellDate(day: String) {
        cellArea.value.append(DayModel(dayName: day))
    }
    
    /* 날짜 변경하기 */
    func changeSelectedDate(year: String, month: String) {
        selectedDate.value = CalendarHelper().changeDate(year, month)
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
    
    
}
