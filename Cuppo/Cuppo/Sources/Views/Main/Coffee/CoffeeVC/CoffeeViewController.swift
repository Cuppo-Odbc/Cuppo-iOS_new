//
//  CoffeeViewController.swift
//  Cuppo
//
//  Created by 이하연 on 2022/03/08.
//

import UIKit

class CoffeeViewController: UIViewController {
    
    let viewModel = CoffeeViewModel()
    
    // MARK: - UIComponents
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var coffeeImageView: UIImageView!
    
    @IBOutlet weak var todayCoffeeLabel: UILabel!
    @IBOutlet weak var temperatureButton: UIButton!
    @IBOutlet weak var milkButton: UIButton!
    @IBOutlet weak var syrupButton: UIButton!
    @IBOutlet weak var whippingButton: UIButton!
    
    @IBOutlet weak var temperatureUnderLine: UIView!
    @IBOutlet weak var milkUnderLine: UIView!
    @IBOutlet weak var syrupUnderLine: UIView!
    @IBOutlet weak var whippingUnderLine: UIView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var leftBarButton: UIBarButtonItem!
    @IBOutlet weak var rightBarButton: UIBarButtonItem!
    
    
    @IBAction func dismissButtonTapped(_ sender: Any) {
        showPopupView()
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        moveToVC()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionView()
        setData()
        setButton()
        setBind()
        setFont()
        setBarButtonLocation(size: 10, barButton: leftBarButton,location: 1)
        setBarButtonLocation(size: -10, barButton: rightBarButton,location: 2)
    }
    
    func setBarButtonLocation(size: Double,barButton: UIBarButtonItem, location: Int){
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        spacer.width = size
        if location == 1 {
            navigationItem.setLeftBarButtonItems([spacer,barButton], animated: false)
        }else {
            navigationItem.setRightBarButtonItems([spacer,barButton], animated: false)
        }
        
    }
    
    func setFont(){
        todayCoffeeLabel.font = .globalFont(size: 16)
        titleLabel.font = .globalFont(size: 21)
        
        temperatureButton.titleLabel?.font = .globalFont(size: 17)
        milkButton.titleLabel?.font = .globalFont(size: 17)
        syrupButton.titleLabel?.font = .globalFont(size: 17)
        whippingButton.titleLabel?.font = .globalFont(size: 17)
        
    }
    
    func setCollectionView(){
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
    }
    
    func setData(){
        viewModel.requestIngredients()
        viewModel.requestCombination()
        viewModel.requestAllowed()
        
    }
    
