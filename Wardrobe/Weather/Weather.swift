//
//  Weather.swift
//  Wardrobe
//
//  Created by 周正飞 on 2020/11/16.
//

import Foundation

struct WeatherResults: Decodable {
    let results: [Weather]
}

struct Weather: Decodable {
    typealias TemperatureRange = (Int, Int)
    struct Location: Decodable {
        let name: String
    }
    struct Detail: Decodable {
        let text_day: String
        let high: String
        let low: String
        let wind_scale: String
    }
    let location: Location
    let daily: [Detail]
    
    var tomorrow: Detail? {
        daily.first
    }
    
    var temperatureRange: TemperatureRange? {
        if let tomorrow = tomorrow {
            return (Int(tomorrow.low)!, Int(tomorrow.high)!)
        } else {
            return nil
        }
    }
}
