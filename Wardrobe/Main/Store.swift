//
//  Store.swift
//  Wardrobe
//
//  Created by 周正飞 on 2020/11/10.
//

import Foundation
import Combine

class Store: ObservableObject {
    @Published var state = AppState()
    
    init() {
        addObservers()
    }
    
    func addObservers() {
        
    }
    
    func dispatch(_ action: AppTabAction) {
        let result = reduce(state: state, action: action)
        self.state = result.0
        result.1?.execute(in: self)
    }
}

// MARK -- Reducer
extension Store {
    private func reduce(state: AppState, action: AppTabAction) -> (AppState, AppCommand?) {
        var state = state
        var command: AppCommand?
        switch action {
        case .selectTabIndex(let index):
            state.mainTab.selectIndex = index
        case .clickInputToAddButton:
            state.mainTab.showInputModal = true
            state.inputNew = AppState.InputNew()
        }
        return (state, command)
    }
}

