//
//  CoffeeViewModel.swift
//  Cuppo
//
//  Created by 이하연 on 2022/04/05.
//

import UIKit

// 삭제
struct AllowTest {
    let combination: AllowCombination
    let allowed: AllowAllowed
}

struct AllowCombination {
    let temperature: String
    let milk: String
    let syrup: String
}

struct AllowAllowed {
    let decoration: [String]
}



// 삭제
struct CombinationTest {
    let name: String
    let image: String
    let combination: IngredientInCombinationTest
}
// 삭제
struct IngredientInCombinationTest {
    let temperature: String
    let milk: String
    let syrup: String
    let decoration: String
}


struct CombinationModel {
    var temperature : String
    var milk : String
    var syrup : String
    var decoration : String
    
    init(){
        temperature = "none"
        milk = "none"
        syrup = "none"
        decoration = "none"
    }
}

class CoffeeViewModel {
    
    var combinationTest: [CombinationTest] = [CombinationTest]() // 삭제
    var allowTest: [AllowTest] = [AllowTest]() // 삭제
    
    let combinationService = CombinationService.shared
    
    var currentElement: Observable2<String> = Observable2(value: "temperature")
    var currentArr: Observable2<[Ingredient]> = Observable2(value: [Ingredient]())
    
    var temperatureImgUrlArr: Observable2<[Ingredient]> = Observable2(value: [Ingredient]())
    var milkImgUrlArr: Observable2<[Ingredient]> = Observable2(value: [Ingredient]())
    var syrupImgUrlArr: Observable2<[Ingredient]> = Observable2(value: [Ingredient]())
    var whippingImgUrlArr: Observable2<[Ingredient]> = Observable2(value: [Ingredient]())
    
    var combinationArr: Observable2<CombinationModel> = Observable2(value: CombinationModel())
    
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
    
    /* 조합 API */ // 삭제
    func requestCombination(){
        combinationTest.append(CombinationTest(name: "hotame", image:  "https://storage.googleapis.com/cuppo-test.appspot.com/drinks/hotame.png", combination: IngredientInCombinationTest(temperature: "hot", milk: "none", syrup: "none", decoration: "none")))
        combinationTest.append(CombinationTest(name: "iceame", image:  "https://storage.googleapis.com/cuppo-test.appspot.com/drinks/iceame.png", combination: IngredientInCombinationTest(temperature: "ice", milk: "none", syrup: "none", decoration: "none")))
        
        combinationTest.append(CombinationTest(name: "iceame_ice", image:  "https://storage.googleapis.com/cuppo-test.appspot.com/drinks/iceame_ice.png", combination: IngredientInCombinationTest(temperature: "ice", milk: "none", syrup: "none", decoration: "ice")))
        combinationTest.append(CombinationTest(name: "hotlatte", image:  "https://storage.googleapis.com/cuppo-test.appspot.com/drinks/hotlatte.png", combination: IngredientInCombinationTest(temperature: "hot", milk: "milk", syrup: "none", decoration: "none")))
    }
    
