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
    case detailListShown([Wear])
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
        case .deleteSelectWear:
            state.wears.clothes.removeFirst(where: { $0.equal(with: state.wearList.currentTapedWear) })
            state.wearList.wears.removeFirst(where: { $0.equal(with: state.wearList.currentTapedWear) })
            state.wearList.currentTapedWear = nil
        case .detailListShown(let wears):
            state.wearList.wears = wears
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
        store.dispatch(.collect(.deleteSelectWear))
    }
}

private struct MarkedNeedWashCommand: AppCommand {
    func execute(in store: Store) {
        
    }
}
