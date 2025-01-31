//
//  NetworkManager.swift
//  SurfingApp
//
//  Created by Dilara ACISU on 30.01.2025.
//

import Foundation

let baseURL = "https://api.weatherbit.io/v2.0/forecast/daily?key=15086ca2e29f450696f43c6bc4bebf1e&city=Istanbul"

enum NetworkError: Error {
    case noData
    case decodingError
    case serverError
    case unknownError
}

class NetworkManager {
    
    func performRequest<T: Codable>(request: URLRequest, completion: @escaping (Result<T, Error>)->Void) {
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                print("error")
                return
            }
            do {
                guard let data = data else {
                    throw NetworkError.noData
                }
                let response = try JSONDecoder().decode(T.self, from: data)
    
                DispatchQueue.main.async {
                    completion(.success(response))
                }
            }
            catch let decodingError {
                DispatchQueue.main.async {
                    completion(.failure(decodingError))
                }
            }
        }.resume()
    }
}
