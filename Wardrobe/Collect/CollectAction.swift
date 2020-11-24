//
//  CollectAction.swift
//  Wardrobe
//
//  Created by 周正飞 on 2020/11/23.
//

import Foundation

enum CollectAction {
    case tapDetailWear(Wear)
    case deleteSelectWear
}

extension Store {
    func reduce(state: AppState, action: CollectAction) -> (AppState, AppCommand?) {
        var state = state
        var command: AppCommand?
        switch action {
        case .tapDetailWear(let wear):
            state.wearList.currentTapedWear = wear
            let removeFromCollect: (String, AppCommand) = (String.removeFromWardrobe, RemoveFromCollectCommand())
            let reuploadImageAction: (String, AppCommand) = (String.reuploadImage, ReuploadImageCommand())
            let markedNeedWash: (String, AppCommand) = (String.markedNeedWash, MarkedNeedWashCommand())
            
            state.wearList.actionSheetData = .init(actions: [removeFromCollect, reuploadImageAction, markedNeedWash], title: .howToHandleThisWear, message: nil)
        }
        return (state, command)
    }
}

private struct ReuploadImageCommand: AppCommand {
    func execute(in store: Store) {
        
    }
}

private struct RemoveFromCollectCommand: AppCommand {
    func execute(in store: Store) {
        
    }
}

private struct MarkedNeedWashCommand: AppCommand {
    func execute(in store: Store) {
        store.dispatch(.collect(.deleteSelectWear))
    }
}
