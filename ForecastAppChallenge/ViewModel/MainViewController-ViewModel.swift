//
//  MainViewController-ViewModel.swift
//  ForecastAppChallenge
//
//  Created by Santiago Rodriguez Affonso on 25/06/2022.
//

import Foundation


class MainViewControllerViewModel {
    
    var history: [String] = []
    
    func getToStore(_ name: String) {
        history.insert(name, at: 0)
        
        if history.count > 5 {
            history.removeLast()
        }
    }
    
    func deletion(at index: Int) {
        history.remove(at: index)
    }
}


