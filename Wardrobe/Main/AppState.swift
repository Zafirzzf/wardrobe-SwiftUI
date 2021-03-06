//
//  AppState.swift
//  Wardrobe
//
//  Created by 周正飞 on 2020/11/10.
//

import Foundation
import SwiftUI

struct AppState {
    var mainTab = MainTab()
    var recommend = Recommend()
    var inputNew = InputNew()
    var wearsState = WearsCollect()
    var weather = WeatherState()
    var wearListState = WearList()
}
 
extension AppState {
    func generateASuit() throws -> WearSuit {
        if wearsState.canNotBeSuit {
            throw GenerateSuitError.clothesNotEnough
        } else {
            guard weather.weather != nil else {
                throw GenerateSuitError.weatherDataError
            }
            let needLining = weather.needLiningClothes
            let clothesTypeEnough = wearsState.clothes.contains { $0.kind.canBeLining } && wearsState.clothes.contains { !$0.kind.canBeLining }
            if needLining, !clothesTypeEnough {
                // 如果温度需要里衬但是没有外套和里衬
                throw GenerateSuitError.clothesTypeNotEnough
            }
            let firstClothes: Wear
            var liningClothes: Wear?
            if needLining {
                firstClothes = wearsState.clothes.filter { !$0.kind.canBeLining }.randomElement()!
                liningClothes = wearsState.clothes.filter { $0.kind.canBeLining }.randomElement()!
            } else {
                firstClothes = wearsState.clothes.randomElement()!
            }
            return WearSuit(clothes: firstClothes,
                     pants: wearsState.pants.randomElement()!,
                     shoes: wearsState.shoes.randomElement()!, lining: liningClothes)
        }
    }
}

enum GenerateSuitError: Error, Identifiable {
    
    var id: String { description }
    case clothesNotEnough
    case weatherDataError
    case clothesTypeNotEnough // 里衬和外套都要有
    
    var description: String {
        switch self {
        case .clothesNotEnough: return .clothesNotEnough
        case .weatherDataError: return .weatherDataError
        case .clothesTypeNotEnough: return .clothesTypeNotEnough
        }
    }
}

