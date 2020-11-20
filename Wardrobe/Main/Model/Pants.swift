//
//  Pants.swift
//  Wardrobe
//
//  Created by 周正飞 on 2020/11/12.
//

import Foundation
import SwiftUI

extension WearType {
    
    struct Pants: Codable, Wear {
        var text: String { kind.text }
        enum Kind: String, CaseIterable, DetailWearKind, Codable {
            case casual // 休闲裤
            case jeans // 牛仔裤
            case overalls // 工装裤
            case trousers // 束脚裤
            case sweatPants // 运动裤
            
            var text: String {
                switch self {
                case .casual: return .casual
                case .jeans: return .jeans
                case .overalls: return .overalls
                case .trousers: return .trousers
                case .sweatPants: return .sweatPants
                }
            }
            
            init(kind: DetailWearKind) {
                switch kind.text {
                case .casual: self = .casual
                case .jeans: self = .jeans
                case .overalls: self = .overalls
                case .trousers: self = .trousers
                case .sweatPants: self = .sweatPants
                default:
                    fatalError()
                }
            }
        }
        let color: Color
        let kind: Kind
        let imageData: Data
    }
}
