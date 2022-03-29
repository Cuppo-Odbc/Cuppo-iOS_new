//
//  CalendarViewController.swift
//  Cuppo
//
//  Created by 이하연 on 2022/03/08.
//

import UIKit

class CalendarViewController: BaseController {
    
    var selectedDate = Date()
    var totalSquares = [String]()
    
    // MARK: - UIComponents
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setMonthView()
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    // 해당 달의 일수 설정
    func setMonthView(){
        totalSquares.removeAll()
        
        var count: Int = 0
        
        let daysInMonth = CalendarHelper().daysInMonth(date: selectedDate)
        let firstDayOfMonth = CalendarHelper().firstOfMonth(date: selectedDate)
        let startingSpaces = CalendarHelper().weekDay(date: firstDayOfMonth)
        
        while count < 42 {
            let dayLocation = count - startingSpaces
            
            if(dayLocation < 0 || dayLocation >= daysInMonth){
                totalSquares.append("")
            } else {
                totalSquares.append(String(dayLocation+1))
            }
            count += 1
        }
        
        yearLabel.text = CalendarHelper().yearString(date: selectedDate)
        monthLabel.text = CalendarHelper().monthString(date: selectedDate).uppercased()
        collectionView.reloadData()
    }
    
}
