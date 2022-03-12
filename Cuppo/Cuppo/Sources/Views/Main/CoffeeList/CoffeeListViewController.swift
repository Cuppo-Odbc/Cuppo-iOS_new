//
//  CoffeeListViewController.swift
//  Cuppo
//
//  Created by 이하연 on 2022/03/08.
//

import UIKit

class CoffeeListViewController: BaseController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}

extension CoffeeListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "coffeeListCell", for: indexPath) as? CoffeeListCell else {
            return UITableViewCell()
        }
        return cell
    }

    // 디바이스가로- 60 : 세로 x : 315 : 200
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let width = UIScreen.main.bounds.size.width - 60
        let height = 200 * width / 315
        
        return height
    }
    
    
}

class CoffeeListCell: UITableViewCell {
    
    @IBOutlet weak var layerView: UIView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 15, left: 30, bottom: 0, right: 30))
    }
    
    override func awakeFromNib() {
        layerView.layer.borderColor = UIColor.black.cgColor
        layerView.layer.borderWidth = 1
    }
    
}

