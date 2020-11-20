//
//  Shoes.swift
//  Wardrobe
//
//  Created by 周正飞 on 2020/11/12.
//

import Foundation
import SwiftUI

extension WearType {
    struct Shoes: Codable, Wear {
        var text: String { kind.text }
        enum Kind: String, CaseIterable, DetailWearKind, Codable {
            case snearkers  // 板鞋
            case daddy // 老爹鞋
            case sports // 运动鞋
            case martin // 马丁靴
            case catton // 棉鞋
            case canvas // 帆布鞋
            
            var text: String {
                switch self {
                case .snearkers: return .snearkers
                case .daddy: return .daddy
                case .sports: return .sports
                case .martin: return .martin
                case .catton: return .catton
                case .canvas: return .canvas
                }
            }
            
            init(kind: DetailWearKind) {
                switch kind.text {
                case .snearkers: self = .snearkers
                case .daddy: self = .daddy
                case .sports: self = .sports
                case .martin: self = .martin
                case .catton: self = .catton
                case .canvas: self = .canvas
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
