//
//  File.swift
//  Cuppo
//
//  Created by 이하연 on 2022/04/04.
//

import UIKit

protocol DropDownProtocol {
    func editAction()
    func shareAction()
    func deleteAction()
}

class DropDownView: UIView {
    
    public var delegate: DropDownProtocol?
    @IBOutlet var dropdownView: UIView!
    @IBOutlet weak var editView: UIView!
    @IBOutlet weak var shareView: UIView!
    @IBOutlet weak var deleteView: UIView!
    
    @IBOutlet weak var editLabel: UILabel!
    @IBOutlet weak var shareLabel: UILabel!
    @IBOutlet weak var deleteLabel: UILabel!
    
    
    // MARK: - UI Components
    @IBAction func editTapped(_ sender: Any) {
        delegate?.editAction()
    }
    
    @IBAction func shareTapped(_ sender: Any) {
        delegate?.shareAction()
    }
    
    @IBAction func deleteTapped(_ sender: Any) {
        delegate?.deleteAction()
    }
    
    // MARK: - LifeCycle
    override func layoutSubviews() {
        setUI()
        setFont()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    private func initialize() {
        Bundle.main.loadNibNamed("DropDownView", owner: self, options: nil)
        dropdownView.frame = .zero
        addSubview(dropdownView)
    }
    
    func setUI(){

        setView(view: editView)
        setView(view: shareView)
        setView(view: deleteView)
        setView(view: dropdownView)
    }
    
    func setFont(){
        editLabel.font = .globalFont(size: 18)
        shareLabel.font = .globalFont(size: 18)
        deleteLabel.font = .globalFont(size: 18)
    }
    
    func setView(view: UIView){
        view.layer.borderColor = UIColor(named: "cuppoColor10")?.cgColor
        view.layer.borderWidth = 0.3
    }
}
