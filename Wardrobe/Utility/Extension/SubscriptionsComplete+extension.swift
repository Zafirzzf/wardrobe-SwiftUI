//
//  SubscriptionsComplete+extension.swift
//  Wardrobe
//
//  Created by 周正飞 on 2020/11/18.
//

import Foundation
import Combine

extension Subscribers.Completion {
    var error: Error? {
        switch self {
        case .finished:
            return nil
        case .failure(let error):
        return error
        }
    }
}
