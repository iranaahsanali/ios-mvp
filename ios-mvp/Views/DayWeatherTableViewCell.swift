//
//  DayWeatherTableViewCell.swift
//  ios-mvp
//
//  Created by Ahsan Ali on 15/06/2020.
//  Copyright © 2020 Ahsan Ali. All rights reserved.
//

import UIKit

class DayWeatherTableViewCell: UITableViewCell {

    @IBOutlet weak var labelDay: UILabel!
    @IBOutlet weak var labelTempratures: UILabel!
    @IBOutlet weak var labelWeatherIcon: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setupCell(weather : Daily?)
    {
        if let dailyData = weather{
            self.labelDay.text = dailyData.getDay()
            self.labelWeatherIcon.text = WeatherIcons.setActivityIcon(type: dailyData.weather?.first?.icon ?? "")
            self.labelTempratures.text = dailyData.getTempratureRange()
        }
    }
}
