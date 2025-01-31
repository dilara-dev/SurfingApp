//
//  CountryTableViewCell.swift
//  SurfingApp
//
//  Created by Dilara ACISU on 31.01.2025.
//

import UIKit

final class CountryTableViewCell: UITableViewCell {
    static let identifier = "CountryTableViewCell"
    
    private lazy var label: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var seperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .appGray
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setup() {
        contentView.addSubview(label)
        contentView.addSubview(seperatorView)
    }
    
    private func layout() {
        label.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().inset(12)
            make.centerY.equalToSuperview()
        }
        
        seperatorView.snp.makeConstraints { make in
            make.left.equalTo(label.snp.left)
            make.right.equalTo(label.snp.right)
            make.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    
    public func configure(title: String?, isLastItem: Bool) {
        label.text = title
        seperatorView.isHidden = isLastItem
    }

}
