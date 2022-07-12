//
//  MainViewController.swift
//  ForecastAppChallenge

//  Created by Santiago Rodriguez Affonso on 24/06/2022.

import UIKit
import MapKit
import SwipeCellKit

class MainViewController: UIViewController {
    
    var viewModel = MainViewControllerViewModel()
    var locationManager = CLLocationManager()
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
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        searchTextField.delegate = self
        tableView.dataSource = self
        apiManager.delegate = self
        tableView.delegate = self
        locationServices()
        initialStyles()
    }
    
    @IBAction func currentLocationButton(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    
    func initialStyles() {
        tableView.isHidden = true
        shadowBox.layer.cornerRadius = 10
        mapView.layer.cornerRadius = 10
        tableView.layer.cornerRadius = 5
    }
    
    func locationServices() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    func setupMap() {
        mapView.showsUserLocation = true
        mapView.cameraZoomRange = MKMapView.CameraZoomRange(minCenterCoordinateDistance: 1200, maxCenterCoordinateDistance: 10000)
    }
    
    func smoothness(toggle: Bool) {
        if viewModel.history.count > 0 {
            UIView.animate(withDuration: 0.3) {
                    self.tableView.isHidden = toggle
            }
        }
    }
}

//MARK: - API Manager Delegate
extension MainViewController: ApiManagerDelegate {
    func didUpdateWeather(weather: WeatherModel) {
        DispatchQueue.main.async { [self] in
            cityName.text = weather.cityName
            tempLabel.text = weather.temperatureString
            iconImage.image = UIImage(systemName: weather.conditionName)
            tempMax.text = weather.temperatureMax
            tempMin.text = weather.temperatureMin
            pressureLabel.text = String(weather.pressure)
            humidityLabel.text = String(weather.humidity)
            mapView.centerCoordinate.latitude = weather.latitude
            mapView.centerCoordinate.longitude = weather.longitude
        }
        setupMap()
    }
}

//MARK: - UITextField Methods
extension MainViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        tableView.reloadData()
        smoothness(toggle: false)
    }
    
    // "Search" button pressed by user:
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    // User end editing:
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchTextField.text {
            apiManager.getWeather(by: city)
            if searchTextField.text != "" {
                viewModel.getToStore(city)
            }
        }
        searchTextField.text = ""
        smoothness(toggle: true)
    }
}

//MARK: - UITableView Methods
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let array = viewModel.history.count
        return array
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reusableCell", for: indexPath) as! SwipeTableViewCell
        var content = cell.defaultContentConfiguration()
        content.text = viewModel.history[indexPath.row]
        content.image = UIImage(systemName: "arrowshape.turn.up.backward")
        cell.delegate = self
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        apiManager.getWeather(by: viewModel.history[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
        smoothness(toggle: true)
        searchTextField.endEditing(true)
    }
}

//MARK: - User Location
extension MainViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            apiManager.getWeather(by: latitude, by: longitude)
            locationManager.stopUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

 //MARK: - SwipeCellKit methods
extension MainViewController: SwipeTableViewCellDelegate {
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        
        guard orientation == .right else { return nil}
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { [self] action, indexPath in
            viewModel.deletion(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        return [deleteAction]
    }
}
