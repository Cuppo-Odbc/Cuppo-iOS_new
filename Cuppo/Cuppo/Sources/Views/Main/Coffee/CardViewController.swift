//
//  CardViewController.swift
//  Cuppo
//
//  Created by 이하연 on 2022/04/04.
//

import UIKit
import SnapKit
import Photos

extension CardViewController: CustomAlertProtocol {
    func cancleButtonTapped(_ popupView: UIView) {
        popupView.removeFromSuperview()
    }
    
    func okButtonTapped(_ popupView: UIView, _ year: String?, _ month: String?) {
        viewModel.deleteCard()
        popupView.removeFromSuperview()
    }
    
}

extension CardViewController: DropDownProtocol {
    
    func editAction() {
        dropDownView.removeFromSuperview()
        moveToVC()
        
    }
    
    func shareAction() {
        dropDownView.removeFromSuperview()
        takeScreenshot(of: rootView)
        // TODO: - 공유됬는지 메시지 팝업창 표시하면 좋지않을까?
    }
    
    func deleteAction() {
        dropDownView.removeFromSuperview()
        showPopupView()
    }
    
}

class CardViewController: UIViewController {
    
    // MARK: - Properties
    let viewModel = CardViewModel()
    
    // MARK: - UIComponents
    let dropDownView = DropDownView(frame: .zero)
    var screenShotImgView: UIImage?
    @IBOutlet var rootView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var coffeeImageView: UIImageView!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var closeBarButton: UIBarButtonItem!
    @IBOutlet weak var menuBarButton: UIBarButtonItem!
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func menuButtonTapped(_ sender: Any) {
        showDropDown()
    }
    
    @IBAction func dropDownDismiss(_ sender: Any) {
        dropDownView.removeFromSuperview()
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setBind()
        setupData()
        setBarButtonLocation(size: 10, barButton: closeBarButton,location: 1)
        setBarButtonLocation(size: -10, barButton: menuBarButton,location: 2)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    // MARK: - Functions
    func setBarButtonLocation(size: Double,barButton: UIBarButtonItem, location: Int){
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        spacer.width = size
        if location == 1 {
            navigationItem.setLeftBarButtonItems([spacer,barButton], animated: false)
        }else {
            navigationItem.setRightBarButtonItems([spacer,barButton], animated: false)
        }
        
    }
    
    
    func setupData(){
        viewModel.requestCardInfo()
        showIndicator()
    }
    
    func setBind(){
        viewModel.cardInfo.bind { data in
            self.setupData()
            self.setUI()
            self.dismissIndicator()
        }
        
        viewModel.responseEnd.bind { status in
            if status {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func setUI(){
        setFont()
        dateLabel.text = viewModel.getCardDate()
        titleLabel.text = viewModel.getCardInfo().title
        urlToImg(urlStr: viewModel.getCardInfo().coffee, img: coffeeImageView)
        contentLabel.text = viewModel.getCardInfo().content
    }
    
    func setFont(){
        dateLabel.font = .globalFont(size: 16)
        titleLabel.font = .globalFont(size: 21)
        contentLabel.font = .globalFont(size: 17)
    }
    
    func showDropDown(){
        dropDownView.delegate = self
        view.addSubview(dropDownView)
        
        dropDownView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-30)
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
        self.navigationController?.pushViewController(DiaryVC, animated: false)
        
    }
    
    func showPopupView(){
        let popupView = AlertView(frame: view.bounds)
        popupView.popupAlert(firstBtnTitle: "아니요", secondBtnTitle: "예", content: "정말 삭제하시겠습니까?", myView: popupView)
        popupView.delegate = self
        view.addSubview(popupView)
    }
    
    // 스크린 캡쳐하는 함수
    func takeScreenshot(of view: UIView) {
        closeBarButton.customView?.isHidden = true
        menuBarButton.customView?.isHidden = true
        UIGraphicsBeginImageContextWithOptions(
            CGSize(width: view.bounds.width, height: view.bounds.height),
            false,
            2
        )
        
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let screenshot = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        screenShotImgView = screenshot
        shareMotionAction()
        
        UIImageWriteToSavedPhotosAlbum(screenshot, self, #selector(imageWasSaved), nil)
        closeBarButton.customView?.isHidden = false
        menuBarButton.customView?.isHidden = false
    }
    
    // 공유하는 함수
    func shareMotionAction(){
        var objectsToShare = [UIImage]()
        if let image = screenShotImgView {
            objectsToShare.append(image)
        }
        
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        
        self.present(activityVC, animated: true, completion: nil)
    }
    
    // MARK: - Actions
    @objc func imageWasSaved(_ image: UIImage, error: Error?, context: UnsafeMutableRawPointer) {
        if let error = error {
            print(error.localizedDescription)
            return
        }
        
        print("Image was saved in the photo gallery")
    }
    
}
