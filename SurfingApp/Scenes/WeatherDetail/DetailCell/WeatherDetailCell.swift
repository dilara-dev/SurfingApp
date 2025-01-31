//
//  WeatherDetailCell.swift
//  SurfingApp
//
//  Created by Dilara ACISU on 31.01.2025.
//

import UIKit

class WeatherDetailCell: UICollectionViewCell, ReusableView {
    
    weak var viewModel: WeatherDetailCellDataSource?
    
    private let detailStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        return stackView
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .appGray
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private let windSpeedLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()
    
    private let tempratureLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureContents()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureContents()
    }
    
    private func configureContents() {
        contentView.addSubview(detailStackView)
        contentView.backgroundColor = .appWhite
        contentView.layer.cornerRadius = 8
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.appGray.cgColor
        
        detailStackView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(5)
            make.bottom.trailing.equalToSuperview().inset(5)
            make.width.equalTo(300)
        }
        detailStackView.addArrangedSubview(dateLabel)
        detailStackView.addArrangedSubview(descriptionLabel)
        detailStackView.addArrangedSubview(windSpeedLabel)
        detailStackView.addArrangedSubview(tempratureLabel)
    }
    
    public func set(viewModel: WeatherDetailCellModel?) {
        self.viewModel = viewModel
        guard let date = viewModel?.date, let time = viewModel?.time else { return }
        self.dateLabel.text = date
        if let description = viewModel?.description {
            self.descriptionLabel.text = description
        }
        if let windSpeed = viewModel?.windSpeed {
            self.windSpeedLabel.text = "Wind Speed: \(windSpeed)"
        }
        if let temprature = viewModel?.temprature {
            self.tempratureLabel.text = "Temprature: \(temprature)"
        }
    }
    
}
