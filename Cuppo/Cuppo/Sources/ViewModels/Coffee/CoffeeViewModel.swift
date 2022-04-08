//
//  CoffeeViewModel.swift
//  Cuppo
//
//  Created by 이하연 on 2022/04/05.
//

import UIKit

class CoffeeViewModel {
    
    let combinationService = CombinationService.shared
    
    var selectedDate: Observable2<String> = Observable2(value: String())
    
    // 서버에서 불러온 정보
    var temperatureImgUrlArr: Observable2<[Ingredient]> = Observable2(value: [Ingredient]())
    var milkImgUrlArr: Observable2<[Ingredient]> = Observable2(value: [Ingredient]())
    var syrupImgUrlArr: Observable2<[Ingredient]> = Observable2(value: [Ingredient]())
    var whippingImgUrlArr: Observable2<[Ingredient]> = Observable2(value: [Ingredient]())
    var allCombinationArr: Observable2<[Combination]> = Observable2(value: [Combination]())
    var allAllowResultArr: Observable2<[AllowedResult]> = Observable2(value: [AllowedResult]())
    
    var currentElement: Observable2<String> = Observable2(value: "temperature") // 현재 항목
    var currentArr: Observable2<[Ingredient]> = Observable2(value: [Ingredient]()) // 현재 항목에 따른 재료들
    var selectResultCombinationArr: Observable2<CombinationModel> = Observable2(value: CombinationModel()) // 현재 선택한 조합 결과
    
    
    // =============================================
    // 이 두 부분은 업데이트가 있을때마다 손수 변경해줘야한다...
    var selectStatusArr: Observable2<[[Bool]]> = Observable2(value: [[Bool]]())
    var allowStatusArr: Observable2<[[Bool]]> = Observable2(value: [[Bool]]())
    // =============================================
    
    
    /* 재료 API 불러와 대입 */
    func requestIngredients() {
        combinationService.requestIngredients { response in
            self.temperatureImgUrlArr.value = response.temperature
            self.milkImgUrlArr.value = response.milk
            self.syrupImgUrlArr.value = response.syrup
            self.whippingImgUrlArr.value = response.decoration
            self.setCurrentArr(newArr: self.temperatureImgUrlArr.value)
            
            self.initStatus(response)
        }
    }
    
    /* 조합 API */
    func requestCombination(){
        combinationService.requestCombination { response in
            self.allCombinationArr.value = response.content
        }
    }
    
    // 선택 결과 조합 이미지
    func getResultCoffeeImgUrl() -> String {
        for result in allCombinationArr.value {
            if result.combination.temperature == getSelectedCombinationArr().temperature &&
                result.combination.milk == getSelectedCombinationArr().milk &&
                result.combination.syrup == getSelectedCombinationArr().syrup &&
                result.combination.decoration == getSelectedCombinationArr().decoration
            {
                return result.image
            }
        }
        // TODO: - 선택 결과 이미지 url 없는 경우 이미지 넣을거 찾기 ( 현재는 에스프레소 넣음 )
        return "https://storage.googleapis.com/cuppo-test.appspot.com/drinks/hotesp.png"
    }
    
    // 선택 결과 조합 커피 이름
    func getResultCoffeeName() -> String {
        for result in allCombinationArr.value {
            if result.combination.temperature == getSelectedCombinationArr().temperature &&
                result.combination.milk == getSelectedCombinationArr().milk &&
                result.combination.syrup == getSelectedCombinationArr().syrup &&
                result.combination.decoration == getSelectedCombinationArr().decoration
            {
                return result.name_ko
            }
        }
        // TODO: - 선택 결과 조합 없는 경우
        return "해당커피없음"
    }
    
    
    /* 불가능 조합 API  */
    func requestAllowed(){
        combinationService.requestAllowedIngredients { response in
            self.allAllowResultArr.value = response.content
        }
    }
    
