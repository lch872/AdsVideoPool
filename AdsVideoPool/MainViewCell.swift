//
//  LCCollectionViewCell.swift
//  AdsVideoPool
//
//  Created by lch on 2018/3/19.
//  Copyright © 2018年 ONEWAY. All rights reserved.
//

import UIKit
import AVKit
import SnapKit
public enum kJPPlayUnreachCellStyle : Int {
    
    case none // normal 播放滑动可及cell.
    
    case up // top 顶部不可及.
    
    case down // bottom 底部不可及.
}

class MainViewCell: UITableViewCell {
    
    public var cellStyle : kJPPlayUnreachCellStyle? // cell类型
    
    var clickFrame:CGRect?
    var indexo:IndexPath?
    
    
    //把申明的闭包设置成属性
    var clickClosure: (_: IndexPath?) -> Void? = {(ddd)->Void in
        
    }

    
    var data:[String:String] = ["":""]
    {
        didSet
        {
            setupData()
        }
    }
    
    var isScaled = false
    var playerView = UIImageView()
    
    var screenImg = UIView()
    var videoPath = String()
    
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.clear;
        self.contentView.backgroundColor = UIColor.clear;
        setupView()
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addView(view:UIImageView){
        self.playerView.removeFromSuperview()

        view.frame = CGRect.init(x: 0, y: 0, width: self.bgView.frame.size.width, height: view.frame.size.height)

        self.bgView.insertSubview(view, belowSubview: control)
        self.playerView = view

    }
    
    var tagL = UILabel()
    var title = UILabel()
    var detail = UILabel()
    var bgView = UIView()
    var act = UIView()
    
    
    var control = UIView()
    func setupData(){
        tagL.text = data["tag"]
        title.text = data["title"]
        detail.text = data["detail"]
        
        let filePath = Bundle.main.path(forResource: data["videoName"], ofType:nil)
        let videoURL = URL(fileURLWithPath: filePath!)
        self.playerView.image = getImage(videoUrl: videoURL)
        
        
        let aa = CALayer.init()
        aa.contents = UIImage.init(named: "1111.png")?.cgImage
        self.playerView.layer.addSublayer(aa)
        
        
//        if data["type"] == "2" {
//            bgView.frame = CGRect.init(origin: bgView.frame.origin, size: CGSize.init(width: bgView.frame.size.width, height: (SCREEN_WIDTH-40)+200))
//        }
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let div:CGFloat = CGFloat(Float(data["height"]!)!/Float(data["width"]!)!)
        var ddd:CGFloat = CGFloat(div)*bgView.bounds.width
    
//        print(ddd)
        if  div > 1 {
            // 加长view
//            if data["type"]=="2" {
//                ddd = bgView.bounds.width*CGFloat(Float(data["width"]!)!/Float(data["height"]!)!) + 200
//            }else{
                ddd = bgView.bounds.width*CGFloat(Float(data["width"]!)!/Float(data["height"]!)!)
//            }
            
            
//            let effect = UIBlurEffect.init(style: .light)
//            let effectView = UIVisualEffectView.init(effect: effect)
//
//            effectView.frame = playerView.bounds
            playerView.contentMode = .scaleAspectFill
            playerView.layer.masksToBounds = true
            playerView.isOpaque = true
//            bgView.insertSubview(effectView, aboveSubview: playerView)
            
            
            
        }
        playerView.frame = CGRect.init(x: 0, y: 0, width: bgView.bounds.size.width, height: ddd)
        clickFrame = playerView.frame
        
        print("playerView.frame\(playerView.frame)")
        
        title.frame = CGRect.init(x: 10, y: playerView.frame.maxY + 10, width: self.bounds.width - 20, height: 30)
        detail.frame = CGRect.init(x: 10, y: title.frame.maxY + 5, width: self.bounds.width - 20, height: 45)
        act.frame = CGRect.init(x: 0, y: bgView.frame.height - 25, width: 375, height: 20)
    
    }
    func setupView() {
        print("创建")
        
        
        
        
        bgView = UIView.init(frame: CGRect.init(x: 20, y: 0, width: SCREEN_WIDTH-40, height: (SCREEN_WIDTH-40)))
        bgView.layer.cornerRadius = 15;
        bgView.layer.masksToBounds = true;
        bgView.backgroundColor = UIColor.white
        self.contentView.addSubview(bgView)
        
        let div:Float = 0.5625

        playerView = UIImageView.init(frame:CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH-40, height: CGFloat(div)*bgView.bounds.width))
        playerView.contentMode = .scaleAspectFit
        bgView.addSubview(playerView)

        
        let padding:CGFloat = 18
        let width:CGFloat = self.bounds.width - padding*2

