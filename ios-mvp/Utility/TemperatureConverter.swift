//
//  TempratureConversion.swift
//  ios-mvp
//
//  Created by Ahsan Ali on 16/06/2020.
//  Copyright © 2020 Ahsan Ali. All rights reserved.
//

import Foundation

struct TemperatureConverter {
  static func kelvinToCelsius(_ kelvin: Double) -> Int {
    return Int(round(kelvin - 273.15))
  }
}
