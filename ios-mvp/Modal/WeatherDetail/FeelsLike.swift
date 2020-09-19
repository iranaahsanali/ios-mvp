//
//  FeelsLike.swift
//  ios-mvp
//
//  Created by Ahsan Ali on 05/09/2020.
//  Copyright © 2020 Ahsan Ali. All rights reserved.
//

import Foundation
import ObjectMapper

struct Feels_like : Mappable {
    var day : Double?
    var night : Double?
    var eve : Double?
    var morn : Double?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        day <- map["day"]
        night <- map["night"]
        eve <- map["eve"]
        morn <- map["morn"]
    }

}
