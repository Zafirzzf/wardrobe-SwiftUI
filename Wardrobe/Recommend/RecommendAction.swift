//
//  RecommendAction.swift
//  Wardrobe
//
//  Created by 周正飞 on 2020/11/20.
//

import Foundation

enum AppRecommendAction {
    case beginSelectSuit
    case generateSuit
    case generateSuitDataFinishSet
    case recommendSuitViewDisappear
    case reRecommendSuit
    case manualSelectSuit
    case confirmTheSuit
}

extension Store {
    
    private func clearRecommendSuitView(state: AppState) -> AppState {
        var state = state
        state.recommend.suitGenerate = .init()
        return state
    }
    
    func reduce(state: AppState, action: AppRecommendAction) -> (AppState, AppCommand?) {
        var state = state
        var command: AppCommand?
        switch action {
        case .beginSelectSuit:
            state.recommend.showSelectSuitType = true
            command = GenerateSuitCommand()
        case .generateSuit:
            do {
                let suit = try state.generateASuit()
                state.recommend.suitGenerate.recommendSuit = suit
            } catch {
                state.recommend.suitGenerate.recommendSuitError = error as? GenerateSuitError
            }
            command = SuitDataSetFinishCommand()
        case .generateSuitDataFinishSet:
            state.recommend.suitGenerate.recommendSuitSetFinish = true
        case .recommendSuitViewDisappear:
            state.recommend.suitGenerate = .init()
        case .reRecommendSuit:
            state.recommend.suitGenerate.recommendSuit = nil
            state.recommend.suitGenerate.recommendSuitSetFinish = false
            command = GenerateSuitCommand()
        case .manualSelectSuit:
            break
        case .confirmTheSuit:
            state.recommend.tomorrowSuit = state.recommend.suitGenerate.recommendSuit
            state.recommend.showSelectSuitType = false
        }
        return (state, command)
    }
}

private struct GenerateSuitCommand: AppCommand {
    func execute(in store: Store) {
        store.dispatch(.recommend(.generateSuit))
    }
}

private struct SuitDataSetFinishCommand: AppCommand {
    func execute(in store: Store) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            store.dispatch(.recommend(.generateSuitDataFinishSet))
        }
    }
}
