//
//  CityModel.swift
//  SurfingApp
//
//  Created by Dilara ACISU on 30.01.2025.
//

import Foundation

struct City: CSVDecodable {
    var cityId: Int
    var cityName: String
    var stateCode: String
    var countryCode: String
    var countryFull: String
    var lat: Double
    var lon: Double

    init?(csvRow: [String]) {
        guard csvRow.count == 7 else { return nil }

        guard let cityId = Int(csvRow[0]),
              let lat = Double(csvRow[5]),
              let lon = Double(csvRow[6]) else { return nil }

        self.cityId = cityId
        self.cityName = csvRow[1]
        self.stateCode = csvRow[2]
        self.countryCode = csvRow[3]
        self.countryFull = csvRow[4]
        self.lat = lat
        self.lon = lon
    }
}
