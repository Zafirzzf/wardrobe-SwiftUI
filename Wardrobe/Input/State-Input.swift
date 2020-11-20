//
//  InputState.swift
//  Wardrobe
//
//  Created by 周正飞 on 2020/11/10.
//

import Foundation
import SwiftUI

extension AppState {
    
    func addInputNewObservers() {
        
    }
    
    struct InputNew {
        enum UploadImageType {
            case library
            case camera
        }
        var color = Color.clear
        var wearType: WearType?
        var detailWearKind: DetailWearKind?
        
        var wearImage: UIImage?
        var hasBeginSelectDetailKind: Bool = false // 在选择大类动画完毕后
        var showUploadImageSelectView = false
        var uploadImageType: UploadImageType?
        var showImageUploadView = false
        
        var unSelectColor: Bool { color == .clear }
        
        var hasSelWearType: Bool { // 为true时执行未选择类别的消失动画
            wearType != nil
        }
        var canPopPage: Bool {
            wearType != nil
        }
        var allFinished: Bool {
            wearType != nil && detailWearKind != nil && wearImage != nil && !unSelectColor
        }
        
        func isSelectedWearType(_ wearType: WearType) -> Bool {
            self.wearType == wearType
        }
    }
}
