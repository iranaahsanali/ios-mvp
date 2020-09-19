//
//  WeatherCoordinator.swift
//  ios-mvp
//
//  Created by Ahsan Ali on 15/06/2020.
//  Copyright © 2020 Ahsan Ali. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire

class WeatherCoordinator
{
    func fetchData(latitude : Double,longitude : Double,success:@escaping
        (WeatherDetailResponse) -> Void, failure:@escaping (Error) -> Void)
    {
        let url = "\(Constants.BASE_URL)\(Constants.EndPoints.fetchWeatherData)?appid=\(Constants.API_KEY)&lat=\(latitude)&lon=\(longitude)&exclude=minutely"
        NetworkManager.manager.request(endpoint: url, method: HTTPMethod.get , success: { (json) in
            if let response = Mapper<WeatherDetailResponse>().map(JSON: json.dictionaryObject!){
                success(response)
            }
        }) { (error) in
            failure(error)
        }
    }
}
