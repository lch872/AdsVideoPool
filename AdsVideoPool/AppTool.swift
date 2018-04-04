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
var JSON =
    [
        [
            "tag":"游戏推荐",
            "title":"勇闯迷宫，拯救公主",
            "videoName":"12.mp4",
            "detail":"进入《Crypt of the NecroDancer》的动感冒险",
            "width":"720",
            "height":"1280",
        ],
        [   "tag":"今日推荐",
                "title":"知你喜好,为你调酒",
                "videoName":"3.mp4",
                "width":"1280",
                "height":"720",
                "detail":"与石原里美一起享受美味的好酒"
        ]
   ]


func timeStampToString(timeStamp:String)->String {
    
    let string = NSString(string: timeStamp)
    
    let timeSta:TimeInterval = string.doubleValue
    let dfmatter = DateFormatter()
    dfmatter.dateFormat="yyyy年MM月dd日"
    
    let date = NSDate(timeIntervalSince1970: timeSta)
    
    return dfmatter.string(from: date as Date)
}

func imageFromView(view:UIView) -> UIImage {
    UIGraphicsBeginImageContextWithOptions(view.frame.size, false, UIScreen.main.scale);
    let context = UIGraphicsGetCurrentContext()
    view.layer.render(in: context!)
    let img = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    let imageData = UIImageJPEGRepresentation(img!, 1.0) as! NSData
        imageData.write(toFile: "/Users/lch/Desktop/111.png", atomically: true)
    
    return img!
}


func actionView(frame:CGRect) -> UIView{
    
    let div = UIView.init(frame: frame)
    let btnW = frame.width / 4
    
    let likeBtn = imgBtn(imgName: "cm2_act_icn_praise_prs", title: "2234", frame: CGRect.init(x: 0, y: 0, width: btnW, height: frame.height))
//    likeBtn.backgroundColor = UIColor.blue
    div.addSubview(likeBtn)
    
    let likeBtn2 = imgBtn(imgName: "cm2_playlist_icn_fav_prs", title: "2234", frame: CGRect.init(x: btnW, y: 0, width: btnW, height: frame.height))
    div.addSubview(likeBtn2)
    
    let likeBtn3 = imgBtn(imgName: "cm2_act_icn_cmt_prs", title: "2234", frame: CGRect.init(x: btnW*2, y: 0, width: btnW, height: frame.height))
    div.addSubview(likeBtn3)
    
    let likeBtn4 = imgBtn(imgName: "cm2_act_icn_share_prs", title: "2234", frame: CGRect.init(x: btnW*3, y: 0, width: btnW, height: frame.height))
    div.addSubview(likeBtn4)
    
    return div
}

func imgBtn(imgName:String, title:String, frame:CGRect) -> UIButton {
    let btn = UIButton.init(frame: frame)
    btn.setImage(UIImage.init(named: imgName), for: .normal)
    btn.setTitle(title, for: .normal)
    btn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
    btn.setTitleColor(UIColor.init(white: 168/255.0, alpha: 1), for: .normal)
//    btn.titleEdgeInsets = UIEdgeInsets.init(top: btn.imageView!.frame.size.height, left: -btn.imageView!.frame.size.width, bottom: 0, right: 0)
//    btn.imageEdgeInsets = UIEdgeInsets.init(top: -btn.titleLabel!.bounds.size.height-5, left: 0, bottom: 0, right: -btn.titleLabel!.bounds.size.width)
    btn.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: 5, bottom: 0, right: 0)
    
    return btn
}

class AppTool: NSObject {
    
    static func checkLogin(){
        if (!UserDefaults.standard.bool(forKey: "isLogin")){
            let  login = LoginView()
            UIApplication.shared.keyWindow?.rootViewController?.present(login, animated: true, completion: nil)
        }
    }
}
