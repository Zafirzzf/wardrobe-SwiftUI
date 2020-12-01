//
//  DetailWearKind.swift
//  Wardrobe
//
//  Created by 周正飞 on 2020/11/13.
//

import Foundation

struct DetailWearKind: Codable {
    let text: String
    let thickness: WearThickness
    
    var canBeLining: Bool {
        thickness == .thin
    }
    
    static func kinds(of wearType: WearType) -> [DetailWearKind] {
        switch wearType {
        case .clothes:
            return [.init(text: .tShirt, thickness: .thin),
                    .init(text: .shirt, thickness: .thin),
                    .init(text: .sweater, thickness: .thin),
                    .init(text: .jacket, thickness: .thin),
                    .init(text: .woolenCoat, thickness: .thick),
                    .init(text: .downJacket, thickness: .thick)
                ]
        case .pants:
            return [.init(text: .casual, thickness: .thin),
                    .init(text: .jeans, thickness: .thin),
                    .init(text: .overalls, thickness: .thin),
                    .init(text: .trousers, thickness: .thin),
                    .init(text: .sweatPants, thickness: .thin)
            ]
        case .shoes:
            return [.init(text: .snearkers, thickness: .thin),
                    .init(text: .daddy, thickness: .thin),
                    .init(text: .sports, thickness: .thin),
                    .init(text: .martin, thickness: .thick),
                    .init(text: .catton, thickness: .thick),
                    .init(text: .canvas, thickness: .thin)
            ]
        }
    }
}
