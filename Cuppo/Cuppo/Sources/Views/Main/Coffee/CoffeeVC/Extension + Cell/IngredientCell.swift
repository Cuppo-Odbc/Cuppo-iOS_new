//
//  IngredientCell.swift
//  Cuppo
//
//  Created by 이하연 on 2022/04/05.
//

import UIKit

class IngredientCell: UICollectionViewCell {
    @IBOutlet weak var ingredientImageView: UIImageView!
    @IBOutlet weak var cellView: UIView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setLayer(cellView,1,"cuppoColor4")
    }
    
    override var isSelected: Bool {
        didSet {
            // 선택여부에 따라 테두리 색이 변경
            if isSelected {
                setLayer(cellView,2,"cuppoColor12")
            } else {
                setLayer(cellView,1,"cuppoColor4")
            }
        }
    }
    
    // 테두리 설정하는 부분
    func setLayer(_ view: UIView, _ layerWidth: Int, _ colorName: String) {
        view.layer.borderWidth = CGFloat(layerWidth)
        view.layer.borderColor = UIColor(named: colorName)?.cgColor
        view.layer.cornerRadius = 10
    }
    
    var isTouched: Bool? {
        didSet{
            if isTouched == false {
                
                cellView.backgroundColor = UIColor(named: "cuppoColor13")
                ingredientImageView.alpha = 0.2
                isUserInteractionEnabled = false
            }
            if isTouched == true {
                cellView.backgroundColor = UIColor(named: "cuppoColor11")
                ingredientImageView.alpha = 1
                isUserInteractionEnabled = true
            }
        }
    }
    
    var isSelecting: Bool? {
        didSet {
            if isSelecting == true && isTouched == true {
                setLayer(cellView,2,"cuppoColor12")
            }
            else if isSelecting == false {
                setLayer(cellView,1,"cuppoColor4")
            }
        }
    }
    
    
}
