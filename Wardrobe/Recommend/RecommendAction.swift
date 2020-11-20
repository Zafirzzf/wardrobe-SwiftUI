//
//  RecommendAction.swift
//  Wardrobe
//
//  Created by 周正飞 on 2020/11/20.
//

import Foundation

enum AppRecommendAction {
    case beginSelectSuit
    case recommendSuitViewAppear
    case recommendSuitViewDisappear
}

extension Store {
    func reduce(state: AppState, action: AppRecommendAction) -> (AppState, AppCommand?) {
        var state = state
        var command: AppCommand?
        switch action {
        case .beginSelectSuit:
            state.recommend.showSelectSuitType = true
            do {
                let suit = try state.generateASuit()
                state.recommend.recommendSuit = suit
            } catch {
                state.recommend.recommendSuitError = error as? GenerateSuitError
            }
        case .recommendSuitViewAppear:
            state.recommend.recommendSuitShown = true
        case .recommendSuitViewDisappear:
            state.recommend.recommendSuitShown = false
        }
        return (state, command)
    }
}
