//
//  WeatherModel.swift
//  ForecastAppChallenge
//
//  Created by Santiago Rodriguez Affonso on 25/06/2022.
//

import Foundation

struct WeatherModel {
    let cityName: String
    
    let conditionId: Int
    let temperature: Double
    
    let tempMax: Double
    let tempMin: Double
    
    let pressure: Int
    let humidity: Int
    
    let longitude: Double
    let latitude: Double
    
    var temperatureString: String {
       return String(format: "%.0f", temperature)
    }
    
    var conditionName: String {
        switch conditionId {
        case 200...232:
            return "cloud.bolt.fill"
        case 300...321:
            return "cloud.drizzle.fill"
        case 500...531:
            return "cloud.rain.fill"
        case 600...622:
            return "cloud.snow.fill"
        case 701...781:
            return "cloud.fog.fill"
        case 800:
            return "sun.max.fill"
        case 801...804:
            return "cloud.fill"
        default:
            return "sun.min.fill"
        }
    }
}