    // 가능한 장식 재료들
    func getAllowIngredientArr() -> [String] {
        for resultCase in allAllowResultArr.value {
            if resultCase.combination.temperature == getSelectedCombinationArr().temperature &&
                resultCase.combination.milk == getSelectedCombinationArr().milk &&
                resultCase.combination.syrup == getSelectedCombinationArr().syrup  {
                return resultCase.allowed.decoration
            }
        }
        return []
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////
    
    /* 현재 선택된 항목 ( 온도, 우유, 시럽, 장식 ) */
    func getCurrentElement() -> String {
        self.currentElement.value
    }
    
    /* 항목 변경 후 적용*/
    func setCurrentElement(_ location: String) {
        self.currentElement.value = location
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////
    
    /* 선택항목에 해당하는 재료들 갯수 */
    var currentArrCount: Int {
        currentArr.value.count
    }
    
    /* 선택항목들 중 재료 불러오기 */
    func getData(idx:Int) -> Ingredient {
        self.currentArr.value[idx]
    }
    
    /* 선택항목들 변경 */
    func setCurrentArr(newArr: [Ingredient]) {
        self.currentArr.value = newArr
    }

    
    /* 온도 항목들 불러오기 */
    func getTemperatureArr() -> [Ingredient] {
        self.temperatureImgUrlArr.value
    }
    
    /* 우유 항목들 불러오기 */
    func getMilkArr() -> [Ingredient] {
        self.milkImgUrlArr.value
    }
    
    /* 시럽 항목들 불러오기 */
    func getSyrupArr() -> [Ingredient] {
        self.syrupImgUrlArr.value
    }
    
    /* 장식 항목들 불러오기 */
    func getWhippingArr() -> [Ingredient] {
        self.whippingImgUrlArr.value
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////
    
    
    /* 선택 조합 불러오기 */
    func getSelectedCombinationArr() -> CombinationModel {
        self.selectResultCombinationArr.value
    }
    
    /* 현재 조합 수정 */
    func setSelectedCombinationArr(ingredient: String) {
        if getCurrentElement() == "temperature" {
            selectResultCombinationArr.value.temperature = ingredient
        }else if getCurrentElement() == "milk" {
            selectResultCombinationArr.value.milk = ingredient
        }else if getCurrentElement() == "syrup" {
            selectResultCombinationArr.value.syrup = ingredient
        }else if getCurrentElement() == "decoration" {
            selectResultCombinationArr.value.decoration = ingredient
        }
    }
    
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////
    
    
    func initStatus(_ response: IngredientResponse){
        // 현재 선택된 재료 초기화
        selectStatusArr.value.append(Array(repeating: false, count: response.temperature.count))
        selectStatusArr.value.append(Array(repeating: false, count: response.milk.count))
        selectStatusArr.value.append(Array(repeating: false, count: response.syrup.count))
        selectStatusArr.value.append(Array(repeating: false, count: response.decoration.count))
        
        for i in 0..<selectStatusArr.value.count {
            selectStatusArr.value[i][0] = true
        }
        
        /// 재료 선택 가능 여부 배열 -  초기화
        allowStatusArr.value.append(Array(repeating: true, count: response.temperature.count))
        allowStatusArr.value.append(Array(repeating: false, count: response.milk.count))
        allowStatusArr.value.append(Array(repeating: false, count: response.syrup.count))
        allowStatusArr.value.append(Array(repeating: false, count: response.decoration.count))
        
        for i in 1..<allowStatusArr.value.count {
            allowStatusArr.value[i][0] = true
        }
    }
    
    // 현재 항목에서 선택한 재료 표시 상태 변경
    func setSelectStatusArr(selectidx: Int){
        var itemIdx: Int = 0
        
        if getCurrentElement() == "temperature" {
            itemIdx = 0
        }
        else if getCurrentElement() == "milk" {
            itemIdx = 1
        }
        
        else if getCurrentElement() == "syrup" {
            itemIdx = 2
        }
        else if getCurrentElement() == "decoration" {
            itemIdx = 3
        }else {
            print("예외상황 CoffeeVM - setSelectStatusArr ")
        }
        
        for i in 0 ..< selectStatusArr.value[itemIdx].count {
            selectStatusArr.value[itemIdx][i] = selectidx == i ? true : false
        }
    }
    
    // 모든 선택여부 상태 배열 불러오기
    func getSelectStatusArr() -> [[Bool]] {
        self.selectStatusArr.value
    }
    
    func getAllowStatusArr() -> [[Bool]] {
        self.allowStatusArr.value
    }
    
    // 가능한 장식 상태 변경
    func setAllowStatusArr(){

        if getCurrentElement() != "decoration" {
            print("가능한 장식->\( getAllowIngredientArr())")
            if getAllowIngredientArr().contains("none") {
                allowStatusArr.value[3][0] = true
            }
            if getAllowIngredientArr().contains("ice")  {
                allowStatusArr.value[3][1] = true
            }
            
            if getAllowIngredientArr().contains("whipped_cream") {
                allowStatusArr.value[3][2] = true
            }
            
            if !getAllowIngredientArr().contains("none") {
                allowStatusArr.value[3][0] = false
            }
            
            if !getAllowIngredientArr().contains("ice")  {
                allowStatusArr.value[3][1] = false
            }
            
            if !getAllowIngredientArr().contains("whipped_cream") {
                allowStatusArr.value[3][2] = false
            }
        }
    }
    
    // 온도 미선택 여부에 따라 나머지 우유 시럽 장식 선택가능여부 판단
    func changeAllowStatusArr(){
        if allowStatusArr.value.count != 0 {
            if selectStatusArr.value[0][0] == true {
                for i in 1..<allowStatusArr.value.count {
                    for j in 1..<allowStatusArr.value[i].count {
                        allowStatusArr.value[i][j] = false
                    }
                }
            }
            if selectStatusArr.value[0][0] == false {
                for i in 1..<allowStatusArr.value.count-1 {
                    for j in 1..<allowStatusArr.value[i].count {
                        allowStatusArr.value[i][j] = true
                    }
                }
            }
        }
    }
    
    // 선택하기와 선택못함이 동시에 true 인경우 미선택으로 상태 변경
    func changeNoneStauts(){
        for itemIdx in 1..<allowStatusArr.value.count {
            for i in 0..<allowStatusArr.value[itemIdx].count {
                if allowStatusArr.value[itemIdx][i] == false && selectStatusArr.value[itemIdx][i] == true {
                    selectStatusArr.value[itemIdx][0] = true
                    selectStatusArr.value[itemIdx][i] = false
                    
                    if itemIdx == 1 {
                        selectResultCombinationArr.value.milk = "none"
                    }else if  itemIdx == 2 {
                        selectResultCombinationArr.value.syrup = "none"
                    }else if itemIdx == 3  {
                        selectResultCombinationArr.value.decoration = "none"
                    }
                    
                }
            }
        }
    }
    
    func noCase(){
        
        // 만약 얼음 -> 핫을 선택했을 경우
        if selectStatusArr.value[3][1] == true {
            selectStatusArr.value[3][1] = false
        }
        // 만약 휘핑크림 -> 아이스를 선택했을 경우
        if selectStatusArr.value[3][2] == true {
            selectStatusArr.value[3][2] = false
        }
        
        // 팝업창 표시 후 -> 휘핑을 미기입상태로 변경
        selectStatusArr.value[3][0] = true
        selectResultCombinationArr.value.decoration = "none"
    }
    
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////
}

