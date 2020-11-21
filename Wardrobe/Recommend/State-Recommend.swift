//
//  State-Recommend.swift
//  Wardrobe
//
//  Created by 周正飞 on 2020/11/20.
//

import Foundation

extension AppState {
    struct Recommend {
        enum SelectSuitType {
            case auto
            case manual
        }
        
        @WearStorage(key: "tomorrowSuit")
        var tomorrowSuit: WearSuit?
        
        var showSelectSuitType = false
        
        struct SuitGenerate {
            // 套装生成Sheet
            var recommendSuitError: GenerateSuitError?
            var recommendSuit: WearSuit?
            var recommendSuitSetFinish = false
            
            var hasRecommendSuit: Bool {
                recommendSuit != nil
            }
        }
        var suitGenerate = SuitGenerate()
        
        struct ManualSelSuit {
            var lining: WearType.Clothes?
            var clothes: WearType.Clothes?
            var pants: WearType.Pants?
            var shoes: WearType.Shoes?
        }
    }
}

struct WearSuit: Codable {
    let clothes: WearType.Clothes
    let pants: WearType.Pants
    let shoes: WearType.Shoes
    var lining: WearType.Clothes? // 里衬
}
