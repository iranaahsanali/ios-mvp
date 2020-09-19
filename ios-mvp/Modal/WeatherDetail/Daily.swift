//
//  Daily.swift
//  ios-mvp
//
//  Created by Ahsan Ali on 15/06/2020.
//  Copyright © 2020 Ahsan Ali. All rights reserved.
//

import Foundation
import ObjectMapper

struct Daily : Mappable {
    var dt : Int?
    var sunrise : Int?
    var sunset : Int?
    var temp : Temp?
    var feels_like : Feels_like?
    var pressure : Int?
    var humidity : Int?
    var dew_point : Double?
    var wind_speed : Double?
    var wind_deg : Int?
    var weather : [Weather]?
    var clouds : Int?
    var pop : Int?
    var uvi : Double?

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
        wind_speed <- map["wind_speed"]
        wind_deg <- map["wind_deg"]
        weather <- map["weather"]
        clouds <- map["clouds"]
        pop <- map["pop"]
        uvi <- map["uvi"]
    }

}


extension Daily
{
    func getCeliusMaxTemprature() -> String{
        guard let temprature = temp?.max else { return "" }
        return String(TemperatureConverter.kelvinToCelsius(temprature)) + "°"
    }
    
    func getCeliusMinTemprature() -> String{
        guard let temprature = temp?.min else { return "" }
        return String(TemperatureConverter.kelvinToCelsius(temprature)) + "°"
    }
    
    func getAverageTemprature() -> String{
        guard let _tempratureMax = temp?.max,let _temperatureMin = temp?.min else { return "" }
        let avg = (_tempratureMax + _temperatureMin) / 2
        return String(TemperatureConverter.kelvinToCelsius(avg)) + "°"
    }
    
    func getTempratureRange() -> String{
        return getCeliusMaxTemprature() + "    " +  getCeliusMinTemprature()
    }
    
    func getDay() -> String
    {
        guard let timeStamp = dt else { return "" }
        return String(GeneralUtility.UnixToString(timestamp: timeStamp, format: "EEEE"))
    }
    
    func getHour() -> String
    {
        guard let timeStamp = dt else { return "" }
        return String(GeneralUtility.UnixToString(timestamp: timeStamp, format: "h a"))
    }
}


