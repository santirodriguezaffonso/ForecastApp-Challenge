//
//  WeatherData.swift
//  ForecastAppChallenge
//
//  Created by Santiago Rodriguez Affonso on 24/06/2022.
//

import Foundation

struct WeatherData: Codable {
    let coord: Coordinates
    let weather: [Weather]
    let main: Main
    let name: String
}

struct Coordinates: Codable {
    let lat: Double
    let lon: Double
}

struct Weather: Codable {
    let id: Int
    let description: String
}

struct Main: Codable {
    let temp: Double
    let tempMin: Double
    let tempMax: Double
    let pressure: Int
    let humidity: Int
    
    enum CodingKeys: String, CodingKey {
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case temp, pressure, humidity
    }
}
