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
    var playerView = VideoPlayerView()
    
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
    
    func addView(view:VideoPlayerView){
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
    var postIcon = UIImageView()
    var adButton = UIButton()
    
    var control = UIView()
    lazy var adView:AdLinkView = {
        var view = AdLinkView.init(frame: CGRect.init(x: 0, y: playerView.frame.maxY, width: bgView.frame.width, height: 70))
        view.layer.cornerRadius = 0
        return view
    }()
    
    
    
    
    func setupData(){
        tagL.text = data["tag"]
        title.text = data["title"]
        detail.text = data["detail"]
        
        playerView.data = data
        
        let filePath = Bundle.main.path(forResource: data["videoName"], ofType:nil)
        
        if filePath != nil {
            let videoURL = URL(fileURLWithPath: filePath!)
            playerView.bgImage.image = MainTableView.getImage(videoUrl: videoURL)
            playerView.hideView(false, delay: 0)
            playerView.control.isHidden = false
        }else{
            
            let nam = data["ImageName"]
            playerView.bgImage.image = UIImage.init(named: nam!)
            playerView.control.isHidden = true
            playerView.hideView(true, delay: 0)
        }
        
        
        
    
        let isAd = data["type"] == "ads"
        playerView.adTag.isHidden = !isAd
        
        if isAd {
            bgView.frame = CGRect.init(x: 20, y: 0, width: SCREEN_WIDTH-40, height: (SCREEN_WIDTH*0.7))
            
            
            postIcon.image = UIImage.init(named: "icon2")

            adButton = UIButton.init(frame: CGRect.init(x: self.frame.width - 70,   y: 0, width: 50, height: 20))
            adButton.setTitle("获 取", for: .normal)
            adButton.titleLabel?.font = UIFont.systemFont(ofSize: 14.0, weight: .semibold)
            adButton.setBackgroundImage(UIImage.init(named: "cm4_list_btn_focus_prs"), for: .normal)
            adButton.setBackgroundImage(UIImage.init(named: "cm4_list_btn_focus_prs"), for: .highlighted)
            adButton.setTitleColor(UIColor.white, for: .normal)
            adButton.addTarget(self, action: #selector(commentBtnDidClick), for: .touchUpInside)
            bgView.addSubview(adButton)
            
        }else{
            postIcon.image = UIImage.init(named: "postIcon")
            bgView.frame = CGRect.init(x: 20, y: 0, width: SCREEN_WIDTH-40, height: (SCREEN_WIDTH*0.7))
            adButton.isHidden = true
        }
        
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let div:CGFloat = CGFloat(Float(data["height"]!)!/Float(data["width"]!)!)
        var ddd:CGFloat = CGFloat(div)*bgView.bounds.width
    

        if  div > 1 {
            // 加长view
//            if data["type"]=="2" {
//                ddd = bgView.bounds.width*CGFloat(Float(data["width"]!)!/Float(data["height"]!)!) + 200
//            }else{
                ddd = bgView.bounds.width*CGFloat(Float(data["width"]!)!/Float(data["height"]!)!)
//            }
            
            
            playerView.contentMode = .scaleAspectFill
            playerView.layer.masksToBounds = true
            playerView.isOpaque = true
//            bgView.insertSubview(effectView, aboveSubview: playerView)
            
            
            
        }
        playerView.frame = CGRect.init(x: 0, y: 0, width: bgView.bounds.size.width, height: ddd)
        clickFrame = playerView.frame
        
        
        postIcon.frame = CGRect.init(x: 10, y: playerView.frame.maxY + 15, width: 30, height: 30)
        
        title.frame = CGRect.init(x: postIcon.frame.maxX + 10, y: playerView.frame.maxY + 15, width: self.bounds.width - 20, height: 30)
//        detail.frame = CGRect.init(x: 10, y: title.frame.maxY, width: self.bounds.width - 60, height: 45)
        adButton.frame = CGRect.init(x: bgView.frame.width - 70,   y: 0, width: 50, height: 20)
        adButton.center = CGPoint.init(x: adButton.center.x, y: title.center.y)
        
        act.frame = CGRect.init(x: 0, y: bgView.frame.height - 25, width: 375, height: 20)
    
    }
    func setupView() {
        
        
        bgView = UIView.init(frame: CGRect.init(x: 20, y: 0, width: SCREEN_WIDTH-40, height: (SCREEN_WIDTH-85)))
        bgView.layer.cornerRadius = 15;
        bgView.layer.masksToBounds = true;
        bgView.backgroundColor = UIColor.white
        self.contentView.addSubview(bgView)
        
        let div:Float = 0.5625

        playerView =  VideoPlayerView.init(frame:CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH-40, height: CGFloat(div)*bgView.bounds.width))
        playerView.contentMode = .scaleAspectFit
        bgView.addSubview(playerView)

        
        let padding:CGFloat = 18
        let width:CGFloat = self.bounds.width - padding*2

        title = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: width, height: 30))
        title.font = UIFont.boldSystemFont(ofSize: 19.0)
        title.isOpaque = false
        bgView.addSubview(title)
        
        
        postIcon = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: 30, height: 30))
        bgView.addSubview(postIcon)
        
        
        
//        detail = UILabel.init(frame: CGRect.init(x: 0, y: 0 , width: width, height: 45))
//        detail.lineBreakMode = .byWordWrapping
//        detail.numberOfLines = 0
//        detail.isOpaque = false
//        detail.textColor = UIColor.lightGray
//        detail.font = UIFont.boldSystemFont(ofSize: 15.0)
//        bgView.addSubview(detail)


        act = actionView(frame: CGRect.init(x: 0, y: bgView.frame.height - 25 + padding, width: bgView.frame.width, height: 20))
        bgView.addSubview(act)
        
        
        let likeBtn = act.subviews.first as! UIButton
        likeBtn.addTarget(self, action: #selector(likeBtnDidClick(btn:)), for: .touchUpInside)
        
        let dislikeBtn = act.subviews[1] as! UIButton
        dislikeBtn.addTarget(self, action: #selector(likeBtnDidClick(btn:)), for: .touchUpInside)
        
        let commentBtn = act.subviews[2] as! UIButton
        commentBtn.addTarget(self, action: #selector(commentBtnDidClick(btn:)), for: .touchUpInside)
        
        
//        let more:UIButton = act.subviews.last as! UIButton
//        more.addTarget(self, action: #selector(moreMenu(btn:)), for: .touchUpInside)
        
    }
    

    
    
    //点击 赞 按钮
    @objc func likeBtnDidClick(btn:UIButton) {
        let title = btn.titleLabel?.text
        btn.isSelected = !btn.isSelected
        let new = btn.isSelected ? String(Int(title!)!+1):String(Int(title!)!-1)
        btn.setTitle(new, for: .normal)
    }
    
    //点击 评论 按钮
    @objc func commentBtnDidClick(btn:UIButton) {
        clickClosure(indexo)
    }
    
    
    
 
    
    
    
}
