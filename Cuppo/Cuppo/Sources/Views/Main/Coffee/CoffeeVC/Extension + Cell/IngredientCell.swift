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
            if isSelected {
                setLayer(cellView,2,"cuppoColor12")
                
            } else {
                setLayer(cellView,1,"cuppoColor4")
            }
        }
    }
    
    func setLayer(_ view: UIView, _ layerWidth: Int, _ colorName: String) {
        view.layer.borderWidth = CGFloat(layerWidth)
        view.layer.borderColor = UIColor(named: colorName)?.cgColor
        view.layer.cornerRadius = 10
    }
}
