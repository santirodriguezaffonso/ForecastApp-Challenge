//
//  APIManager.swift
//  ForecastAppChallenge
//
//  Created by Santiago Rodriguez Affonso on 24/06/2022.
//

import Foundation

class APIManager {
    
    private let url = "https://api.openweathermap.org/data/2.5/weather?&appid=7c76f28176126711c0afd661e413f671&units=metric"
    
    //function to bring the city name
    func getWeather(by cityName: String) {
        let urlString = "\(url)&q=\(cityName)"
        //         print(urlString) Safety check
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
                    //                    let dataString = String(data: data, encoding: .utf8)
                    //                    print(dataString as Any) Safety check
                    self.parseJSON(data)
                }
            }
            task.resume()
        }
    }
    
    // function to decode the data and retreive a model
    func parseJSON(_ weatherData: Data) {
        let decoder = JSONDecoder()
        do {
            let results = try decoder.decode(WeatherData.self, from: weatherData)
            print(results.name)
        } catch {
            print("Decoding Error", error)
        }
    }
    
}
