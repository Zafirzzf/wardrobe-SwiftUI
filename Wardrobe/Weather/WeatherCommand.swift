//
//  WeatherCommand.swift
//  Wardrobe
//
//  Created by 周正飞 on 2020/11/18.
//

import Foundation
import Combine

struct WeatherLoadCommand: AppCommand {
    func execute(in store: Store) {
        LocationManager.shared.requestPermissionIfNeed()
        guard LocationManager.shared.authStatus.value == .authorizedWhenInUse else {
            store
//            noLocationPermission = true
            return
        }
        store.dispatchWeatherAction(.startLoadWeatherData)
        let token = SubscriptionToken()
        LocationManager.shared.getNewestCoordinate()
            .flatMap { coordinate -> Future<Weather, Error> in
                WeatherRequest(coordinate: coordinate).requestModel(Weather.self)
            }.sink { complete in
                token.unseal()
                self.store.dispatchWeatherAction(.finishLoadWeatherData)
                if let error = complete.error {
                    self.store.dispatchWeatherAction(.loadWeatherDataError(error))
                }
            } receiveValue: { weather in
                self.store.dispatchWeatherAction(.loadWeatherData(weather))
            }
            .seal(in: token)
    }
}
