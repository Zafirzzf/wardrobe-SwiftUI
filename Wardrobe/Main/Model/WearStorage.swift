//
//  DataStorager.swift
//  Wardrobe
//
//  Created by 周正飞 on 2020/11/13.
//

import Foundation

@propertyWrapper
struct WearStorage<Value: Codable> {
    typealias Key = String
    var wrappedValue: Value {
        get {
            value
        }
        set {
            value = newValue
            if let encodeData = try? JSONEncoder().encode(newValue) {
                UserDefaults.standard.setValue(encodeData, forKey: key)
            } else {
                UserDefaults.standard.removeObject(forKey: key)
            }
        }
    }
    private let key: Key
    private var value: Value
    
    init(key: Key, defaultValue: Value) {
        self.key = key
        self.value = (UserDefaults.standard.object(forKey: key) as? Data)
            .flatMap { try? JSONDecoder().decode(Value.self, from: $0) } ?? defaultValue
    }
}

extension WearStorage where Value: ExpressibleByNilLiteral {
    init(key: Key) {
        self.key = key
        self.value = (UserDefaults.standard.object(forKey: key) as? Data)
            .flatMap { try? JSONDecoder().decode(Value.self, from: $0) } ?? nil
    }
}
