//
//  CoffeeListVC + TableView.swift
//  Cuppo
//
//  Created by 이하연 on 2022/04/04.
//

import UIKit

extension CoffeeListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cardListCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "coffeeListCell", for: indexPath) as? CoffeeListCell else {
            return UITableViewCell()
        }
        let target = viewModel.getCardData(idx: indexPath.item)
        cell.titleLabel.text = target.title
        urlToImg(urlStr: target.coffee, img: cell.coffeeImage)
        cell.dateLabel.text = target.date.substring(from: 0, to: 9)
        return cell
    }

    // 디바이스가로- 60 : 세로 x : 315 : 200
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let width = UIScreen.main.bounds.size.width - 60
        let height = 200 * width / 315
        return height
    }
}
