//
//  ReusableView+Extensions.swift
//  SurfingApp
//
//  Created by Dilara ACISU on 31.01.2025.
//

import UIKit

public extension ReusableView where Self: UIView {
    static var defaultReuseIdentifier: String {
        return String(describing: self)
    }
}
