//
//  WearType.swift
//  Wardrobe
//
//  Created by 周正飞 on 2020/11/10.
//

import Foundation
import SwiftUI

let testWear: [Wear] = Array(repeating: WearType.Clothes.init(color: .red, kind: .downJacket, imageData: UIImage(systemName: "plus")!.jpegData(compressionQuality: 1)!), count: 10)

protocol Wear {
    var color: Color { get }
    var text: String { get }
    var imageData: Data { get }
}

extension Wear {
    var image: Image {
        Image(uiImage: UIImage(data: imageData) ?? UIImage(systemName: "multiply")!)
    }
    
    func equal(with wear: Wear?) -> Bool {
        wear?.imageData == imageData
    }
}

enum WearType: CaseIterable {
    case clothes
    case pants
    case shoes
    
    var viewModel: WearTypeViewModel {
        switch self {
        case .clothes: return .init(icon: Image("clothes"), text: .clothes,
                                    subKinds: WearType.Clothes.Kind.allCases)
        case .pants: return .init(icon: Image("pants"), text: .pants,
                                  subKinds: WearType.Pants.Kind.allCases)
        case .shoes: return .init(icon: Image("shoes"), text: .shoes,
                                  subKinds: WearType.Shoes.Kind.allCases)
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

enum WearThickness {
    case thin
    case thick
}
