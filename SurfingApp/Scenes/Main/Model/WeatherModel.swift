//
//  WeatherModel.swift
//  SurfingApp
//
//  Created by Dilara ACISU on 31.01.2025.
//

import Foundation

struct WeatherResponse: Codable {
    let data: [Forecast]
}

struct Forecast: Codable {
    let datetime: String
    let temp: Double
    let timestampLocal, timestampUTC: String
    let ts: Int
    let weather: Weather
    let windSpd: Double
    
    enum CodingKeys: String, CodingKey {
        case datetime
        case temp
        case timestampLocal = "timestamp_local"
        case timestampUTC = "timestamp_utc"
        case ts
        case weather
        case windSpd = "wind_spd"
    }
}

struct Weather: Codable {
    let description: String
    let code: Int
}
