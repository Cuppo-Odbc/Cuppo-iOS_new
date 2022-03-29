//
//  AlertView + PickerView.swift
//  Cuppo
//
//  Created by 이하연 on 2022/03/29.
//

import UIKit

extension AlertView: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == yearPickerView {
            return yearArr.count
        } else if pickerView == monthPickerView {
            return monthArr.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        var pickerLabel: UILabel? = (view as? UILabel)
        if pickerLabel == nil {
            pickerLabel = UILabel()
            pickerLabel?.font = UIFont(name: "Goyang", size: 14)
            pickerLabel?.textAlignment = .center
        }
        
        if pickerView == yearPickerView {
            pickerLabel?.text = "\(yearArr[row])년"
        } else if pickerView == monthPickerView {
            pickerLabel?.text = "\(monthArr[row])월"
        }
        
        return pickerLabel!
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == yearPickerView {
            print(yearArr[row])
        } else if pickerView == monthPickerView {
            print(monthArr[row])
        }
    }
}
