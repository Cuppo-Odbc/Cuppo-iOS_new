//
//  CalendarCell.swift
//  Cuppo
//
//  Created by 이하연 on 2022/03/30.
//

import UIKit

class CalendarCell: UICollectionViewCell {
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var coffeeImage: UIImageView!

    override func layoutSubviews() {
        dayLabel.font = .globalFont(size: 12)
    }
    
}
