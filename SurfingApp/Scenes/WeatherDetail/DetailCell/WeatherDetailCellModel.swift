//
//  WeatherDetailCellModel.swift
//  SurfingApp
//
//  Created by Dilara ACISU on 31.01.2025.
//

import Foundation

public protocol WeatherDetailCellDataSource: AnyObject {
    var date: String? { get }
    var time: Date? { get }
    var windSpeed: Double? { get }
    var temprature: Double? { get }
    var description: String? { get }
}


public final class WeatherDetailCellModel: WeatherDetailCellDataSource {
    public var date: String?
    public var time: Date?
    public var windSpeed: Double?
    public var temprature: Double?
    public var description: String?
    public var surfScore: Double?
    
    public init(date: String?, time: Date?, windSpeed: Double?, temprature: Double?, description: String?) {
        self.date = date
        self.time = time
        self.windSpeed = windSpeed
        self.temprature = temprature
        self.description = description
        self.surfScore = (18.0 - (windSpeed ?? 0 - 12.0)) + (35.0 - (temprature ?? 0 - 20.0))
    }
    
}
