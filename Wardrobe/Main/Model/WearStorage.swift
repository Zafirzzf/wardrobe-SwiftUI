//
//  DataStorager.swift
//  Wardrobe
//
//  Created by 周正飞 on 2020/11/13.
//

import Foundation

@propertyWrapper
struct WearStorage<Value: Codable> {
    
    var values: [Value] = []
    var wrappedValue: [Value] {
        get {
            values
        }
        set {
            values = newValue
            if let encodeData = try? JSONEncoder().encode(newValue) {
                UserDefaults.standard.setValue(encodeData, forKey: wearType.viewModel.text)
            } else {
                UserDefaults.standard.removeObject(forKey: wearType.viewModel.text)
            }
        }
    }
    private let wearType: WearType
    
    init(wearType: WearType) {
        self.wearType = wearType
        self.values = (UserDefaults.standard.object(forKey: wearType.viewModel.text) as? Data)
            .flatMap { try? JSONDecoder().decode([Value].self, from: $0) } ?? []
    }
}
