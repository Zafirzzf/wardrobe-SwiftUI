//
//  WardrobeApp.swift
//  Wardrobe
//
//  Created by 周正飞 on 2020/11/10.
//

import SwiftUI

@main
struct WardrobeApp: App {
    var body: some Scene {
        WindowGroup {
            MainTab().environmentObject(Store.shared)
        }
    }
}
