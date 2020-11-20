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
    var inputNew = InputNew()
    var collect = Collect()
    var weather = WeatherState()
}

extension AppState {
    struct MainTab {
        enum Index {
            case recommend
            case collect
            
            var image: Image {
                switch self {
                case .recommend:
                    return Image(systemName: "flame")
                case .collect:
                    return Image(systemName: "tray")
                }
            }
            
            @ViewBuilder var content: some View {
                if self == .recommend {
                    RecommendListView()
                        .navigationTitle(.recommend)
                } else {
                    CollectRootView()
                        .navigationTitle(.collect)
                }
            }
        }
        var showInputModal = false
        var selectIndex = Index.recommend
    }
    
}
