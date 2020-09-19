//
//  WeatherIcons.swift
//  ios-mvp
//
//  Created by Ahsan Ali on 16/06/2020.
//  Copyright © 2020 Ahsan Ali. All rights reserved.
//

import Foundation

struct WeatherIcons {
    
   static func setActivityIcon(type : String) -> String
   {
       switch type {
       case "01d":
           return "sun"
       case "01n":
            return "moon"
       case "02d","03d","04d":
            return "cloud-sun"
       case "02n","03n","04n":
            return "cloud-moon"
       case "13d","13n":
            return "snowflake"
       case "09d","09n","10d","10n":
            return "cloud-rain"
        case "11d","11n":
            return "poo-storm"
        case "50d","50n":
            return "smog"
       default:
           return ""
       }
   }
}
