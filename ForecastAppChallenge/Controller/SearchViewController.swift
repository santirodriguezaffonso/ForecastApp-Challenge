//
//  SearchViewController.swift
//  ForecastAppChallenge
//
//  Created by Santiago Rodriguez Affonso on 24/06/2022.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTextField.delegate = self
    }
}

extension SearchViewController: UITextFieldDelegate {
    
    // "Search" button pressed by user:
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    // User try to deselect textField
//    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
//
//    }
    
    // User end editing:                                    (This let you avoid repeat code)
    func textFieldDidEndEditing(_ textField: UITextField) {
        //Next: Inside this method use the searchTextField.text to get the weather for that city
        searchTextField.text = ""
    }
}
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
