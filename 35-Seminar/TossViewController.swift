//
//  TossViewController.swift
//  35-Seminar
//
//  Created by 김나연 on 10/12/24.
//

import UIKit

final class TossViewController: UIViewController {
    
    private let rootView = TossView()
    
    override func loadView() {
        super.loadView()
        
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
