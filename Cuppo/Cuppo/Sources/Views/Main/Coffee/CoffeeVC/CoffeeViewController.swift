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
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var coffeeImageView: UIImageView!
    
    @IBOutlet weak var temperatureButton: UIButton!
    @IBOutlet weak var milkButton: UIButton!
    @IBOutlet weak var syrupButton: UIButton!
    @IBOutlet weak var whippingButton: UIButton!
    
    @IBOutlet weak var temperatureUnderLine: UIView!
    @IBOutlet weak var milkUnderLine: UIView!
    @IBOutlet weak var syrupUnderLine: UIView!
    @IBOutlet weak var whippingUnderLine: UIView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBAction func dismissButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func nextButtonTapped(_ sender: Any) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        dismissKeyboardWhenTappedAround()
        setCollectionView()
        setData()
        setButton()
        setBind()
    }
    
    func setCollectionView(){
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
    }
    
    func setData(){
        viewModel.requestIngredients()
        viewModel.requestCombination()
//        print(viewModel.getCombinationTest())
        
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
        viewModel.combinationArr.bind { data in
            self.urlToImg(urlStr: self.viewModel.testImage(), img: self.coffeeImageView)
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
}
