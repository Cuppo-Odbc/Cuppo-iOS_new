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
        cell.dayLabel.text = viewModel.getCellDate(idx: indexPath.item).dayName
        cell.coffeeImage.isHidden = true
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.size.width - 10) / 8
        let height = (collectionView.frame.size.height - 2) /  12
        return CGSize(width: width, height: height)
    }
}
