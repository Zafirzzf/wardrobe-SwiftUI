//
//  View+modifier.swift
//  Wardrobe
//
//  Created by 周正飞 on 2020/11/11.
//

import Foundation
import SwiftUI

struct IconItemModifer: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .frame(width: 26, height: 26)
            .padding(14)
            .foregroundColor(Color.white)
            .background(
                RoundedRectangle(cornerRadius: 27)
                    .fill(Color.mGray)
            )
    }
    
}

extension View {
    func gradientBackground(borderColorWidth: (Color, CGFloat) = (.mGray, 4),
                            backgroundColor: Color = .blue) -> some View {
        background(
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(borderColorWidth.0, style: StrokeStyle(lineWidth: borderColorWidth.1))
                RoundedRectangle(cornerRadius: 8)
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [.white, backgroundColor]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
            }
        )
    }
    @ViewBuilder func isHidden(_ hidden: Bool, remove: Bool = false) -> some View {
        if hidden {
            if !remove {
                self.hidden()
            }
        } else {
            self
        }
    }
}
