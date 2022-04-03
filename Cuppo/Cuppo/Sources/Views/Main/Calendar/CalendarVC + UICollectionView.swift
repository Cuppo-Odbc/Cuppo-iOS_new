//
//  CalendarVC + UICollectionView.swift
//  Cuppo
//
//  Created by 이하연 on 2022/03/30.
//

import UIKit

extension CalendarViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.cellAreaCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "calendarCell", for: indexPath) as? CalendarCell else {
            return UICollectionViewCell()
        }
        let target = viewModel.getCellData(idx: indexPath.item)
        
        cell.dayLabel.text = target.dayName
        cell.coffeeImage.isHidden = !target.isExist
        cell.dayLabel.textColor = target.isTouch ? .black : UIColor.cuppoGray
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let target = viewModel.getCellData(idx: indexPath.item)
        if target.isTouch {
            //TODO: - 만약 이미 카드가 존재한다면 등록안됨
            if !target.isExist {
                moveToVC(selectIdx: indexPath.row)
            }else {
                let popupView = AlertView(frame: view.bounds)
                popupView.okButton.isHidden = true
                popupView.popupAlert(firstBtnTitle: "확인", secondBtnTitle: nil, content: "이미 카드가 등록되었습니다.", myView: popupView)
                popupView.delegate = self
                view.addSubview(popupView)
            }
        } else {
            if target.dayName != "" {
                let popupView = AlertView(frame: view.bounds)
                popupView.okButton.isHidden = true
                popupView.popupAlert(firstBtnTitle: "확인", secondBtnTitle: nil, content: "카드 등록이 안되는 날짜입니다.", myView: popupView)
                popupView.delegate = self
                view.addSubview(popupView)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.size.width - 10) / 8
        let height = (collectionView.frame.size.height - 2) /  12
        return CGSize(width: width, height: height)
    }
}
