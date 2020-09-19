//
//  WeatherDetailResponse.swift
//  ios-mvp
//
//  Created by Ahsan Ali on 15/06/2020.
//  Copyright © 2020 Ahsan Ali. All rights reserved.
//

import Foundation
import ObjectMapper

struct WeatherDetailResponse : Mappable {
    var lat : Double?
    var lon : Double?
    var timezone : String?
    var timezone_offset : Int?
    var currently : Currently?
    var hourly : [Hourly]?
    var daily : [Daily]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        lat <- map["lat"]
        lon <- map["lon"]
        timezone <- map["timezone"]
        timezone_offset <- map["timezone_offset"]
        currently <- map["current"]
        hourly <- map["hourly"]
        daily <- map["daily"]
    }

}


extension WeatherDetailResponse
{
    func getTempratureRange() -> String
    {
        let tempratures = hourly?.map {
            return $0.temp
        }
        guard let tempratureArray = tempratures else { return "" }
        
        guard let max = tempratureArray.max(by: { $0 ?? 0 < $1 ?? 0}), let min = tempratureArray.min(by: {$0 ?? 0 < $1 ?? 0}) else { return "" }
        return String(TemperatureConverter.kelvinToCelsius(max!)) + "    " + String(TemperatureConverter.kelvinToCelsius(min!))
    }
}


