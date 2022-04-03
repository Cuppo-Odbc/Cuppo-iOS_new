//
//  CalendarViewController.swift
//  Cuppo
//
//  Created by 이하연 on 2022/03/08.
//

import UIKit

class CalendarViewController: BaseController {
    // MARK: - Properties
    let viewModel = CalendarViewModel()
    
    // MARK: - UIComponents
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBAction func changeDateAction(_ sender: Any) {
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
        setMonthView()
        setCollectionView()
    }
    
    // MARK: - Functions
    func setCollectionView(){
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    // 해당 달의 일수 설정
    func setMonthView(){
        viewModel.deleteCellArea()
        viewModel.setDayInCellArea()
    }
    
    private func setupData() {
        viewModel.requestCardListAPI()
    }
    
    func setBind() {
        viewModel.selectedDate.bind { date in
            self.yearLabel.text = self.viewModel.getYear()
            self.monthLabel.text = self.viewModel.getMonth()
            self.collectionView.reloadData()
        }
        
        viewModel.cardList.bind { _ in
            //TODO: 해당 날짜의 이미지뷰 hidden true / false
            self.collectionView.reloadData()
        }
    }
    
    func moveToVC(selectIdx: Int){
        let storyboard = UIStoryboard(name: "Coffee", bundle: nil)
        guard let CoffeeVC = storyboard.instantiateViewController(identifier: "CoffeeSB") as? CoffeeViewController else { return }
        CoffeeVC.id = selectIdx
        CoffeeVC.modalPresentationStyle = .fullScreen
        self.present(CoffeeVC, animated: true, completion: nil)
    }
    
}

extension CalendarViewController: CustomAlertProtocol {
    func cancleButtonTapped(_ popupView: UIView) {
        popupView.removeFromSuperview()
    }
    
    func okButtonTapped(_ popupView: UIView, _ year: String?, _ month: String?) {
        viewModel.changeSelectedDate(year: year!, month: month!)
        setMonthView()
        setupData()
        popupView.removeFromSuperview()
    }
}
