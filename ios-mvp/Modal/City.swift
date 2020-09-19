//
//  City.swift
//  ios-mvp
//
//  Created by Ahsan Ali on 14/06/2020.
//  Copyright © 2020 Ahsan Ali. All rights reserved.
//

import Foundation

struct City {
    var id : Int
    var name : String?
    var longitude : Double?
    var latitude : Double?
    
    init(id : Int, name : String?,longitude : Double?,latitude : Double?) {
        self.id = id
        self.name = name
        self.longitude = longitude
        self.latitude = latitude
    }
}
