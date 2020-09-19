//
//  Currently.swift
//  ios-mvp
//
//  Created by Ahsan Ali on 15/06/2020.
//  Copyright © 2020 Ahsan Ali. All rights reserved.
//

import Foundation
import ObjectMapper

struct Currently : Mappable {
    var dt : Int?
    var sunrise : Int?
    var sunset : Int?
    var temp : Double?
    var feels_like : Double?
    var pressure : Int?
    var humidity : Int?
    var dew_point : Double?
    var uvi : Double?
    var clouds : Int?
    var visibility : Int?
    var wind_speed : Double?
    var wind_deg : Int?
    var weather : [Weather]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        dt <- map["dt"]
        sunrise <- map["sunrise"]
        sunset <- map["sunset"]
        temp <- map["temp"]
        feels_like <- map["feels_like"]
        pressure <- map["pressure"]
        humidity <- map["humidity"]
        dew_point <- map["dew_point"]
        uvi <- map["uvi"]
        clouds <- map["clouds"]
        visibility <- map["visibility"]
        wind_speed <- map["wind_speed"]
        wind_deg <- map["wind_deg"]
        weather <- map["weather"]
    }

}

extension Currently
{
    func getTemprature() -> String{
        guard let temprature = temp else { return "" }
        return String(TemperatureConverter.kelvinToCelsius(temprature)) + "°"
    }
    
    func getTodayDay() -> String
    {
        guard let timeStamp = dt else { return "" }
        return String(GeneralUtility.UnixToString(timestamp: timeStamp, format: "EEEE").uppercased()) + " Today"
    }
}
