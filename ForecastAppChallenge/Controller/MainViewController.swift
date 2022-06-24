//
//  ViewController.swift
//  ForecastAppChallenge
//
//  Created by Santiago Rodriguez Affonso on 24/06/2022.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var temp: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    
    @IBOutlet weak var tempMax: UILabel!
    @IBOutlet weak var tempMin: UILabel!
    
    @IBOutlet weak var pressure: UILabel!
    @IBOutlet weak var humidity: UILabel!
    
    @IBOutlet weak var shadowBox: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customization()
    }

    func customization() {
        shadowBox.layer.cornerRadius = 10
    }
    
    
}

