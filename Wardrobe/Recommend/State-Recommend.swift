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
        var selectSuit: WearSuit?
        
        var showSelectSuitType = false
        var recommendSuitError: GenerateSuitError?
        var recommendSuit: WearSuit?
        var recommendSuitShown = false
    }
}

struct WearSuit {
    let clothes: WearType.Clothes
    let pants: WearType.Pants
    let shoes: WearType.Shoes
    var lining: WearType.Clothes? // 里衬
}
