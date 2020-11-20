//
//  WeatherAction.swift
//  Wardrobe
//
//  Created by 周正飞 on 2020/11/18.
//

import Foundation

enum WeatherAction {
    case startLoadWeatherData
    case finishLoadWeatherData
    case loadWeatherDataError(Error)
    case loadWeatherData(Weather)
    
}

extension Store {
    func dispatchWeatherAction(_ action: WeatherAction) {
        let result = reduce(state: state, action: action)
        self.state = result.0
        result.1?.execute(in: self)
    }
    
    private func reduce(state: AppState, action: WeatherAction) -> (AppState, AppCommand?) {
        var state = state
        var command: AppCommand?
        switch action {
        case .startLoadWeatherData:
            state.weather.isLoadingData = true
            command = WeatherLoadCommand()
        case .finishLoadWeatherData:
            state.weather.isLoadingData = false
        case .loadWeatherDataError(let error):
            switch error {
            case LocationError.noPermission:
                state.weather.noLocationPermission = true
            default:
                break
            }
        case .loadWeatherData(let weather):
            state.weather.weather = weather
        }
        return (state, command)
    }
}
