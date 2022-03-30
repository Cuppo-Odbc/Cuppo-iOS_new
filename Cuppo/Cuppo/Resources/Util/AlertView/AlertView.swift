//
//  AlertView.swift
//  Cuppo
//
//  Created by 이하연 on 2022/03/29.
//

import UIKit

class AlertView: UIView {
    public var delegate: CustomAlertProtocol?
    
    // MARK: - Properties
    var yearArr: [Int] = []
    var monthArr: [Int] = [1,2,3,4,5,6,7,8,9,10,11,12]
    var currentView: UIView!
    
    var selectYear: String = ""
    var selectMonth: String = ""
    
    // MARK: - UIComponents
    @IBOutlet var customView: UIView!
    @IBOutlet weak var yearPickerView: UIPickerView!
    @IBOutlet weak var monthPickerView: UIPickerView!
    @IBOutlet weak var calendarView: UIView!
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var okButton: UIButton!
    
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        self.delegate?.cancleButtonTapped(currentView)
    }
    
    @IBAction func okButtonTapped(_ sender: UIButton) {
        self.delegate?.okButtonTapped(currentView,selectYear,selectMonth)
    }
    
    
    // MARK: - LifeCycle
    
    override func layoutSubviews() {
        setButton()
        setPickerView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setYear()
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    // MARK: - Functions
    
    func setYear(){
        for year in 1950...2070 {
            yearArr.append(year)
        }
    }
    
    // 모든 화면에 맞춰주는 작업
    private func initialize() {
        Bundle.main.loadNibNamed("AlertView", owner: self, options: nil)
        customView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        customView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(customView)
    }
    
    // 버튼 테두리 생성
    func setButton(){
        cancelButton.layer.borderWidth = 0.5
        cancelButton.layer.borderColor = UIColor.lightGray.cgColor
        
        okButton.layer.borderWidth = 0.5
        okButton.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    // PickerView 설정
    func setPickerView(){
        yearPickerView.delegate = self
        yearPickerView.dataSource = self
        monthPickerView.delegate = self
        monthPickerView.dataSource = self
        selectedPickerViewUICustom(yearPickerView)
        selectedPickerViewUICustom(monthPickerView)
        
        let yearIdx = yearArr.firstIndex { $0 == Int(selectYear) }
        yearPickerView.selectRow(yearIdx!, inComponent:0, animated:true)
        let monthIdx = monthArr.firstIndex { $0 == Int(selectMonth) }
        monthPickerView.selectRow(monthIdx!, inComponent:0, animated:true)
    }
    
    // calendar PickerView 내부 선 생성
    func selectedPickerViewUICustom(_ selectedPickerView: UIPickerView) {
        selectedPickerView.subviews[1].backgroundColor = .clear
        
        let upLine = UIView(frame: CGRect(x: -8, y: 0, width: selectedPickerView.layer.frame.width, height: 1.5))
        let underLine = UIView(frame: CGRect(x: -8, y: 42, width: selectedPickerView.layer.frame.width, height: 1.5))
        
        upLine.backgroundColor = .black
        underLine.backgroundColor = .black
        
        selectedPickerView.subviews[1].addSubview(upLine)
        selectedPickerView.subviews[1].addSubview(underLine)
    }
    
    // 캘린더 표시
    func calendarAlert(_ myView: UIView){
        cancelButton.setTitle("취소", for: .normal)
        okButton.setTitle("확인", for: .normal)
        
        calendarView.isHidden = false
        popupView.isHidden = true
        currentView = myView
    }
    
    // 팝업 표시
    func popupAlert(firstBtnTitle: String? = "취소", secondBtnTitle: String? = "확인", content: String, myView: UIView){
        cancelButton.setTitle(firstBtnTitle, for: .normal)
        okButton.setTitle(secondBtnTitle, for: .normal)
        contentLabel.text = content
        
        calendarView.isHidden = true
        popupView.isHidden = false
        currentView = myView
    }
    
}
