//
//  State-Collect.swift
//  Wardrobe
//
//  Created by 周正飞 on 2020/11/13.
//

import Foundation

extension AppState {
    struct WearsCollect {
//        
//        @WearStorage(key: "keys", defaultValue: [])
//        var wears: [Wear]
        
        @WearStorage(key: .clothes, defaultValue: [])
        var clothes: [WearType.Clothes]
        
        @WearStorage(key: .pants, defaultValue: [])
        var pants: [WearType.Pants]
        
        @WearStorage(key: .shoes, defaultValue: [])
        var shoes: [WearType.Shoes]
                
        var allEmpty: Bool {
            clothes.isEmpty && pants.isEmpty && shoes.isEmpty
        }
        
        var canNotBeSuit: Bool {
            clothes.isEmpty || pants.isEmpty || shoes.isEmpty
        }
    }
}
