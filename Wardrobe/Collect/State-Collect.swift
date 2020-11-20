//
//  State-Collect.swift
//  Wardrobe
//
//  Created by 周正飞 on 2020/11/13.
//

import Foundation

extension AppState {
    struct Collect {
        @WearStorage(wearType: .clothes)
        var clothes: [WearType.Clothes]
        
        @WearStorage(wearType: .pants)
        var pants: [WearType.Pants]
        
        @WearStorage(wearType: .shoes)
        var shoes: [WearType.Shoes]
        
        var allEmpty: Bool {
            clothes.isEmpty && pants.isEmpty && shoes.isEmpty
        }
    }
}
