//
//  Sequence+Extension.swift
//  Wardrobe
//
//  Created by 周正飞 on 2020/11/24.
//

import Foundation

extension Array {
    mutating func removeFirst(where condition: (Element) -> Bool) {
        if let index = firstIndex(where: condition) {
            remove(at: index)
        }
    }
}
