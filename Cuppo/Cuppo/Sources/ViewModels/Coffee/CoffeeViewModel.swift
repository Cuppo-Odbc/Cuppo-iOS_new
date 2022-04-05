//
//  CoffeeViewModel.swift
//  Cuppo
//
//  Created by 이하연 on 2022/04/05.
//

import UIKit

struct CombinationModel {
    let temperature : String
    let milk : String
    let syrup : String
    let decoration : String
    
    init(){
        temperature = ""
        milk = ""
        syrup = ""
        decoration = ""
    }
}

class CoffeeViewModel {
    
    let combinationService = CombinationService.shared
    
    var temperatureImgUrlArr: Observable2<[Ingredient]> = Observable2(value: [Ingredient]())
    var milkImgUrlArr: Observable2<[Ingredient]> = Observable2(value: [Ingredient]())
    var syrupImgUrlArr: Observable2<[Ingredient]> = Observable2(value: [Ingredient]())
    var whippingImgUrlArr: Observable2<[Ingredient]> = Observable2(value: [Ingredient]())
    var currentArr: Observable2<[Ingredient]> = Observable2(value: [Ingredient]())
    
    var combinationArr: Observable2<CombinationModel> = Observable2(value: CombinationModel())
    
    func requestIngredients() {
        combinationService.requestIngredients { response in
            self.temperatureImgUrlArr.value = response.temperature
            self.milkImgUrlArr.value = response.milk
            self.syrupImgUrlArr.value = response.syrup
            self.whippingImgUrlArr.value = response.decoration
            self.setData(newArr: self.temperatureImgUrlArr.value)
        }
    }
    
//    var temperatureArrCount: Int {
//        temperatureImgUrlArr.value.count
//    }
//
//    var milkArrCount: Int {
//        milkImgUrlArr.value.count
//    }
//
//    var syrupArrCount: Int {
//        syrupImgUrlArr.value.count
//    }
//
//    var whippingArrCount: Int {
//        whippingImgUrlArr.value.count
//    }
    
    func getTemperatureArr() -> [Ingredient] {
        self.temperatureImgUrlArr.value
    }
    
    func getMilkArr() -> [Ingredient] {
        self.milkImgUrlArr.value
    }
    
    func getSyrupArr() -> [Ingredient] {
        self.syrupImgUrlArr.value
    }
    
    func getWhippingArr() -> [Ingredient] {
        self.whippingImgUrlArr.value
    }
    
    func getData(idx:Int) -> Ingredient {
        self.currentArr.value[idx]
    }
    
    func setData(newArr: [Ingredient]) {
        print(newArr)
        self.currentArr.value = newArr
    }
    
}
