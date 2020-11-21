//
//  State-MainTab.swift
//  Wardrobe
//
//  Created by 周正飞 on 2020/11/20.
//

import Foundation
import SwiftUI

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
