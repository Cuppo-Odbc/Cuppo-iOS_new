//
//  DiaryViewController.swift
//  Cuppo
//
//  Created by 이하연 on 2022/03/11.
//

import UIKit

enum DiaryType: String {
    case editCard = "카드수정"
    case addCard = "카드등록"
}

class DiaryViewController: UIViewController {
    
    let viewModel = DiaryViewModel()
    let textViewPlaceHolder: String = "커피에 담긴 순간을 기록해보세요."
    
    // MARK: - UIComponents
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var coffeeImageView: UIImageView!
    @IBOutlet weak var contentTextView: UITextView!
    
    @IBOutlet weak var leftButton: UIBarButtonItem!
    @IBOutlet weak var rightButton: UIBarButtonItem!
    
    
    @IBAction func backButtonTapped(_ sender: Any) {
        backPopupView()
    }
    
    @IBAction func completionButton(_ sender: Any) {
        // TODO: - API
        guard let titleText = titleTextField.text else {
            showPopupView()
            return
        }
        guard let contentText = contentTextView.text else {
            showPopupView()
            return
        }
        
        switch viewModel.getType() {
        case .editCard :
            viewModel.setCardTitle(title: "#"+titleText)
            viewModel.setCardContent(content: contentText)
            viewModel.requestModifyCardAPI()
        case .addCard :
            viewModel.setNewCardTitle(title: "#"+titleText)
            viewModel.setNewCardContent(content: contentText)
            viewModel.requestAddCardAPI()
        }
        
        
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        dismissKeyboardWhenTappedAround()
        setBind()
        setUI()
        setBarButtonLocation(size: 10, barButton: leftButton,location: 1)
        setBarButtonLocation(size: -10, barButton: rightButton,location: 2)
    }
    
    // MARK: - Functions
    func setData(data: Card){
        viewModel.setCardInfo(newCardInfo: data)
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
    
    func setUI(){
        
        setTextView()
        setFont()
        switch viewModel.getType() {
        case .editCard :
            leftButton.tintColor = .clear
            leftButton.isEnabled = false
            leftButton.isAccessibilityElement = false

            leftButton.customView?.isHidden = true
            dateLabel.text = viewModel.getCardDate()
            let lastIdx = viewModel.getCardTitle().count-1
            titleTextField.text = viewModel.getCardTitle().substring(from: 1, to: lastIdx)
            urlToImg(urlStr: viewModel.getCardImageURL(), img: coffeeImageView)
            contentTextView.text = viewModel.getCardContent()
        case .addCard :
            leftButton.customView?.isHidden = false
            dateLabel.text = viewModel.getNewCoffeeDate()
            titleTextField.text = viewModel.getCoffeeInfo().name
            urlToImg(urlStr: viewModel.getCoffeeInfo().imgUrl, img: coffeeImageView)
        }
    }
    
    func setFont(){
        dateLabel.font = .globalFont(size: 16)
        titleTextField.font = .globalFont(size: 21)
        contentTextView.font = .globalFont(size: 17)
    }
    
    func setTextView(){
        contentTextView.textContainerInset = .zero
        contentTextView.text = textViewPlaceHolder
        contentTextView.textColor = UIColor(named: "cuppoColor3")
        contentTextView.delegate = self
    }
    
    /* 바인딩하는 부분 */
    func setBind() {
        viewModel.editEndStatus.bind { status in
            if status {
                self.navigationController?.popViewController(animated: false)
            }
        }
        
        viewModel.addEndStatus.bind { status in
            if status {
                self.dismiss(animated: true, completion: nil)
            }
        }
        
    }
    
    func showPopupView(){
        let popupView = AlertView(frame: view.bounds)
        popupView.okButton.isHidden = true
        popupView.popupAlert(firstBtnTitle: "예", secondBtnTitle: nil, content: "제목과 내용을 작성해주세요.", myView: popupView)
        popupView.delegate = self
        view.addSubview(popupView)
    }
    
    func backPopupView(){
        let popupView = AlertView(frame: view.bounds)
        popupView.popupAlert(firstBtnTitle: "아니요", secondBtnTitle: "예", content: "작성된 내용이 있습니다.\n기록을 취소하시겠습니까?.", myView: popupView)
        popupView.delegate = self
        view.addSubview(popupView)
    }
}

extension DiaryViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == textViewPlaceHolder {
            textView.text = nil
            textView.textColor = UIColor(named: "cuppoColor1")
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = textViewPlaceHolder
            textView.textColor = UIColor(named: "cuppoColor3")
        }
    }
}

extension DiaryViewController: CustomAlertProtocol {
    func cancleButtonTapped(_ popupView: UIView) {
        popupView.removeFromSuperview()
    }
    
    func okButtonTapped(_ popupView: UIView, _ year: String?, _ month: String?) {
        self.navigationController?.popViewController(animated: true)
        popupView.removeFromSuperview()
    }
}
