//
//  MainViewModel.swift
//  SurfingApp
//
//  Created by Dilara ACISU on 30.01.2025.
//

import Foundation

protocol MainViewModelDelegate: AnyObject {
    func reloadCountryTableView()
    func hiddenCountryTableView(isHidden: Bool)
    func hideCityPickerView()
    func showCityPickerView(cityName: String)
    func setSearchButtonEnabled(isEnabled: Bool)
    func showAlert(message: String)
}

class MainViewModel: BaseViewModel {
    
    private var selectedCityName: String?
    
    private var rawCountries: [Country] = []
    private var countries: [Country] = []
    
    private var rawCities: [City] = []
    private var cities: [City] = []
    
    private var mainNetworking = MainNetworking()
    var weatherModel: WeatherResponse?

    weak var delegate: MainViewModelDelegate?
    
    // MARK: - Computed Properties
    var numberOfRowsInSectionCountry: Int {
        countries.count
    }
    
    var numberOfRowsInComponentCity: Int {
        cities.count
    }
    
    override init() {
        if let countries = CSVParser.parseCSV(fileName: "Countries", type: Country.self) {
            self.rawCountries = countries
        } else {
            delegate?.showAlert(message: "There is something wrong")
        }
        
        if let cities = CSVParser.parseCSV(fileName: "Cities", type: City.self) {
            self.rawCities = cities
        } else {
            delegate?.showAlert(message: "There is something wrong")
        }
    }
    
    // MARK: - Public Methods
    func cellForRowAtCountry(index: Int) -> (title: String, isLast: Bool) {
        return (countries[index].countryName, countries.count - 1 == index)
    }
    
    func getCountryCode(index: Int) -> String {
        return countries[index].countryCode
    }
    
    func titleForRowCity(index: Int) -> String {
        return "\(cities[index].cityName)"
    }
    
    func searchForCountry(with searchText: String) {
        if searchText.isEmpty {
            countryFieldDisactive()
            return
        }
        
        let filteredCountries = rawCountries.filter { country in
            country.countryName.lowercased().contains(searchText.lowercased())
        }
        
        if filteredCountries.isEmpty {
            countryFieldDisactive()
        } else {
            countries = filteredCountries
            countryFieldActive()
        }
    }
    
    func setCityListAndSearchButtonEnabled(countryName: String) {
        setCitiesListOfCountry(countryName: countryName)
        if let cityName = cities.first?.cityName {
            delegate?.showCityPickerView(cityName: cityName)
            delegate?.setSearchButtonEnabled(isEnabled: true)
        } else {
            delegate?.hideCityPickerView()
            delegate?.setSearchButtonEnabled(isEnabled: false)
        }
    }
    
    func setSelectedCity(cityName: String) {
        selectedCityName = cityName
    }
    
    func countryFieldDisactive() {
        countries = []
        delegate?.reloadCountryTableView()
        delegate?.hiddenCountryTableView(isHidden: true)
    }
    
    func clearCities() {
        cities.removeAll()
    }
    
    // MARK: - Private Methods
    private func countryFieldActive() {
        delegate?.reloadCountryTableView()
        delegate?.hiddenCountryTableView(isHidden: false)
    }
    
    private func setCitiesListOfCountry(countryName: String) {
        cities = rawCities
            .filter { $0.countryFull == countryName }
            .sorted { $0.cityName < $1.cityName }
    }
    
    // MARK: - Service
    func getWeatherResponse(completion: @escaping (WeatherResponse?, Error?) -> Void) {
        guard let selectedCityName = selectedCityName else { return }
        mainNetworking.fetchCities(for: selectedCityName, completion: { [weak self] response, error in

            guard let response else { return completion(nil, error) }
            completion(response, nil)
        })
    }

}

