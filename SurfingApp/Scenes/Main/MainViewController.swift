//
//  MainViewController.swift
//  SurfingApp
//
//  Created by Dilara ACISU on 30.01.2025.
//

import UIKit
import SnapKit

class MainViewController: BaseViewController<MainViewModel> {
    
    private lazy var searchCountryContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .appWhite
        return view
    }()
    
    private lazy var searchCountryTextField: UITextField = {
        let field = UITextField()
        field.backgroundColor = .appWhite
        field.placeholder = "Search Country"
        field.delegate = self
        field.becomeFirstResponder()
        return field
    }()
    
    private lazy var countryTableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.showsVerticalScrollIndicator = false
        tableView.register(CountryTableViewCell.self, forCellReuseIdentifier: CountryTableViewCell.identifier)
        tableView.rowHeight = 40
        tableView.separatorStyle = .none
        tableView.isHidden = true
        return tableView
    }()
    
    private lazy var cityPickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.backgroundColor = .appWhite
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.largeContentTitle = "select the city..."
        pickerView.isHidden = true
        return pickerView
    }()
    
    private lazy var cityNameLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        return label
    }()
    
    private lazy var searchButton: UIButton = {
        let button = UIButton()
        button.isEnabled = false
        button.setTitle("Search", for: .normal)
        button.setTitle("Select Country And City for Search", for: .disabled)
        button.setTitleColor(.appWhite, for: .disabled)
        button.setTitleColor(.appGreen, for: .normal)
        button.addTarget(self, action: #selector(tappedSearch), for: .touchUpInside)
        button.backgroundColor = .appGray
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layout()
        
        let tappedAround = UITapGestureRecognizer(target: self, action: #selector(tappedAroundAction))
        tappedAround.cancelsTouchesInView = false
        view.addGestureRecognizer(tappedAround)
    }
    
    // MARK: - Override Methods
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        searchCountryContainerView.layer.cornerRadius = 8
        searchCountryContainerView.layer.borderWidth = 1
        searchCountryContainerView.layer.borderColor = UIColor.appGray.cgColor
        
        countryTableView.layer.cornerRadius = 8
        countryTableView.layer.borderWidth = 1
        countryTableView.layer.borderColor = UIColor.appGray.cgColor
        
        cityPickerView.layer.cornerRadius = 8
        cityPickerView.layer.borderWidth = 1
        cityPickerView.layer.borderColor = UIColor.appGray.cgColor
        
        searchButton.layer.cornerRadius = 8
        searchButton.layer.borderWidth = 1
        searchButton.layer.borderColor = UIColor.appGray.cgColor
    }
    
    private func setup() {
        viewModel?.delegate = self
        
        view.addSubview(searchCountryContainerView)
        searchCountryContainerView.addSubview(searchCountryTextField)

        view.addSubview(cityNameLabel)
        view.addSubview(cityPickerView)
        view.addSubview(countryTableView)
        view.addSubview(searchButton)
    }
    
    private func layout() {
        searchCountryContainerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(120)
            make.left.equalToSuperview().offset(36)
            make.right.equalToSuperview().inset(36)
            make.height.equalTo(60)
        }
        
        searchCountryTextField.snp.makeConstraints { make in
            make.top.left.equalToSuperview().inset(4)
            make.right.bottom.equalToSuperview().inset(4)
        }
        
        countryTableView.snp.makeConstraints { make in
            make.top.equalTo(searchCountryContainerView.snp.bottom)
            make.left.equalToSuperview().offset(36)
            make.right.equalToSuperview().inset(36)
            make.height.equalTo(400)
        }

        cityNameLabel.snp.makeConstraints { make in
            make.top.equalTo(searchCountryContainerView.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(36)
            make.right.equalToSuperview().inset(36)
            make.height.equalTo(60)
        }
        
        cityPickerView.snp.makeConstraints { make in
            make.top.equalTo(cityNameLabel.snp.bottom)
            make.left.equalToSuperview().offset(36)
            make.right.equalToSuperview().inset(36)
            make.height.equalTo(320)
        }
        
        searchButton.snp.makeConstraints { make in
            make.top.equalTo(cityPickerView.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(40)
            make.right.equalToSuperview().inset(40)
            make.height.equalTo(60)
        }
    }
    
    // MARK: - Private Methods
    private func presentAlert(message: String) {
        let alertController = UIAlertController(title: "Upps!", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel))
        self.present(alertController, animated: true)
    }
    
    // MARK: - Actions
    @objc private func tappedSearch() {
        viewModel?.getWeatherResponse(completion: { response, error in
            if let response = response {
                let detailVM = DetailViewModel(weatherModel: response)
                self.navigationController?.pushViewController(DetailViewController(viewModel: detailVM), animated: true)
            }
            if let error = error {
                self.presentAlert(message: error.localizedDescription)
            }
        })
    }
    
    @objc private func tappedAroundAction() {
        searchCountryTextField.resignFirstResponder()
    }
}

// MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let vm = viewModel else { return 0 }
        return vm.numberOfRowsInSectionCountry
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CountryTableViewCell.identifier) as? CountryTableViewCell,
              let item = viewModel?.cellForRowAtCountry(index: indexPath.row)
        else { return UITableViewCell() }
        
        cell.configure(title: item.title, isLastItem: item.isLast)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vm = viewModel else { return }
        
        searchCountryTextField.text = vm.cellForRowAtCountry(index: indexPath.row).title
        searchCountryTextField.resignFirstResponder()
        vm.countryFieldDisactive()
        vm.setCityListAndSearchButtonEnabled(countryName: searchCountryTextField.text ?? "")
    }
}

// MARK: - UITextFieldDelegate
extension MainViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let searchText = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        viewModel?.searchForCountry(with: searchText)
        viewModel?.setCityListAndSearchButtonEnabled(countryName: searchText)
        return true
    }
}

// MARK: - UIPickerViewDataSource - UIPickerViewDelegate
extension MainViewController: UIPickerViewDataSource, UIPickerViewDelegate {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        guard let viewModel else { return 0 }
        return viewModel.numberOfRowsInComponentCity
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard let viewModel else { return "" }
        return viewModel.titleForRowCity(index: row)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let viewModel else { return }
        let selectedCityName = viewModel.titleForRowCity(index: row)
        cityNameLabel.text = "Selected City: \(selectedCityName)"
        viewModel.setSelectedCity(cityName: selectedCityName)
    }
}

// MARK: - MainViewModelDelegate
extension MainViewController: MainViewModelDelegate {
    
    func reloadCountryTableView() {
        countryTableView.reloadData()
    }
    
    func hiddenCountryTableView(isHidden: Bool) {
        countryTableView.isHidden = isHidden
    }

    func hideCityPickerView() {
        cityNameLabel.text = "There is no selected city"
        
        viewModel?.clearCities()
        cityPickerView.reloadAllComponents()
        cityPickerView.isHidden = true
    }
    
    func showCityPickerView(cityName: String) {
        cityNameLabel.text = "Selected City: \(cityName)"
        viewModel?.setSelectedCity(cityName: cityName)
        
        cityPickerView.reloadAllComponents()
        cityPickerView.selectRow(0, inComponent: 0, animated: true)
        cityPickerView.isHidden = false
    }
    
    func setSearchButtonEnabled(isEnabled: Bool) {
        searchButton.isEnabled = isEnabled
        searchButton.backgroundColor = isEnabled ? .appWhite : .appGray
    }
    
    func showAlert(message: String) {
        presentAlert(message: message)
    }
}
