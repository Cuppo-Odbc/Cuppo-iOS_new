//
//  CoffeeViewController + CollectionView.swift
//  Cuppo
//
//  Created by 이하연 on 2022/04/05.
//

import UIKit

extension CoffeeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.currentArrCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ingredientCell", for: indexPath) as? IngredientCell else {
            return UICollectionViewCell()
        }
        let target = viewModel.getData(idx: indexPath.item)
        urlToImg(urlStr: target.image, img: cell.ingredientImageView)
        
//        if target.key == "whipped_cream" {
//            cell.cellView.backgroundColor = UIColor(named: "cuppoColor13")
//            cell.ingredientImageView.alpha = 0.2
//            cell.isUserInteractionEnabled = false
//        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let target = viewModel.getData(idx: indexPath.item)
        viewModel.setCurrentArr(ingredient: target.key)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.size.width - 30 ) / 3
        return CGSize(width: width, height: width)
    }
    
}
