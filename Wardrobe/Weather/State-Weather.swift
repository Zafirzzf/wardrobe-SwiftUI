//
//  State-Weather.swift
//  Wardrobe
//
//  Created by 周正飞 on 2020/11/18.
//

import Foundation
import Combine

struct WeatherState {
    
    var isLoadingData = true
    var noLocationPermission = false
    var weather: Weather? = Weather(location: .init(name: "海淀区"), daily: [.init(text_day: "多云", high: "39", low: "-9", wind_scale: "a")])
    
}
