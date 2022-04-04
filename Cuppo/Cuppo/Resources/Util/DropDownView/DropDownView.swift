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
    
    func setView(view: UIView){
        view.layer.borderColor = UIColor.cuppoGray.cgColor
        view.layer.borderWidth = 0.3
    }
}
