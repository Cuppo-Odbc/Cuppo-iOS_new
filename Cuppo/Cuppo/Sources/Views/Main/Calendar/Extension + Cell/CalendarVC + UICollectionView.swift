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
        cell.dayLabel.textColor = target.isTouch ? UIColor(named: "cuppoColor1") : UIColor(named: "cuppoColor3")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let target = viewModel.getCellData(idx: indexPath.item)
        if target.isTouch {
            //TODO: - 만약 이미 카드가 존재한다면 등록안됨
            if !target.isExist {
                moveToVC(SBName: "Coffee", SBId: "CoffeeSB", VCName: "CoffeeVC")
            }else {
                //TODO: - 카드 수정 화면으로? 카드 조회하면으로? 
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.size.width - 10) / 8
        let height = (collectionView.frame.size.height - 2) /  12
        return CGSize(width: width, height: height)
    }
}
