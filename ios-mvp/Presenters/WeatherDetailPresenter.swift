//
//  WeatherDetailPresenter.swift
//  ios-mvp
//
//  Created by Ahsan Ali on 16/06/2020.
//  Copyright © 2020 Ahsan Ali. All rights reserved.
//

import Foundation

protocol WeatherDetailDelegate: GenericProtocol {
    
}

class WeatherDetailPresenter {
    private let weatherCoordinator : WeatherCoordinator
    weak private var delegate : WeatherDetailDelegate?
    
    var city : City?
    var weatherData : WeatherDetailResponse?
    
    init(coordinator : WeatherCoordinator) {
        self.weatherCoordinator = coordinator
    }
    
    func setDelegae(delegate : WeatherDetailDelegate){
        self.delegate = delegate
    }
    
    func setCity(city : City){
        self.city = city
    }
    
    func fetchData(){
        fetchWeatherDetail()
    }
    
    private func fetchWeatherDetail(){
        self.delegate?.fetchingData()
        guard let longitude = city?.longitude, let latitude = city?.latitude else { return }
        weatherCoordinator.fetchData(latitude: latitude, longitude: longitude, success: {(weatherDetail) in
            self.weatherData = weatherDetail
            self.delegate?.dataFetched()
        }, failure: {(error) in
            self.delegate?.handleError(error: error)
        })
    }
}
