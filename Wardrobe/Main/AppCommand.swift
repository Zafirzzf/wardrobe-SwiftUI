//
//  AppCommand.swift
//  Wardrobe
//
//  Created by 周正飞 on 2020/11/10.
//

import Foundation

protocol AppCommand {
    func execute(in store: Store)
}
