//
//  SearchViewController.swift
//  ForecastAppChallenge
//
//  Created by Santiago Rodriguez Affonso on 24/06/2022.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate {
    
    let searchBar = UISearchBar()

    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
    }
    

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
