//
//  SplashViewController.swift
//  SurfingApp
//
//  Created by Dilara ACISU on 30.01.2025.
//

import UIKit

class SplashViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .surfBlue
        self.navigationController?.viewControllers = [MainViewController(viewModel: MainViewModel())]
    }
}

