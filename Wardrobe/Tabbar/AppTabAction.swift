//
//  AppAction.swift
//  Wardrobe
//
//  Created by 周正飞 on 2020/11/10.
//

import Foundation

enum AppTabAction {
    case selectTabIndex(index: AppState.MainTab.Index)
    case clickInputToAddButton
}

extension Store {
    func reduce(state: AppState, action: AppTabAction) -> (AppState, AppCommand?) {
        var state = state
        switch action {
        case .selectTabIndex(let index):
            state.mainTab.selectIndex = index
        case .clickInputToAddButton:
            state.mainTab.showInputModal = true
            state.inputNew = AppState.InputNew()
        }
        return (state, nil)
    }
}
