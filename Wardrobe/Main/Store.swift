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
    
    func dispatch(_ action: AppAction) {
        let result = reduce(state: state, action: action)
        self.state = result.0
        result.1?.execute(in: self)
    }
}

enum AppAction {
    case mainTab(AppTabAction)
    case recommend(AppRecommendAction)
    case input(AppInputAction)
//    case collect(CollectAction)
}

// MARK -- Reducer
extension Store {
    private func reduce(state: AppState, action: AppAction) -> (AppState, AppCommand?) {
        switch action {
        case .input(let inputAction):
            return reduce(state: state, action: inputAction)
        case .recommend(let recommendAction):
            return reduce(state: state, action: recommendAction)
        case .mainTab(let mainTabAction):
            return reduce(state: state, action: mainTabAction)
        }
        
    }
}

