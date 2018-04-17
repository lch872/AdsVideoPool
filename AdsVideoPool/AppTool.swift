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

let AppRedColor = UIColor.init(red: 211/255.0, green: 58/255.0, blue: 41/255.0, alpha: 1)
let AppDarkColor = UIColor.init(white: 168/255.0, alpha: 1)

var JSON =
    [
        [
            "tag":"游戏推荐",
            "title":"Face ID 只需轻轻看一眼",
            "videoName":"Apple.mp4",
            "detail":" iPhone X ，现在就跟未来见个面吧",
            "width":"1280",
            "height":"720",
            "type":"1",
            "length":"01:00"
        ],
        [
            "tag":"今日推荐",
                "title":"知你喜好,为你调酒",
                "videoName":"jiu.mp4",
                "width":"1280",
                "height":"720",
                "detail":"与石原里美一起享受美味好酒",
                "length":"00:15"
        ],
        [
            "tag":"游戏推荐",
            "title":"SVENSON - 让你头发飘飘",
            "videoName":"changfa.mp4",
            "detail":"戛纳广告节银奖作品《飘飘》",
            "width":"1280",
            "height":"720",
            "type":"2",
            "length":"01:03"
        ],[
            "tag":"广告",
            "title":"大吉大利，今晚吃鸡",
            "videoName":"cijizhanchang.mp4",
            "detail":"叫上你的队友，加入酣畅淋漓的战斗吧",
            "width":"1280",
            "height":"720",
            "type":"ads",
            "length":"01:45"
        ],
        [
            "tag":"游戏推荐",
            "title":"3秒即可召唤拉面怪兽",
            "videoName":"lamian.mp4",
            "detail":"想拥有召唤怪兽的能力? 尝试一下这款拉面",
            "width":"1280",
            "height":"720",
            "type":"2",
            "length":"00:30"
        ],[
            "tag":"游戏推荐",
            "title":"萌宠猫咪的日常",
            "videoName":"maomi.mp4",
            "detail":"活捉一只极具正义感的黑猫警长，嘻嘻",
            "width":"1280",
            "height":"720",
            "type":"2",
            "length":"01:14"
        ],
        [
            "tag":"游戏推荐",
            "title":"吉尔吉斯斯坦的美丽风光",
            "videoName":"jierjisi.mp4",
            "detail":"感受自然，感受人文，感受生活",
            "width":"1280",
            "height":"720",
            "type":"2",
            "length":"01:52"
        ],[
            "tag":"广告",
            "title":"大吉大利，今晚吃鸡",
            "videoName":"cijizhanchang3333.mp4",
            "ImageName":"吃鸡.jpg",
            "detail":"叫上你的队友，加入酣畅淋漓的战斗吧",
            "width":"1280",
            "height":"720",
            "type":"ads",
            "length":"01:45"
        ],
        [
            "tag":"游戏推荐",
            "title":"憨豆先生《越狱》",
            "videoName":"yueyu.mp4",
            "detail":"憨豆先生犯事了，被抓到警察局里，然后...",
            "width":"1280",
            "height":"720",
            "type":"2",
            "length":"02:32"
        ],[
            "tag":"游戏推荐",
            "title":"简单材料,自制小夜灯",
            "videoName":"zizhi.mp4",
            "detail":"跟着达人DIY，自己动手做出有趣的东西",
            "width":"1280",
            "height":"720",
            "type":"2",
            "length":"01:45"
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
    
    return img!
}


func randomColor(alp:CGFloat = 1) -> UIColor {
        let red = CGFloat(arc4random()%256)/255.0
        let green = CGFloat(arc4random()%256)/255.0
        let blue = CGFloat(arc4random()%256)/255.0
        return UIColor(red: red, green: green, blue: blue, alpha: alp)
}


func maybeLikeView(frame:CGRect,index:NSInteger) -> UIView {
    let titleArr = ["知你喜好,为你调酒","SVENSON - 让你头发飘飘","Face ID 只需轻轻看一眼","3秒即可召唤拉面怪兽","简单材料,自制小夜灯","吉尔吉斯斯坦的美丽风光"]
    let tagArr = ["#石原里美#","#获奖广告#","#iPhone X#","#召唤拉面#","#DIY系列#","#自然风光#"]
    
    let padding:CGFloat = 10
    
    let repostView = UIView.init(frame:frame)
    repostView.backgroundColor = UIColor.init(white: 240/255.0, alpha: 1)
    repostView.layer.cornerRadius = 5
    repostView.layer.masksToBounds = true
    
    let name = String.init(format: "\(index).png")
    let subImg = UIImageView.init(image: UIImage.init(named: name))
    subImg.frame = CGRect.init(x: 5, y: (frame.size.height-54)/2, width: 100, height: 54)
    subImg.layer.cornerRadius = 5
    subImg.layer.masksToBounds = true
    repostView.addSubview(subImg)
    
    let lr = UILabel.init(frame: CGRect.init(x: subImg.frame.maxX + padding, y:11.5, width: repostView.frame.width-subImg.frame.maxX - 10, height: 30))
    lr.font = UIFont.systemFont(ofSize: 10.0, weight: .bold)
    lr.text = titleArr[index]
    repostView.addSubview(lr)
    
    let tag = UILabel.init(frame: CGRect.init(x: subImg.frame.maxX + padding, y:lr.frame.maxY , width: repostView.frame.width-subImg.frame.maxX - 30, height: 30))
    tag.font = UIFont.systemFont(ofSize: 9.0, weight:.thin)
    tag.text = tagArr[index]
    repostView.addSubview(tag)
    
    return repostView
}
func actionView(frame:CGRect) -> UIView{
    
    let div = UIView.init(frame: frame)
    let btnW:CGFloat = frame.width/4
    
    
    let likeBtn = imgBtn(imgName: "cm2_act_icn_praise_prs", title: String(arc4random()%2333), frame: CGRect.init(x: frame.width-btnW*4, y: 0, width: btnW, height: frame.height))
    likeBtn.setImage(UIImage.init(named: "cm2_act_icn_praised"), for: .selected)
    likeBtn.setTitleColor(AppRedColor, for: .selected)
    div.addSubview(likeBtn)
    
    let likeBtn2 = imgBtn(imgName: "踩", title: String(arc4random()%93), frame: CGRect.init(x: frame.width-btnW*3, y: 0, width: btnW, height: frame.height))
       likeBtn2.setImage(UIImage.init(named: "踩_p"), for: .selected)
    div.addSubview(likeBtn2)
    
    
    let likeBtn4 = imgBtn(imgName: "cm2_act_icn_cmt_prs", title: String(arc4random()%5333), frame: CGRect.init(x: frame.width-btnW*2, y: 0, width: btnW, height: frame.height))
    likeBtn4.setImage(UIImage.init(named: "cm2_act_icn_praised"), for: .selected)
    likeBtn4.setTitleColor(AppRedColor, for: .selected)
    div.addSubview(likeBtn4)
    
    let likeBtn3 = imgBtn(imgName: "cm2_act_icn_share_prs", title: String(arc4random()%2333), frame: CGRect.init(x: frame.width-btnW*1, y: 0, width: btnW, height: frame.height))
    div.addSubview(likeBtn3)
    
//    let likeBtn5 = imgBtn(imgName: "更多", title: "", frame: CGRect.init(x: frame.width-btnW, y: 0, width: btnW, height: frame.height))
//    div.addSubview(likeBtn5)
    
    
    
    return div
}


func  dividerLine(frame:CGRect) -> UIView {
    let view = UIView.init(frame: frame)
    view.backgroundColor = UIColor.init(white: 203/255.0, alpha: 1)
    
    return view
}

func imgBtn(imgName:String, title:String, frame:CGRect) -> UIButton {
    let btn = UIButton.init(frame: frame)
    btn.setImage(UIImage.init(named: imgName), for: .normal)
    btn.setTitle(title, for: .normal)
    btn.titleLabel?.font = UIFont.systemFont(ofSize: 12.0)
    btn.setTitleColor(AppDarkColor, for: .normal)
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
