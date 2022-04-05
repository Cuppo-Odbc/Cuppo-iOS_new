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
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBAction func dismissButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func nextButtonTapped(_ sender: Any) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dismissKeyboardWhenTappedAround()
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
        
    }
    
    func setButton(){
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
    }
    
    // MARK: - objc Functions
    @objc func changeCurrentArr(_ sender: UIButton) {
        if sender.tag == 5 {
            viewModel.setData(newArr: viewModel.getTemperatureArr())
        }else if sender.tag == 2 {
            viewModel.setData(newArr: viewModel.getMilkArr())
        }else if sender.tag == 3 {
            viewModel.setData(newArr: viewModel.getSyrupArr())
        }else if sender.tag == 4{
            viewModel.setData(newArr: viewModel.getWhippingArr())
            
        }
    }
}

extension CoffeeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.currentArr.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ingredientCell", for: indexPath) as? IngredientCell else {
            return UICollectionViewCell()
        }
        let target = viewModel.getData(idx: indexPath.row)
        urlToImg(urlStr: target.image, img: cell.ingredientImageView)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.size.width - 30 ) / 3
        return CGSize(width: width, height: width)
    }
    
    
}

class IngredientCell: UICollectionViewCell {
    @IBOutlet weak var ingredientImageView: UIImageView!
    @IBOutlet weak var cellView: UIView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        cellView.layer.borderWidth = 1
        cellView.layer.borderColor = UIColor(named: "cuppoColor4")?.cgColor
        cellView.layer.cornerRadius = 10
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
