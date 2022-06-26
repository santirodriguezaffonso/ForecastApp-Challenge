//
//  ViewController.swift
//  ForecastAppChallenge
//
//  Created by Santiago Rodriguez Affonso on 24/06/2022.
//

import UIKit

class MainViewController: UIViewController, ApiManagerDelegate {
    
    var apiManager = APIManager()

    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var tempMax: UILabel!
    @IBOutlet weak var tempMin: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var shadowBox: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        apiManager.delegate = self
        searchTextField.delegate = self
        
        customization()
    }
    
    func customization() {
        shadowBox.layer.cornerRadius = 10
    }
    
    @IBAction func currentLocationButton(_ sender: UIButton) {
    }
   
    
    func didUpdateWeather(weather: WeatherModel) {
        DispatchQueue.main.async { [self] in
            cityName.text = weather.cityName
            tempLabel.text = weather.temperatureString
            iconImage.image = UIImage(systemName: weather.conditionName)
            tempMax.text = weather.temperatureMax
            tempMin.text = weather.temperatureMin
            pressureLabel.text = String(weather.pressure)
            humidityLabel.text = String(weather.humidity)
        }
    }
}



//MARK: - UITextField Methods

extension MainViewController: UITextFieldDelegate {
    
    // "Search" button pressed by user:
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    // User end editing:
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchTextField.text {
            apiManager.getWeather(by: city)
        }
        searchTextField.text = ""
    }
}
