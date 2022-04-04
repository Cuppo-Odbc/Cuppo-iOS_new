//
//  CoffeeListViewController.swift
//  Cuppo
//
//  Created by 이하연 on 2022/03/08.
//

import UIKit

class CoffeeListViewController: BaseController {
    
    // MARK: - Properties
    let viewModel = CardViewModel()

    // MARK: - UIComponents
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    
    @IBAction func changeDateTapped(_ sender: Any) {
        /* 날짜 변경하는 팝업창 */
        let popupView = AlertView(frame: view.bounds)
        popupView.calendarAlert(popupView)
        popupView.selectYear = viewModel.getYear()
        popupView.selectMonth = viewModel.getNumberMonth()
        popupView.delegate = self
        view.addSubview(popupView)
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    // MARK: - Functions
    func setUI(){
        yearLabel.text = viewModel.getYear()
        monthLabel.text = viewModel.getMonth()
        
        setupData()
        setTableView()
        setBind()
    }
    
    /* API 관련 */
    private func setupData() {
        viewModel.requestCardListAPI()
    }
    
    /* 테이블뷰 셋팅 */
    func setTableView(){
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    /* 바인딩하는 부분 */
    func setBind() {
        viewModel.selectedDate.bind { date in
            self.yearLabel.text = self.viewModel.getYear()
            self.monthLabel.text = self.viewModel.getMonth()
            self.tableView.reloadData()
        }
        
        viewModel.cardList.bind { _ in
            self.tableView.reloadData()
        }
    }
    
    /* 화면전환 */
    func moveToVC(selectIdx: Int){ }
    
}

extension CoffeeListViewController: CustomAlertProtocol {
    func cancleButtonTapped(_ popupView: UIView) {
        popupView.removeFromSuperview()
    }
    
    func okButtonTapped(_ popupView: UIView, _ year: String?, _ month: String?) {
        viewModel.changeSelectedDate(year: year!, month: month!)
        setupData()
        popupView.removeFromSuperview()
    }
}
