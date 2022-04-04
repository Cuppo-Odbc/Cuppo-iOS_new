//
//  CoffeeListCell.swift
//  Cuppo
//
//  Created by 이하연 on 2022/04/04.
//

import UIKit

class CoffeeListCell: UITableViewCell {
    
    @IBOutlet weak var layerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var coffeeImage: UIImageView!
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 15, left: 30, bottom: 0, right: 30))
    }
    
    override func awakeFromNib() {
        layerView.layer.borderColor = UIColor.black.cgColor
        layerView.layer.borderWidth = 1
    }
    
}
