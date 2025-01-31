//
//  CountryModel.swift
//  SurfingApp
//
//  Created by Dilara ACISU on 30.01.2025.
//

import Foundation

struct Country: CSVDecodable {
    let countryCode: String
    let countryName: String
    
    init?(csvRow: [String]) {
        guard csvRow.count == 2 else { return nil }
        self.countryCode = csvRow[0]
        self.countryName = csvRow[1]
    }
}
