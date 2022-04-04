//
//  CardViewController.swift
//  Cuppo
//
//  Created by 이하연 on 2022/04/04.
//

import UIKit
import SnapKit

extension CardViewController: DropDownProtocol {
    func editAction() {
        moveToVC()
        print("수정")
    }
    
    func shareAction() {
        print("공유")
    }
    
    func deleteAction() {
        print("삭제")
    }
}

class CardViewController: UIViewController {
    
    // MARK: - Properties
    let viewModel = CardViewModel()
    
    // MARK: - UIComponents
    let dropDownView = DropDownView(frame: .zero)
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var coffeeImageView: UIImageView!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var menuButton: UIButton!
    
    @IBAction func memuButtonTapped(_ sender: Any) {
        showDropDown()
    }
    
    @IBAction func dropDownDismiss(_ sender: Any) {
        dropDownView.removeFromSuperview()
    }
    
    @IBAction func closeButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    // MARK: - Functions
    func setupData(data: Card){
        viewModel.setCardInfo(newCardInfo: data)
    }
    
    func setUI(){
        dateLabel.text = viewModel.getCardDate()
        titleLabel.text = viewModel.getCardInfo().title
        urlToImg(urlStr: viewModel.getCardInfo().coffee, img: coffeeImageView)
        contentLabel.text = viewModel.getCardInfo().content
    }
    
    func showDropDown(){
        dropDownView.delegate = self
        view.addSubview(dropDownView)
        
        dropDownView.snp.makeConstraints {
            $0.top.equalTo(menuButton.snp.top)
            $0.trailing.equalTo(menuButton.snp.trailing)
            $0.width.equalTo(130)
            $0.height.equalTo(150)
        }
    }
    
    func moveToVC(){
        let storyboard = UIStoryboard(name: "Coffee", bundle: nil)
        guard let DiaryVC = storyboard.instantiateViewController(identifier: "DiarySB") as? DiaryViewController else {
            return
        }
        DiaryVC.modalPresentationStyle = .fullScreen
        DiaryVC.viewModel.setType(cardType: .editCard)
        DiaryVC.setData(data: viewModel.getCardInfo())
        present(DiaryVC, animated: true, completion: nil)
        
    }
    
}
