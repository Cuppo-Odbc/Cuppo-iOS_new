//
//  DiaryViewController.swift
//  Cuppo
//
//  Created by 이하연 on 2022/03/11.
//

import UIKit

class DiaryViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.textContainerInset = .zero
        dismissKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
