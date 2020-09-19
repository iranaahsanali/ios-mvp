//
//  GeneralUtility.swift
//  ios-mvp
//
//  Created by Ahsan Ali on 15/06/2020.
//  Copyright © 2020 Ahsan Ali. All rights reserved.
//

import Foundation
import UIKit
import ReachabilitySwift

@objc class GeneralUtility: NSObject {
    
    static func isNetworkAvaliable() -> Bool {
        return Reachability()?.currentReachabilityStatus != .notReachable
    }
    
    // MARK: Error Methods
    static func getError(with message:String?, code: Int?) -> Error {
        return NSError(domain: Constants.AppName, code: code ?? Constants.AppErrorCode, userInfo: [NSLocalizedDescriptionKey: message ?? ""])
    }
    
    static func getError(with message:String?) -> Error {
        return NSError(domain: Constants.AppName, code: Constants.AppErrorCode, userInfo: [NSLocalizedDescriptionKey: message ?? ""])
    }
    
    // MARK: - Date Maniputlation
    static func UnixToString(timestamp : Int,format : String) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
    
    static func DateToString(date : Date,format : String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
}
