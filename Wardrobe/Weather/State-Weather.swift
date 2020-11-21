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
    
    var temperatureRange: Weather.TemperatureRange? {
        return weather?.temperatureRange
    }
    
    var needLiningClothes: Bool {
        temperatureRange.map {
            $0.0 < 5 // 温度低于5度就需要里衬
        } ?? false
    }
    
}
