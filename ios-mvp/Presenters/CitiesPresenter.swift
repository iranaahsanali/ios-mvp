//
//  CitiesPresenter.swift
//  ios-mvp
//
//  Created by Ahsan Ali on 16/06/2020.
//  Copyright © 2020 Ahsan Ali. All rights reserved.
//

import Foundation

protocol CitiesViewDelegate: GenericProtocol {
    
}

class CitiesPresenter {
    private let citiesCoordinator : CitiesCoordinator
    weak private var delegate : CitiesViewDelegate?
    
    var cities : [City] = []
    
    init(citiesCoordinator : CitiesCoordinator) {
        self.citiesCoordinator = citiesCoordinator
    }
    
    func setDelegae(delegate : CitiesViewDelegate){
        self.delegate = delegate
    }
    
    func fetchCities(){
        self.delegate?.fetchingData()
        citiesCoordinator.fetchData(cities: {(cities) in
            self.cities = cities
            self.delegate?.dataFetched()
        })
    }
}
