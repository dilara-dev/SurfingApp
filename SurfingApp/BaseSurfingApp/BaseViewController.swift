//
//  BaseViewController.swift
//  SurfingApp
//
//  Created by Dilara ACISU on 30.01.2025.
//

import UIKit

class BaseViewController<T: BaseViewModel>: UIViewController {
    
    var viewModel: T?
    
    init(viewModel: T) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .surfBlue
    }
}
