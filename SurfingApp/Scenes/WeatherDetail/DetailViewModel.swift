//
//  DetailViewModel.swift
//  SurfingApp
//
//  Created by Dilara ACISU on 31.01.2025.
//

import Foundation

enum AirCondition: Int {
    case clearSky = 800
    case fewClouds = 801
    case scatteredClouds = 802
    case brokenClouds = 803
}

class DetailViewModel: BaseViewModel {
    
    var weatherModel: WeatherResponse?
    var weatherList: [WeatherDetailCellModel]?
    
    init(weatherModel: WeatherResponse?) {
        self.weatherModel = weatherModel
    }
    
    func setDetailList(completion: @escaping (Bool) -> ()) {
        if let bestList = calculateBestSurfingList() {
            weatherList = bestList.map { forecast in
                WeatherDetailCellModel(date: convertDateToStringValue(from: forecast.timestampLocal),
                                       time: convertToDate(from: forecast.timestampLocal),
                                       windSpeed: forecast.windSpd,
                                       temprature: forecast.temp,
                                       description: forecast.weather.description)
            }
            if let weatherList = weatherList, !weatherList.isEmpty {
                self.weatherList = weatherList.sorted(by: { $0.surfScore ?? 0 > $1.surfScore ?? 0})
                completion(true)
            } else {
                completion(false)
            }
        } else {
            completion(false)
        }
    }
    
    func calculateBestSurfingList() -> [Forecast]? {
        guard let data = weatherModel?.data else { return nil }
        
        let bestTimeList =  data.filter{ filterTimes(forecast: $0)}
        let bestWindList = bestTimeList.filter { ($0.windSpd > 5) && ($0.windSpd < 18) }
        let bestTempratureList = bestWindList.filter { ($0.temp > 5) && ($0.temp < 35) }
        let bestAirCndition = bestTempratureList.filter { filterAirCondition(forecast: $0) }

        return bestAirCndition
    }

    func convertToDate(from timestampLocal: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"

        if let date = dateFormatter.date(from: timestampLocal) {
            dateFormatter.dateFormat = "dd.MM.yyyy - HH:mm"
            return date
        }
        return nil
    }
    
    func convertDateToStringValue(from timestampLocal: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"

        if let date = dateFormatter.date(from: timestampLocal) {
            dateFormatter.dateFormat = "dd.MM.yyyy - HH:mm"
            return dateFormatter.string(from: date)
        }
        return nil
    }

    func isBetweenSixAndEighteen(date: Date) -> Bool {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        return hour >= 6 && hour <= 18
    }

    func filterTimes(forecast: Forecast) -> Bool {
        guard let date = convertToDate(from: forecast.timestampLocal) else { return false }
        return isBetweenSixAndEighteen(date: date)
    }
    
    func filterAirCondition(forecast: Forecast) -> Bool {
        if forecast.weather.code == AirCondition.clearSky.rawValue
            || forecast.weather.code == AirCondition.fewClouds.rawValue
            || forecast.weather.code == AirCondition.scatteredClouds.rawValue
            || forecast.weather.code == AirCondition.brokenClouds.rawValue {
            return true
        }
        return false
    }
    
}
