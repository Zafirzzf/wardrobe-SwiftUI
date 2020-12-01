//
//  State-Collect.swift
//  Wardrobe
//
//  Created by 周正飞 on 2020/11/13.
//

import Foundation

extension AppState {
    struct WearsCollect {
        
        @WearStorage(key: "wears", defaultValue: [])
        var wears: [Wear]
        
        var clothes: [Wear] {
            wears.filter { $0.wearType == .clothes }
        }
        
        var pants: [Wear] {
            wears.filter { $0.wearType == .pants }
        }
        
        var shoes: [Wear] {
            wears.filter { $0.wearType == .shoes }
        }
                
        var allEmpty: Bool {
            clothes.isEmpty && pants.isEmpty && shoes.isEmpty
        }
        
        var canNotBeSuit: Bool {
            clothes.isEmpty || pants.isEmpty || shoes.isEmpty
        }
    }
}
