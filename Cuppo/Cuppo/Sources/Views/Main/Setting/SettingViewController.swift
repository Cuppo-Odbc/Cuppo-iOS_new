//
//  SettingViewController.swift
//  Cuppo
//
//  Created by 이하연 on 2022/03/08.
//

import UIKit
import SnapKit
import Then
import SwiftUI

class SettingViewController: BaseController {
    //MARK: - Properties
    let options: [String] = ["글자 스타일", "폰트", "인스타그램", "서비스 정보", "계정 관리"]
    
    //MARK: - UI Components
    lazy var optionTableView = UITableView().then{
        $0.delegate = self
        $0.dataSource = self
        $0.rowHeight = UITableView.automaticDimension
        $0.estimatedRowHeight = 44
        $0.separatorStyle = .none
        $0.register(SettingOptionCell.self, forCellReuseIdentifier: SettingOptionCell.identifier)
        $0.register(OptionHeaderView.self, forHeaderFooterViewReuseIdentifier: OptionHeaderView.identifier)
    }
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground
        
        setLayout()
    }
    
    //MARK: - Functions
    func setLayout(){
        self.view.addSubview(optionTableView)
        
        optionTableView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
}


extension SettingViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.options.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingOptionCell.identifier, for: indexPath) as? SettingOptionCell else {
            return UITableViewCell()
        }
        
        cell.configure(optionModel: options[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let testVC = SettingTwoViewController()
        self.navigationController?.pushViewController(testVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: OptionHeaderView.identifier) as? OptionHeaderView else {
            return UIView()
        }

        header.backgroundColor = .secondaryLabel
        
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1.0
    }
}

