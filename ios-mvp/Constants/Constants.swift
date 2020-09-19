//
//  Constants.swift
//  ios-mvp
//
//  Created by Ahsan Ali on 15/06/2020.
//  Copyright © 2020 Ahsan Ali. All rights reserved.
//

import Foundation

struct Constants {
    static let AppName = "MVP + TDD"
    static let API_KEY = "84289c8c0c8b4b748683f5830147cce0"
    static let BASE_URL = "https://api.openweathermap.org/data/2.5/"
    
    static let AppErrorCode = 1000
    
    // MARK: Error Messages
    static let ErrorInternetConnection = "Internet connection appears to be offline."
    static let ServerConnectionError = "We are unable to connect to the server at the moment. Please retry later."
    
    // End Points
    struct EndPoints {
        static let fetchWeatherData = "onecall"
    }
}
