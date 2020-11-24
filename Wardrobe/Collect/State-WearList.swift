//
//  State-WearList.swift
//  Wardrobe
//
//  Created by 周正飞 on 2020/11/23.
//

import Foundation
import SwiftUI

extension AppState {
    struct WearList {
        var currentTapedWear: Wear?
        var actionSheetData: ActionSheetData? {
            didSet {
                if actionSheetData == nil {
                    currentTapedWear = nil
                }
            }
        }
    }
}

struct ActionSheetData: Identifiable {
    var id: String { title }
    
    let actions: [(String, AppCommand)]
    let title: String
    let message: String?
}
