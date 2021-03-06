//
//  BlankCell.swift
//  Cuppo
//
//  Created by 이하연 on 2022/04/06.
//

import UIKit

class BlankCell: UITableViewCell {
    
    @IBOutlet weak var noCardMarkLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 15, left: 30, bottom: 0, right: 30))
        noCardMarkLabel.font = .globalFont(size: 16)
    }
    
}