        title = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: width, height: 30))
        title.font = UIFont.boldSystemFont(ofSize: 25.0)
        title.isOpaque = false
        bgView.addSubview(title)
        
        
        
        //--------------------
        
        control = UIView.init(frame: playerView.bounds)
        bgView.insertSubview(control, aboveSubview: playerView)
        
        
        let sss = UIButton.init(frame: CGRect.init(x: 5, y: 5, width: 25, height: 25))
        sss.setImage(UIImage.init(named: "postIcon"), for: .normal)
        control.addSubview(sss)
        
        //播放暂停
        let playBtn = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 100, height: 100))
        playBtn.setImage(UIImage.init(named: "播放"), for: .selected)
        playBtn.center = control.center
        playBtn.addTarget(self, action: #selector(pauseDidClick(btn:)), for: .touchUpInside)
        control.addSubview(playBtn)
        
        
        //观看量
        let playNum = imgBtn(imgName: "观看数", title: "24万", frame: CGRect.init(x: 3, y: playerView.frame.height - 30, width: 50, height: 30))
        playNum.setTitleColor(UIColor.white, for: .normal)
        control.addSubview(playNum)
        
        let length = imgBtn(imgName: "时长", title: "03:20", frame: CGRect.init(x: playerView.frame.width - 70, y: playerView.frame.height - 30, width: 70, height: 30))
        length.setTitleColor(UIColor.white, for: .normal)
        control.addSubview(length)
        
        //------------------

//
        detail = UILabel.init(frame: CGRect.init(x: 0, y: 0 , width: width, height: 45))
        detail.lineBreakMode = .byWordWrapping
        detail.numberOfLines = 0
        detail.isOpaque = false
        detail.textColor = UIColor.lightGray
        detail.font = UIFont.boldSystemFont(ofSize: 16.0)
        bgView.addSubview(detail)


        act = actionView(frame: CGRect.init(x: 0, y: bgView.frame.height - 25 + padding, width: 375, height: 20))
        bgView.addSubview(act)
        
        
        let likeBtn = act.subviews.first as! UIButton
        likeBtn.addTarget(self, action: #selector(likeBtnDidClick(btn:)), for: .touchUpInside)
        
        let commentBtn = act.subviews[1] as! UIButton
        commentBtn.addTarget(self, action: #selector(commentBtnDidClick(btn:)), for: .touchUpInside)
        
        
        let more:UIButton = act.subviews.last as! UIButton
        more.addTarget(self, action: #selector(moreMenu(btn:)), for: .touchUpInside)
        
    }
    
    @objc func pauseDidClick(btn:UIButton){
        btn.isSelected = !btn.isSelected
        
        if btn.isSelected {
            playerView.jp_pause()
        }else{
            playerView.jp_resume()
        }
        
    }
    
    
    //点击 赞 按钮
    @objc func likeBtnDidClick(btn:UIButton) {
        btn.isSelected = !btn.isSelected
    }
    
    //点击 评论 按钮
    @objc func commentBtnDidClick(btn:UIButton) {
        clickClosure(indexo)
    }
    
    //点击 更多 按钮
    @objc func moreBtnDidClick(btn:UIButton) {
        
        print(btn.tag)
        
        btn.superview!.superview!.removeFromSuperview()
    
    }
    
    
    @objc func moreMenu(btn:UIButton) {
        

        
        let bg = UIView.init(frame: bgView.frame)
        bg.layer.cornerRadius = 15
        bg.layer.masksToBounds = true
        bg.backgroundColor = UIColor.init(white: 10/255.0, alpha: 0.6)
        self.contentView.addSubview(bg)

        
        let rect = bgView.convert(btn.frame, from: btn.superview!)
        
        let rect2 = CGRect.init(x: rect.maxX - SCREEN_WIDTH + 150 - 20, y: rect.midY - 20 - 120, width: SCREEN_WIDTH - 150, height: 120)
        
        let content = UIView.init(frame: rect2)
        content.layer.cornerRadius = 10;
        content.backgroundColor = UIColor.white
        content.layer.masksToBounds = true;
        
        
        let btn1 = lineButton(frame: CGRect.init(x: 0, y: 0, width: content.frame.size.width, height: 40), text: "减少此类视频", img: "屏蔽", tag: 1)
        content.addSubview(btn1)
        
        let line1 = dividerLine(frame: CGRect.init(x: 0, y: 40, width: content.frame.size.width, height: 0.3))
        content.addSubview(line1)
        
        let btn2 = lineButton(frame: CGRect.init(x: 0, y: 40, width: content.frame.size.width, height: 40), text: "增加此类视频", img: "增加", tag: 2)
        content.addSubview(btn2)
        
        let line2 = dividerLine(frame: CGRect.init(x: 0, y: 80, width: content.frame.size.width, height: 0.3))
        content.addSubview(line2)
        
        let btn3 = lineButton(frame: CGRect.init(x: 0, y: 80, width: content.frame.size.width, height: 40), text: "举报这个视频", img: "举报", tag: 3)
        content.addSubview(btn3)
        
        bg.addSubview(content)
        
        
    }
    
    
    func lineButton(frame:CGRect, text:String, img:String, tag:NSInteger) -> UIButton {
        let btn3 = UIButton.init(frame: frame)
        btn3.tag = tag
        btn3.setTitle(text, for: .normal)
        btn3.titleLabel?.font = UIFont.systemFont(ofSize: 13.0)
        btn3.setTitleColor(UIColor.init(white: 30/255.0, alpha: 1), for: .normal)
        btn3.setImage(UIImage.init(named: img), for: .normal)
        btn3.contentHorizontalAlignment = .left
        btn3.addTarget(self, action: #selector(moreBtnDidClick(btn:)), for: .touchUpInside)
        btn3.titleEdgeInsets = UIEdgeInsetsMake(0, 30, 0, 0)
        btn3.imageEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0)
        
        return btn3
    }
    func getImage(videoUrl:URL) -> UIImage {
        
        let avAsset = AVAsset.init(url: videoUrl as URL)
        
        //生成视频截图
        let generator = AVAssetImageGenerator(asset: avAsset)
        generator.appliesPreferredTrackTransform = true
        let time = CMTimeMakeWithSeconds(0.0,600)
        var actualTime:CMTime = CMTimeMake(0,0)
        let imageRef:CGImage = try! generator.copyCGImage(at: time, actualTime: &actualTime)
        let frameImg = UIImage.init(cgImage: imageRef)
        
        return frameImg
    }
    
    
 
    
    
    
}
