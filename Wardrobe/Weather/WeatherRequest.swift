//
//  WeatherRequest.swift
//  Wardrobe
//
//  Created by 周正飞 on 2020/11/16.
//

import Foundation
import CoreLocation

struct WeatherRequest: Request {
    var path: String = "https://api.seniverse.com/v3/weather/daily.json?"
    var parame: [String : Any] = [:]
    init(coordinate: CLLocationCoordinate2D) {
        parame["key"] = "S2tMmdEIIJtlEKxIc"
        parame["location"] = "\(coordinate.latitude):\(coordinate.longitude)"
        parame["start"] = 1   // 0今天  1明天
        parame["days"] = 1
    }
}
