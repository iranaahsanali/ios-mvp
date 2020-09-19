//
//  Hourly.swift
//  ios-mvp
//
//  Created by Ahsan Ali on 15/06/2020.
//  Copyright © 2020 Ahsan Ali. All rights reserved.
//

import Foundation
import ObjectMapper

struct Hourly : Mappable {
    var dt : Int?
    var temp : Double?
    var feels_like : Double?
    var pressure : Int?
    var humidity : Int?
    var dew_point : Double?
    var clouds : Int?
    var visibility : Int?
    var wind_speed : Double?
    var wind_deg : Int?
    var weather : [Weather]?
    var pop : Int?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        dt <- map["dt"]
        temp <- map["temp"]
        feels_like <- map["feels_like"]
        pressure <- map["pressure"]
        humidity <- map["humidity"]
        dew_point <- map["dew_point"]
        clouds <- map["clouds"]
        visibility <- map["visibility"]
        wind_speed <- map["wind_speed"]
        wind_deg <- map["wind_deg"]
        weather <- map["weather"]
        pop <- map["pop"]
    }

}


extension Hourly
{
    func getTemprature() -> String{
        guard let temprature = temp else { return "" }
        return String(TemperatureConverter.kelvinToCelsius(temprature)) + "°"
    }
    
    func getHour() -> String
    {
        guard let timeStamp = dt else { return "" }
        if GeneralUtility.DateToString(date: Date(), format: "h a") == GeneralUtility.UnixToString(timestamp: timeStamp, format: "h a"){
            return "Now"
        }
        return String(GeneralUtility.UnixToString(timestamp: timeStamp, format: "h a"))
    }
}