    func setButton(){
        setButtonColor("cuppoColor1","cuppoColor3","cuppoColor3","cuppoColor3")
        setUnderLine(false,true,true,true)
        temperatureButton.addTarget(self, action: #selector(changeCurrentArr(_:)), for: .touchUpInside)
        milkButton.addTarget(self, action: #selector(changeCurrentArr(_:)), for: .touchUpInside)
        syrupButton.addTarget(self, action: #selector(changeCurrentArr(_:)), for: .touchUpInside)
        whippingButton.addTarget(self, action: #selector(changeCurrentArr(_:)), for: .touchUpInside)
    }
    
    func setBind(){
        viewModel.temperatureImgUrlArr.bind { data in
            self.collectionView.reloadData()
        }
        
        viewModel.milkImgUrlArr.bind { data in
            self.collectionView.reloadData()
        }
        
        viewModel.syrupImgUrlArr.bind { data in
            self.collectionView.reloadData()
        }
        
        viewModel.whippingImgUrlArr.bind { data in
            self.collectionView.reloadData()
        }
        
        viewModel.currentArr.bind { data in
            self.collectionView.reloadData()
        }
        
        // 재료 선택에 따라 커피 이미지가 변경되야됨.
        viewModel.selectResultCombinationArr.bind { data in
            if self.viewModel.getResultCoffeeName() == "해당커피없음" {
                self.viewModel.noCase()
            }
            
            self.titleLabel.text = "#" + self.viewModel.getResultCoffeeName()
            self.urlToImg(urlStr: self.viewModel.getResultCoffeeImgUrl(), img: self.coffeeImageView)
            self.viewModel.setAllowStatusArr()
            
            
        }
        viewModel.selectStatusArr.bind { data in
            self.viewModel.changeAllowStatusArr()
            self.collectionView.reloadData()
        }
        
        viewModel.allowStatusArr.bind { data in
            self.collectionView.reloadData()
        }
        
        
    }
    
    func setUnderLine(_ status1: Bool,_ status2: Bool,_ status3: Bool,_ status4: Bool){
        temperatureUnderLine.isHidden = status1
        milkUnderLine.isHidden = status2
        syrupUnderLine.isHidden = status3
        whippingUnderLine.isHidden = status4
    }
    
    func setButtonColor(_ status1: String,_ status2: String,_ status3: String,_ status4: String){
        temperatureButton.setTitleColor(UIColor(named: status1), for: .normal)
        milkButton.setTitleColor(UIColor(named: status2), for: .normal)
        syrupButton.setTitleColor(UIColor(named: status3), for: .normal)
        whippingButton.setTitleColor(UIColor(named: status4), for: .normal)
    }
    
    // MARK: - objc Functions
    @objc func changeCurrentArr(_ sender: UIButton) {
        if sender.tag == 1 {
            viewModel.setCurrentArr(newArr: viewModel.getTemperatureArr())
            viewModel.setCurrentElement("temperature")
            setUnderLine(false,true,true,true)
            setButtonColor("cuppoColor1","cuppoColor3","cuppoColor3","cuppoColor3")
        }else if sender.tag == 2 {
            viewModel.setCurrentArr(newArr: viewModel.getMilkArr())
            viewModel.setCurrentElement("milk")
            setUnderLine(true,false,true,true)
            setButtonColor("cuppoColor3","cuppoColor1","cuppoColor3","cuppoColor3")
        }else if sender.tag == 3 {
            viewModel.setCurrentArr(newArr: viewModel.getSyrupArr())
            viewModel.setCurrentElement("syrup")
            setUnderLine(true,true,false,true)
            setButtonColor("cuppoColor3","cuppoColor3","cuppoColor1","cuppoColor3")
        }else if sender.tag == 4{
            viewModel.setCurrentArr(newArr: viewModel.getWhippingArr())
            viewModel.setCurrentElement("decoration")
            setUnderLine(true,true,true,false)
            setButtonColor("cuppoColor3","cuppoColor3","cuppoColor3","cuppoColor1")
        }
    }
    
    /* 화면전환 */
    func moveToVC(){
        let storyboard = UIStoryboard(name: "Coffee", bundle: nil)
        guard let DiaryVC = storyboard.instantiateViewController(identifier: "DiarySB") as? DiaryViewController else { return }
        DiaryVC.modalPresentationStyle = .fullScreen
        DiaryVC.viewModel.setType(cardType: .addCard)
        DiaryVC.viewModel.setCoffeeInfo(newCoffeeInfo: CoffeeModel(date: viewModel.selectedDate.value, name: viewModel.getResultCoffeeName(), imgUrl: viewModel.getResultCoffeeImgUrl(), content: ""))
        self.navigationController?.pushViewController(DiaryVC, animated: true)
    }
    
    func showPopupView(){
        let popupView = AlertView(frame: view.bounds)
        popupView.popupAlert(firstBtnTitle: "아니요", secondBtnTitle: "예", content: "작성된 내용이 있습니다.\n기록을 취소하시겠습니까?", myView: popupView)
        popupView.delegate = self
        view.addSubview(popupView)
    }
}

extension CoffeeViewController: CustomAlertProtocol {
    func cancleButtonTapped(_ popupView: UIView) {
        popupView.removeFromSuperview()
    }
    
    func okButtonTapped(_ popupView: UIView, _ year: String?, _ month: String?) {
        self.dismiss(animated: true, completion: nil)
        popupView.removeFromSuperview()
    }
}


