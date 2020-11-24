//
//  LocalizedString.swift
//  Wardrobe
//
//  Created by 周正飞 on 2020/11/11.
//

import Foundation
import SwiftUI

extension String {
    typealias StringType = String
    static var tShirt: StringType { "T恤" }
    static var shirt: StringType { "衬衫" }
    static var sweater: StringType { "卫衣" }
    static var jacket: StringType { "夹克" }
    static var woolenCoat: StringType { "呢子大衣" }
    static var downJacket: StringType { "羽绒服" }
    static var casual: StringType { "休闲裤" }
    static var jeans: StringType { "牛仔裤" }
    static var overalls: StringType { "工装裤" }
    static var trousers: StringType { "束脚裤" }
    static var sweatPants: StringType { "运动裤" }
    static var snearkers: StringType { "板鞋" }
    static var daddy: StringType { "老爹鞋" }
    static var sports: StringType { "运动鞋" }
    static var martin: StringType { "马丁鞋" }
    static var catton: StringType { "棉鞋" }
    static var canvas: StringType { "帆布鞋" }
    static var clothes: StringType { "衣服" }
    static var pants: StringType { "裤子" }
    static var shoes: StringType { "鞋子" }
    static var clothesNotEnough: StringType { "衣服添加不足，无法凑成一套" }
    static var weatherDataError: StringType { "天气信息获取失败，无法推荐" }
    static var clothesTypeNotEnough: StringType { "衣服种类添加不足，里衬和外套都要有" }
    static var reuploadImage: StringType { "重新上传图片" }
    static var markedNeedWash: StringType { "标记为脏了" }
    static var removeFromWardrobe: StringType { "从衣柜移除" }
    static var howToHandleThisWear: StringType { "对此件服饰进行操作" }
}

extension LocalizedStringKey {
    
    static var recommend: LocalizedStringKey { "推荐" }
    static var collect: LocalizedStringKey { "衣柜" }
    static var selectColorTip: LocalizedStringKey { "选个颜色吧(*^▽^*)" }
    static var finish: LocalizedStringKey { "完成" }
    static var tomorrow: LocalizedStringKey { "明天" }
    static var wardrobeEmptyTip: LocalizedStringKey { "衣柜空空如也~" }
    static var tomorrowWearWhat: LocalizedStringKey { "明天穿什么?" }
    static var tomorrowWearThis: LocalizedStringKey { "明天穿这些" }
    static var reselect: LocalizedStringKey { "重新选择" }
    static var reRecommend: LocalizedStringKey { "重新推荐" }
    static var manualSelect: LocalizedStringKey { "手动搭配" }
    static var thisSuitBingo: LocalizedStringKey { "就这身了!" }
    static var gotoSelect: LocalizedStringKey { "去选择" }

    static func weatherInfo(high: String, low: String) -> LocalizedStringKey {
        return "最高\(high)° 最低\(low)°"
    }
}
