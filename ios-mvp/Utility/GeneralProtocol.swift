//
//  GeneralProtocol.swift
//  ios-mvp
//
//  Created by Ahsan Ali on 16/06/2020.
//  Copyright © 2020 Ahsan Ali. All rights reserved.
//

import Foundation

protocol GenericProtocol : NSObjectProtocol {
    func fetchingData()
    func dataFetched()
    func handleError(error : Error)
}
