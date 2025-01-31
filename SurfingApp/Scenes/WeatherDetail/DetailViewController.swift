//
//  DetailViewController.swift
//  SurfingApp
//
//  Created by Dilara ACISU on 31.01.2025.
//

import UIKit

class DetailViewController: BaseViewController<DetailViewModel> {
    
    private lazy var detailCollectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .vertical
        collectionViewLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(WeatherDetailCell.self, forCellWithReuseIdentifier: WeatherDetailCell.defaultReuseIdentifier)
        collectionView.dataSource = self
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupNavigation()
        viewModel?.setDetailList(completion: { condition in
            guard condition else { return self.setUpEmptyView() }
            
            self.setup()
            self.layout()
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func setup() {
        view.addSubview(detailCollectionView)
    }
    
    private func layout() {
        detailCollectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(80)
            make.left.equalToSuperview().offset(36)
            make.right.equalToSuperview().inset(36)
            make.bottom.equalToSuperview().inset(80)
        }
    }
    
    private func setupNavigation() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.barTintColor = .appGray
        
        let customBackButton = UIBarButtonItem(title: " < Back to Search", style: .plain, target: self, action: #selector(backToPreviousScreen))
        customBackButton.tintColor = .appWhite
        navigationItem.leftBarButtonItem = customBackButton
    }
    
    private func setUpEmptyView() {
        let emptyStateView = UIView()
        
        let emptyLabel = UILabel()
        emptyLabel.text = "There in no surfing area now."
        emptyLabel.textAlignment = .center
        
        emptyStateView.addSubview(emptyLabel)
        emptyLabel.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
            make.size.equalTo(300)
        }
        
        view.addSubview(emptyStateView)
        emptyStateView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(80)
            make.left.equalToSuperview().offset(36)
            make.right.equalToSuperview().inset(36)
        }
    }
    
    // MARK: - Actions
    @objc func backToPreviousScreen() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension DetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.weatherList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: WeatherDetailCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.set(viewModel: viewModel?.weatherList?[indexPath.row])
        return cell
    }
    
}
