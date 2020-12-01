//
//  AppInputAction.swift
//  Wardrobe
//
//  Created by 周正飞 on 2020/11/11.
//

import Foundation

enum AppInputAction {
    case clickBack
    case selectWearType(type: WearType)
    case selectWearAnimationFinish
    case selectDetailWearKind(kind: DetailWearKind)
    case selectUploadImageType(type: AppState.InputNew.UploadImageType)
    case clickWearImage
    case clickFinish
}

extension Store {
    
    func reduce(state: AppState, action: AppInputAction) -> (AppState, AppCommand?) {
        var state = state
        var command: AppCommand?
        switch action {
        case .selectWearType(let type):
            state.inputNew.wearType = type
            command = SelectWearTypeAnimationCommand()
        case .selectWearAnimationFinish:
            state.inputNew.hasBeginSelectDetailKind = true
        case .clickBack:
            if state.inputNew.wearType == nil {
                state.mainTab.showInputModal = false
            } else {
                state.inputNew.wearType = nil
                state.inputNew.detailWearKind = nil
                state.inputNew.wearImage = nil
                state.inputNew.hasBeginSelectDetailKind = false
                state.inputNew.showUploadImageSelectView = false
            }
        case .selectDetailWearKind(let kind):
            state.inputNew.detailWearKind = kind
            state.inputNew.showUploadImageSelectView = true
        case .clickWearImage:
            state.inputNew.showImageUploadView = true
        case .clickFinish:
            let color = state.inputNew.color
            let imageData = state.inputNew.wearImage?.jpegData(compressionQuality: 1) ?? Data()
            switch state.inputNew.wearType! {
            case .clothes:
                state.wears.clothes.append(
                    WearType.Clothes(color: color, kind: .init(kind: state.inputNew.detailWearKind!),
                                     imageData: imageData)
                )
            case .pants:
                state.wears.pants.append(
                    WearType.Pants(color: color, kind: .init(kind: state.inputNew.detailWearKind!),
                                   imageData: imageData)
                )
            case .shoes:
                state.wears.shoes.append(
                    WearType.Shoes(color: color, kind: .init(kind: state.inputNew.detailWearKind!),
                                   imageData: imageData)
                )
            }
            state.mainTab.showInputModal = false
            state.mainTab.selectIndex = .collect
        case .selectUploadImageType(let type):
            state.inputNew.uploadImageType = type
            state.inputNew.showImageUploadView = true
        }
        return (state, command)
    }
}

private struct SelectWearTypeAnimationCommand: AppCommand {
    func execute(in store: Store) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
            store.dispatch(.input(.selectWearAnimationFinish))
        }
    }
    
    
}
