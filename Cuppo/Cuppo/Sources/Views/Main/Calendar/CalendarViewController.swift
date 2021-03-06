//
//  CalendarViewController.swift
//  Cuppo
//
//  Created by 이하연 on 2022/03/08.
//

import UIKit

class CalendarViewController: UIViewController {
    
    // MARK: - Properties
    let viewModel = CalendarViewModel()
    
    // MARK: - UIComponents
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBAction func changeDateAction(_ sender: Any) {
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
        setCollectionView()
        setBind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setLabel()
        setupData()
        setMonthView()
    }
    
    // MARK: - Functions
    func setUI(){
        yearLabel.text = viewModel.getYear()
        monthLabel.text = viewModel.getMonth()
    }
    
    func setLabel(){
        yearLabel.font = .globalFont(size: 16)
        monthLabel.font = .globalFont(size: 22)
    }
    
    /* API 관련 */
    private func setupData() {
        viewModel.requestCardListAPI()
    }
    
    /* 콜렉션뷰 셋팅 */
    func setCollectionView(){
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    // 해당 달의 일수 설정
    func setMonthView(){
        viewModel.deleteCellArea()
        viewModel.setDayInCellArea()
    }
    
    /* 바인딩하는 부분 */
    func setBind() {
        viewModel.selectedDate.bind { date in
            self.yearLabel.text = self.viewModel.getYear()
            self.monthLabel.text = self.viewModel.getMonth()
            self.collectionView.reloadData()
        }
        
        viewModel.cardList.bind { _ in
            self.showIndicator()
            self.collectionView.reloadData()
            self.dismissIndicator()
        }
        
        viewModel.cardPK.bind { data in
            if data != "" {
                self.moveToShowVC(cardId: data)
            }
        }
    }
    
    /* 화면전환 */    
    func moveToAddVC(){
        let storyboard = UIStoryboard(name: "Coffee", bundle: nil)
        guard let CoffeeVC = storyboard.instantiateViewController(identifier: "CoffeeSB") as? CoffeeViewController else { return }
        CoffeeVC.viewModel.selectedDate.value = viewModel.getFullDateString()
        
        let NaviVC = UINavigationController(rootViewController: CoffeeVC)
        NaviVC.modalPresentationStyle = .fullScreen
        self.present(NaviVC, animated: true, completion: nil)
        
    }
    
    func moveToShowVC(cardId: String){
        let storyboard = UIStoryboard(name: "Coffee", bundle: nil)
        guard let CardVC = storyboard.instantiateViewController(identifier: "CardSB") as? CardViewController else { return }
        CardVC.viewModel.cardPK = cardId
        let NaviVC = UINavigationController(rootViewController: CardVC)
        NaviVC.modalPresentationStyle = .fullScreen
        self.present(NaviVC, animated: true, completion: nil)
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
