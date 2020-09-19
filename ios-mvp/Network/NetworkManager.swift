//
//  NetworkManager.swift
//  ios-mvp
//
//  Created by Ahsan Ali on 15/06/2020.
//  Copyright © 2020 Ahsan Ali. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import ReachabilitySwift

typealias NetworkSuccessBlock = (JSON) -> Void
typealias NetworkFailureBlock = (Error) -> Void

class NetworkManager : ErrorHandlingProtocol {
    
    static let manager: NetworkManager = NetworkManager()
    
    var _headers: HTTPHeaders  = Dictionary<String, String>()
    
    func request(
        endpoint: String,
        method: HTTPMethod,
        headers:JSON?=nil,
        parameters:JSON?=nil,
        success:@escaping (JSON) -> Void,
        failure:@escaping (Error) -> Void) {
        let _ = callAPI(path: endpoint, method: method, parameters: parameters?.dictionaryObject, encodeing: JSONEncoding.default, headers: _headers, success: { (dataResponse) in
            #if targetEnvironment(simulator)
            print("Response \(dataResponse)")
            #endif
            self.handleResponse(dataResponse: dataResponse, success: success, failure: failure)
            
        }) { (error) in
            self.handleFailure(error: error)
            failure(error)
        }
    }
    
    func callAPI (path:String, method:HTTPMethod, parameters:[String:Any]?, encodeing:ParameterEncoding, headers:HTTPHeaders, success:@escaping (DataResponse<Any>) -> Void, failure:@escaping (Error) -> Void) -> DataRequest {
        if (!GeneralUtility.isNetworkAvaliable()) {
            failure(GeneralUtility.getError(with: Constants.ErrorInternetConnection))
        }
        
        let request = SessionManager.default.request(path, method: method, parameters: parameters, encoding: encodeing, headers: headers).responseJSON { response in
            success(response)
        }
        return request
    }
    
    fileprivate func handleResponse(dataResponse:DataResponse<Any>, success:NetworkSuccessBlock, failure:NetworkFailureBlock) {
        
        switch dataResponse.result {
        case .success(let value):
            let json = JSON(value)
            if(json == JSON.null) {
                success(json)
            }
            else {
                success(json)
            }
        case .failure(let error):
            self.handleFailure(error: error)
            failure(error)
        }
    }

    func handleFailure(error: Error?) {
        print(error?.localizedDescription ?? "")
    }
}


protocol ErrorHandlingProtocol {
    func handleFailure(error: Error?)
}
