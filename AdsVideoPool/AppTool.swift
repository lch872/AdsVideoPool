//
//  AppTool.swift
//  AdsVideoPool
//
//  Created by lch on 2018/3/21.
//  Copyright © 2018年 ONEWAY. All rights reserved.
//

import UIKit

let SCREEN_WIDTH = UIScreen.main.bounds.width
let SCREEN_HEIGHT = UIScreen.main.bounds.height
var JSON = [[
    "tag":"游戏推荐",
    "title":"勇闯迷宫，拯救公主",
    "videoName":"2.mp4",
    "detail":"进入《Crypt of the NecroDancer》的动感冒险",
    "width":"1280",
    "height":"720",
    ],
    [   "tag":"今日推荐",
                "title":"知你喜好,为你调酒",
                "videoName":"3.mp4",
                "width":"1280",
                "height":"720",
                "detail":"与石原里美一起享受美味的好酒"
    ]]

var currentPlayer = AVPlayerView()

func timeStampToString(timeStamp:String)->String {
    
    let string = NSString(string: timeStamp)
    
    let timeSta:TimeInterval = string.doubleValue
    let dfmatter = DateFormatter()
    dfmatter.dateFormat="yyyy年MM月dd日"
    
    let date = NSDate(timeIntervalSince1970: timeSta)
    
    return dfmatter.string(from: date as Date)
}

class AppTool: NSObject {

}
