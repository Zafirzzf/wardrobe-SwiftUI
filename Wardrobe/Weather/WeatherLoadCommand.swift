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
        
        switch LocationManager.shared.authStatus.value {
        case .notDetermined:
            let subscription = SubscriptionToken()
            LocationManager.shared.authStatus
                .removeDuplicates()
                .dropFirst().first()
                .sink { _ in
                    execute(in: store)
                    subscription.unseal()
                }.seal(in: subscription)
            LocationManager.shared.requestPermissionIfNeed()
        case .authorizedWhenInUse:
            let token = SubscriptionToken()
            LocationManager.shared.getNewestCoordinate()
                .flatMap { coordinate -> Future<WeatherResults, Error> in
                    WeatherRequest(coordinate: coordinate).requestModel(WeatherResults.self)
                }.sink { complete in
                    token.unseal()
                    store.dispatchWeatherAction(.finishLoadWeatherData)
                    if let error = complete.error {
                        store.dispatchWeatherAction(.loadWeatherDataError(error))
                    }
                } receiveValue: { results in
                    store.dispatchWeatherAction(.loadWeatherData(results.results[0]))
                }.seal(in: token)
        default:
            store.dispatchWeatherAction(.loadWeatherDataError(LocationError.noPermission))
            store.dispatchWeatherAction(.finishLoadWeatherData)
        }
    }
}
