//
//  Clothes.swift
//  Wardrobe
//
//  Created by 周正飞 on 2020/11/12.
//

import Foundation
import SwiftUI

extension WearType {
    struct Clothes: Codable, Wear {
        var text: String { kind.text }
        
        enum Kind: String, CaseIterable, DetailWearKind, Codable {
            case tShirt // T恤
            case shirt // 衬衫
            case sweater // 卫衣
            case jacket // 夹克
            case woolenCoat // 呢子大衣
            case downJacket // 羽绒服
            
            // 可以作为里衬
            var canBeLining: Bool {
                switch self {
                case .tShirt, .shirt, .sweater:
                    return true
                case .jacket, .woolenCoat, .downJacket:
                    return false
                }
            }
            
            var text: String {
                switch self {
                case .tShirt: return .tShirt
                case .shirt: return .shirt
                case .sweater: return .sweater
                case .jacket: return .jacket
                case .woolenCoat: return .woolenCoat
                case .downJacket: return .downJacket
                }
            }
            init(kind: DetailWearKind) {
                switch kind.text {
                case .tShirt: self = .tShirt
                case .shirt: self = .shirt
                case .sweater: self = .sweater
                case .jacket: self = .jacket
                case .woolenCoat: self = .woolenCoat
                case .downJacket: self = .downJacket
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

