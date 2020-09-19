//
//  HourlyWeatherCollectionViewCell.swift
//  ios-mvp
//
//  Created by Ahsan Ali on 15/06/2020.
//  Copyright © 2020 Ahsan Ali. All rights reserved.
//

import UIKit

class HourlyWeatherCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var labelTime: UILabel!
    @IBOutlet weak var labelWeatherIcon: UILabel!
    @IBOutlet weak var labelDescriptor: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setupCell(weather : Hourly?)
    {
        if let weather = weather{
            labelTime.text = weather.getHour()
            labelDescriptor.text = weather.getTemprature()
            labelWeatherIcon.text = ""
            if let weatherData = weather.weather?.first {
                labelWeatherIcon.text = WeatherIcons.setActivityIcon(type: weatherData.icon ?? "")
            }
        }
    }
}
