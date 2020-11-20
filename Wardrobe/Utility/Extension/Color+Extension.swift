//
//  Color+Extension.swift
//  Wardrobe
//
//  Created by 周正飞 on 2020/11/13.
//

import Foundation
import SwiftUI

extension Color: Codable {
    enum CodingKeys: CodingKey {
        case wrappedColor
    }
    private struct WrappedColor: Codable {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
    }
    
    private var wrappedColor: WrappedColor {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        UIColor(self).getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return WrappedColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    private init(wrappedColor: WrappedColor) {
        self.init(red: Double(wrappedColor.red), green: Double(wrappedColor.green), blue: Double(wrappedColor.blue), opacity: Double(wrappedColor.alpha))
    }
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(wrappedColor, forKey: .wrappedColor)
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let wrappedColor = try container.decode(WrappedColor.self, forKey: .wrappedColor)
        self.init(wrappedColor: wrappedColor)
    }
}
