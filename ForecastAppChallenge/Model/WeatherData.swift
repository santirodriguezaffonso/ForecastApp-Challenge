//
//  WeatherData.swift
//  ForecastAppChallenge
//
//  Created by Santiago Rodriguez Affonso on 24/06/2022.
//

import Foundation

struct WeatherData {
    let coord: Coordinates
    let weather: [Weather]
    let main: Main
    let name: String
}

struct Coordinates {
    let lat: Double
    let lon: Double
}

struct Weather {
    let id: Int
    let description: String
}

struct Main {
    let temp: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Int
    let humidity: Int
}
