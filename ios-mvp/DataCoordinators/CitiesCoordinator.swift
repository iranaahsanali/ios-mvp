//
//  CitiesCoordinator.swift
//  ios-mvp
//
//  Created by Ahsan Ali on 16/06/2020.
//  Copyright © 2020 Ahsan Ali. All rights reserved.
//

import Foundation

class CitiesCoordinator
{
    func fetchData(cities: ([City])->Void)
    {
        let citiesArray = [City(id: 1, name: "Lahore", longitude: 74.343611, latitude: 31.549722),
                           City(id: 2, name: "Faisalabad", longitude: 73.083333, latitude: 31.416667),
                           City(id: 3, name: "Sargoda", longitude: 72.671111, latitude: 32.083611),]
        cities(citiesArray)
    }
    
}
