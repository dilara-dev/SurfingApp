//
//  ReusableView.swift
//  SurfingApp
//
//  Created by Dilara ACISU on 31.01.2025.
//

import UIKit

public protocol ReusableView: AnyObject {
    static var defaultReuseIdentifier: String { get }
}
