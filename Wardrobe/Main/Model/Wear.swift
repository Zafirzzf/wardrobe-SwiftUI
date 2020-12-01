//
//  WearType.swift
//  Wardrobe
//
//  Created by 周正飞 on 2020/11/10.
//

import Foundation
import SwiftUI

struct Wear: Codable {
    let color: Color
    let imageData: Data
    let wearType: WearType
    let kind: DetailWearKind
}

extension Wear {
    var image: Image {
        Image(uiImage: UIImage(data: imageData) ?? UIImage(systemName: "multiply")!)
    }
    
    func equal(with wear: Wear?) -> Bool {
        wear?.imageData == imageData
    }
}

enum WearType: String, Codable {
    case clothes
    case pants
    case shoes
    
    var viewModel: WearTypeViewModel {
        switch self {
        case .clothes: return .init(icon: Image("clothes"), text: .clothes,
                                    subKinds: DetailWearKind.kinds(of: .clothes))
        case .pants: return .init(icon: Image("pants"), text: .pants,
                                  subKinds: DetailWearKind.kinds(of: .pants))
        case .shoes: return .init(icon: Image("shoes"), text: .shoes,
                                  subKinds: DetailWearKind.kinds(of: .shoes))
        }
    }
}

struct WearTypeViewModel {
    let icon: Image
    let text: String
    let subKinds: [DetailWearKind]
}

enum WearColor {
    case red
    case blue
}

enum WearThickness: String, Codable {
    case thin
    case thick
}
