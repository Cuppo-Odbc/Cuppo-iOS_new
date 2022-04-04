//
//  CardViewController.swift
//  Cuppo
//
//  Created by 이하연 on 2022/04/04.
//

import UIKit

class CardViewController: UIViewController {
    
    // MARK: - Properties
    let viewModel = CardViewModel()
    
    // MARK: - UIComponents
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var coffeeImageView: UIImageView!
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBAction func memuButtonTapped(_ sender: Any) {
        // 수정
        
        // 공유
        
        // 삭제
    }
    
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        print(viewModel.getCardInfo())
        
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
    
}
