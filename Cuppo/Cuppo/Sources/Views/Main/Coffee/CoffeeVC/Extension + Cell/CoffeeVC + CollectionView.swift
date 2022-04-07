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
        
        let target = viewModel.getData(idx: indexPath.row)
        urlToImg(urlStr: target.image, img: cell.ingredientImageView)
        
        // 현재 항목에 대해서 해당 재료들이 선택가능한지, 불가능한지 판단하는 부분 
        if viewModel.getCurrentElement() == "decoration" {
            cell.isTouched = viewModel.allowStatusArr.value[3][indexPath.row]
            cell.isSelecting = viewModel.selectStatusArr.value[3][indexPath.row]
            
        } else if viewModel.getCurrentElement() == "temperature" {
            cell.isTouched = viewModel.allowStatusArr.value[0][indexPath.row]
            cell.isSelecting = viewModel.selectStatusArr.value[0][indexPath.row]
            
        } else if viewModel.getCurrentElement() == "milk" {
            cell.isTouched = viewModel.allowStatusArr.value[1][indexPath.row]
            cell.isSelecting = viewModel.selectStatusArr.value[1][indexPath.row]
           
        } else if viewModel.getCurrentElement() == "syrup" {
            
            cell.isTouched = viewModel.allowStatusArr.value[2][indexPath.row]
            cell.isSelecting = viewModel.selectStatusArr.value[2][indexPath.row]
        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let target = viewModel.getData(idx: indexPath.item)
        viewModel.setSelectedCombinationArr(ingredient: target.key)
        self.viewModel.setSelectStatusArr(selectidx: indexPath.row)
        if viewModel.getCurrentElement() == "temperature" && indexPath.item == 0 {
            self.viewModel.changeNoneStauts()
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.size.width - 30 ) / 3
        return CGSize(width: width, height: width)
    }
    
}