    /* 불가능 조합 API  */ // 삭제
    func requestAllowed(){
        allowTest.append(AllowTest(combination: AllowCombination(temperature: "hot", milk: "none", syrup: "none"), allowed: AllowAllowed(decoration: ["none"])))
        allowTest.append(AllowTest(combination: AllowCombination(temperature: "ice", milk: "none", syrup: "none"), allowed: AllowAllowed(decoration: ["ice","none"])))
        allowTest.append(AllowTest(combination: AllowCombination(temperature: "hot", milk: "milk", syrup: "none"), allowed: AllowAllowed(decoration: ["none","whipped_cream"])))
        allowTest.append(AllowTest(combination: AllowCombination(temperature: "ice", milk: "milk", syrup: "none"), allowed: AllowAllowed(decoration: ["none","ice"])))
        allowTest.append(AllowTest(combination: AllowCombination(temperature: "hot", milk: "milk_foam", syrup: "none"), allowed: AllowAllowed(decoration: ["none","whipped_cream"])))
        allowTest.append(AllowTest(combination: AllowCombination(temperature: "ice", milk: "milk_foam", syrup: "none"), allowed: AllowAllowed(decoration: ["none","whipped_cream","ice"])))
        allowTest.append(AllowTest(combination: AllowCombination(temperature: "hot", milk: "none", syrup: "green_tee_powder"), allowed: AllowAllowed(decoration: ["none","whipped_cream"])))
        allowTest.append(AllowTest(combination: AllowCombination(temperature: "hot", milk: "milk", syrup: "green_tee_powder"), allowed: AllowAllowed(decoration: ["none","whipped_cream"])))
        allowTest.append(AllowTest(combination: AllowCombination(temperature: "hot", milk: "milk_foam", syrup: "green_tee_powder"), allowed: AllowAllowed(decoration: ["none","whipped_cream"])))
        allowTest.append(AllowTest(combination: AllowCombination(temperature: "ice", milk: "none", syrup: "green_tee_powder"), allowed: AllowAllowed(decoration: ["none","ice"])))
        allowTest.append(AllowTest(combination: AllowCombination(temperature: "ice", milk: "milk", syrup: "green_tee_powder"), allowed: AllowAllowed(decoration: ["none","ice"])))
        allowTest.append(AllowTest(combination: AllowCombination(temperature: "ice", milk: "milk_foam", syrup: "green_tee_powder"), allowed: AllowAllowed(decoration: ["none","ice"])))
        
        allowTest.append(AllowTest(combination: AllowCombination(temperature: "hot", milk: "none", syrup: "strawberry_powder"), allowed: AllowAllowed(decoration: ["none","whipped_cream"])))
        allowTest.append(AllowTest(combination: AllowCombination(temperature: "hot", milk: "milk", syrup: "strawberry_powder"), allowed: AllowAllowed(decoration: ["none","whipped_cream"])))
        allowTest.append(AllowTest(combination: AllowCombination(temperature: "hot", milk: "milk_foam", syrup: "strawberry_powder"), allowed: AllowAllowed(decoration: ["none","whipped_cream"])))
        allowTest.append(AllowTest(combination: AllowCombination(temperature: "ice", milk: "none", syrup: "strawberry_powder"), allowed: AllowAllowed(decoration: ["none","ice"])))
        allowTest.append(AllowTest(combination: AllowCombination(temperature: "ice", milk: "milk", syrup: "strawberry_powder"), allowed: AllowAllowed(decoration: ["none","ice"])))
        allowTest.append(AllowTest(combination: AllowCombination(temperature: "ice", milk: "milk_foam", syrup: "strawberry_powder"), allowed: AllowAllowed(decoration: ["none","ice"])))
        
        allowTest.append(AllowTest(combination: AllowCombination(temperature: "hot", milk: "none", syrup: "caramel_syrup"), allowed: AllowAllowed(decoration: ["none","whipped_cream"])))
        allowTest.append(AllowTest(combination: AllowCombination(temperature: "hot", milk: "milk", syrup: "caramel_syrup"), allowed: AllowAllowed(decoration: ["none","whipped_cream"])))
        allowTest.append(AllowTest(combination: AllowCombination(temperature: "hot", milk: "milk_foam", syrup: "caramel_syrup"), allowed: AllowAllowed(decoration: ["none","whipped_cream"])))
        allowTest.append(AllowTest(combination: AllowCombination(temperature: "ice", milk: "none", syrup: "caramel_syrup"), allowed: AllowAllowed(decoration: ["none","ice"])))
        allowTest.append(AllowTest(combination: AllowCombination(temperature: "ice", milk: "milk", syrup: "caramel_syrup"), allowed: AllowAllowed(decoration: ["none","ice"])))
        allowTest.append(AllowTest(combination: AllowCombination(temperature: "ice", milk: "milk_foam", syrup: "caramel_syrup"), allowed: AllowAllowed(decoration: ["none","ice"])))
        
        allowTest.append(AllowTest(combination: AllowCombination(temperature: "hot", milk: "none", syrup: "chocolate_syrup"), allowed: AllowAllowed(decoration: ["none","whipped_cream"])))
        allowTest.append(AllowTest(combination: AllowCombination(temperature: "hot", milk: "milk", syrup: "chocolate_syrup"), allowed: AllowAllowed(decoration: ["none","whipped_cream"])))
        allowTest.append(AllowTest(combination: AllowCombination(temperature: "hot", milk: "milk_foam", syrup: "chocolate_syrup"), allowed: AllowAllowed(decoration: ["none","whipped_cream"])))
        allowTest.append(AllowTest(combination: AllowCombination(temperature: "ice", milk: "none", syrup: "chocolate_syrup"), allowed: AllowAllowed(decoration: ["none","ice"])))
        allowTest.append(AllowTest(combination: AllowCombination(temperature: "ice", milk: "milk", syrup: "chocolate_syrup"), allowed: AllowAllowed(decoration: ["none","ice"])))
        allowTest.append(AllowTest(combination: AllowCombination(temperature: "ice", milk: "milk_foam", syrup: "chocolate_syrup"), allowed: AllowAllowed(decoration: ["none","ice"])))
        
        allowTest.append(AllowTest(combination: AllowCombination(temperature: "hot", milk: "none", syrup: "mocha_syrup"), allowed: AllowAllowed(decoration: ["none","whipped_cream"])))
        allowTest.append(AllowTest(combination: AllowCombination(temperature: "hot", milk: "milk", syrup: "mocha_syrup"), allowed: AllowAllowed(decoration: ["none","whipped_cream"])))
        allowTest.append(AllowTest(combination: AllowCombination(temperature: "hot", milk: "milk_foam", syrup: "mocha_syrup"), allowed: AllowAllowed(decoration: ["none","whipped_cream"])))
        allowTest.append(AllowTest(combination: AllowCombination(temperature: "ice", milk: "none", syrup: "mocha_syrup"), allowed: AllowAllowed(decoration: ["none","ice"])))
        allowTest.append(AllowTest(combination: AllowCombination(temperature: "ice", milk: "milk", syrup: "mocha_syrup"), allowed: AllowAllowed(decoration: ["none","ice"])))
        allowTest.append(AllowTest(combination: AllowCombination(temperature: "ice", milk: "milk_foam", syrup: "mocha_syrup"), allowed: AllowAllowed(decoration: ["none","ice"])))
        
    }
    
    
    // 삭제
    func getCombinationTest() -> [CombinationTest] {
        return self.combinationTest
    }
    
    // 삭제
    // 현재조합이 조합API 안에 있는지 -> 있다면 해당 url, 없다면 에스프레소 url
    func testImage() -> String {
        for i in combinationTest {
            if i.combination.temperature == getCombinationArr().temperature &&
                i.combination.milk == getCombinationArr().milk &&
                i.combination.syrup == getCombinationArr().syrup &&
                i.combination.decoration == getCombinationArr().decoration
            {
                return i.image
            }
            
        }
        return "https://storage.googleapis.com/cuppo-test.appspot.com/drinks/icecrm_ice.png"
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
    func getCombinationArr() -> CombinationModel {
        self.combinationArr.value
    }
    
    /* 현재 조합 수정 */
    func setCurrentArr(ingredient: String) {
        if getCurrentElement() == "temperature" {
            combinationArr.value.temperature = ingredient
        }else if getCurrentElement() == "milk" {
            combinationArr.value.milk = ingredient
        }else if getCurrentElement() == "syrup" {
            combinationArr.value.syrup = ingredient
        }else if getCurrentElement() == "decoration" {
            combinationArr.value.decoration = ingredient
        }
    }
}
