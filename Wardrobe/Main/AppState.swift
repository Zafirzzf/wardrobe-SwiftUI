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
    var clothes = ClothesCollect()
    var weather = WeatherState()
}

extension AppState {
    func generateASuit() throws -> WearSuit {
        if clothes.canNotBeSuit {
            throw GenerateSuitError.clothesNotEnough
        } else {
            guard let range = weather.temperatureRange else {
                throw GenerateSuitError.weatherDataError
            }
            let needLining = range.0 < 5 // 温度低于5度就需要里衬
            let clothesTypeEnough = clothes.clothes.contains { $0.kind.canBeLining } && clothes.clothes.contains { !$0.kind.canBeLining }
            if needLining, !clothesTypeEnough {
                // 如果温度需要里衬但是没有外套和里衬
                throw GenerateSuitError.clothesTypeNotEnough
            }
            let firstClothes: WearType.Clothes
            var liningClothes: WearType.Clothes?
            if needLining {
                firstClothes = clothes.clothes.filter { !$0.kind.canBeLining }.randomElement()!
                liningClothes = clothes.clothes.filter { $0.kind.canBeLining }.randomElement()!
            } else {
                firstClothes = clothes.clothes.randomElement()!
            }
            return WearSuit(clothes: firstClothes,
                     pants: clothes.pants.randomElement()!,
                     shoes: clothes.shoes.randomElement()!, lining: liningClothes)
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

