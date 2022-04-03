//
//  CoffeeListViewController.swift
//  Cuppo
//
//  Created by 이하연 on 2022/03/08.
//

import UIKit

class CoffeeListViewController: BaseController {
    
    // MARK: - Properties
    let viewModel = CalendarViewModel()

    // MARK: - UIComponents
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    
    @IBAction func changeDateTapped(_ sender: Any) {
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
        yearLabel.text = viewModel.getYear()
        monthLabel.text = viewModel.getMonth()
        setupData()
        setBind()
        setTableView()
    }
    
    // MARK: - Functions
    func setTableView(){
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupData() {
        viewModel.requestCardListAPI()
    }
    
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
    
    func moveToVC(selectIdx: Int){
//        let storyboard = UIStoryboard(name: "Coffee", bundle: nil)
//        guard let CoffeeVC = storyboard.instantiateViewController(identifier: "CoffeeSB") as? CoffeeViewController else { return }
//        CoffeeVC.id = selectIdx
//        CoffeeVC.modalPresentationStyle = .fullScreen
//        self.present(CoffeeVC, animated: true, completion: nil)
    }
    
}

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
