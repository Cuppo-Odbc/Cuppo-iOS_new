//
//  optionHeaderView.swift
//  Cuppo
//
//  Created by 이숭인 on 2022/03/23.
//

import UIKit
import SnapKit

class OptionHeaderView: UITableViewHeaderFooterView {
    static let identifier = "optionHeaderView"
    
    let colorView = UIView()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        print("이게 아닌듯??")
        
        colorView.backgroundColor = .secondaryLabel
        
        self.contentView.addSubview(colorView)
        
        colorView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    
}
