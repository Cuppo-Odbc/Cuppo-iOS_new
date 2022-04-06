//
//  CoffeeViewModel.swift
//  Cuppo
//
//  Created by 이하연 on 2022/04/05.
//

import UIKit

class CoffeeViewModel {
    
    let combinationService = CombinationService.shared
    
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
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////
    
    /* 재료 API 불러와 대입 */
    func requestIngredients() {
        combinationService.requestIngredients { response in
            self.temperatureImgUrlArr.value = response.temperature
            self.milkImgUrlArr.value = response.milk
            self.syrupImgUrlArr.value = response.syrup
            self.whippingImgUrlArr.value = response.decoration
            self.setCurrentArr(newArr: self.temperatureImgUrlArr.value)
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
    
    /* 선택항목들 불러오기 */
    func getCurrentArr() -> [Ingredient] {
        self.currentArr.value
    }
    
    /* 선택항목들 중 재료 불러오기 */
    func getData(idx:Int) -> Ingredient {
        self.currentArr.value[idx]
    }
    
    /* 선택항목들 변경 */
    func setCurrentArr(newArr: [Ingredient]) {
        self.currentArr.value = newArr
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////
    
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
}

