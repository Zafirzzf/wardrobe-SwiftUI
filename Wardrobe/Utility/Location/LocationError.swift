//
//  LocationError.swift
//  Aloha
//
//  Created by 周正飞 on 2019/4/8.
//  Copyright © 2019 Cuapp. All rights reserved.
//

import Foundation
import CoreLocation

enum LocationError: Error {
    case noPermission
    case timeout
    case clError(CLError)
    case unknown
    
    var isNoPermission: Bool {
        switch self {
        case .noPermission:
            return true
        default:
            return false
        }
    }
    
    var stringValue: String {
        switch self {
        case .noPermission:
            return "没有开启权限"
        case .timeout:
            return "超时"
        case .clError(let error):
            return error.stringValue
        case .unknown:
            return "未知"
        }
    }
}

extension CLError {
    var stringValue: String {
        return "CLErrorCode: \(self.code.rawValue)"
    }
}
