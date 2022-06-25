//
//  ViewController.swift
//  ForecastAppChallenge
//
//  Created by Santiago Rodriguez Affonso on 24/06/2022.
//

import UIKit

class MainViewController: UIViewController {
    
    var apiManager = APIManager()
    
    var weatherInfo: WeatherModel?

    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    
    @IBOutlet weak var tempMax: UILabel!
    @IBOutlet weak var tempMin: UILabel!
    
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    
    @IBOutlet weak var shadowBox: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customization()
        
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        cityName.text = weatherInfo?.cityName
//    }
    
    func customization() {
        shadowBox.layer.cornerRadius = 10
    }
    
    
//    func didUpdateWeather(weather: WeatherModel) {
//        print(weather.temperatureString)
//    }
}

