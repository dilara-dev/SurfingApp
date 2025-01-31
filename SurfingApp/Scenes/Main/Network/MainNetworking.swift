//
//  MainNetworking.swift
//  SurfingApp
//
//  Created by Dilara ACISU on 30.01.2025.
//

import Foundation

class MainNetworking {
    
    let networkManager = NetworkManager()

    func fetchCities(for cityName: String, completion: @escaping (WeatherResponse?, Error?) -> Void) {
        guard let url = URL(string: "https://api.weatherbit.io/v2.0/forecast/hourly?key=15086ca2e29f450696f43c6bc4bebf1e&city=\(cityName)") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        networkManager.performRequest(request: request) { (result: Result<WeatherResponse, Error>) in
            switch result {
            case .success(let response):
                completion(response, nil)
                print("Cities received: \(response)")
            case .failure(let error):
                completion(nil, error)
                print("Error occurred: \(error.localizedDescription)")
            }
        }
    }
}
