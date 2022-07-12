//
//  APIManager.swift
//  ForecastAppChallenge
//
//  Created by Santiago Rodriguez Affonso on 24/06/2022.
//

import Foundation
import CoreLocation

protocol ApiManagerDelegate {
    func didUpdateWeather(weather: WeatherModel)
}

class APIManager {
    
    var delegate: ApiManagerDelegate?
    
    private let url = "https://api.openweathermap.org/data/2.5/weather?&appid=7c76f28176126711c0afd661e413f671&units=metric"
    
    //functions to get dinamyc URLs
    func getWeather(by cityName: String) {
        let urlString = "\(url)&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    func getWeather(by latitude: CLLocationDegrees, by longitude: CLLocationDegrees) {
        let urlString = "\(url)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }
    
    // function to perform the API request
    func performRequest(with url: String) {
        if let urlString = URL(string: url) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: urlString) { data, _, error in
                if error != nil {
                    print("Error making request\(String(describing: error))")
                }
                
                if let data = data {
                    if let weather = self.parseJSON(data) {
                        self.delegate?.didUpdateWeather(weather: weather)
                    }
                }
            }
            task.resume()
        }
    }
    
    // function to decode the data and bring back a model
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let r = try decoder.decode(WeatherData.self, from: weatherData)
            
            let weather = WeatherModel(cityName: r.name, conditionId: r.weather[0].id, temperature: r.main.temp, maxTemp: r.main.tempMax, minTemp: r.main.tempMin, pressure: r.main.pressure, humidity: r.main.humidity, longitude: r.coord.lon, latitude: r.coord.lat)
            
            return weather
        } catch {
            print("Decoding Error", error)
            return nil
        }
    }
    
}
