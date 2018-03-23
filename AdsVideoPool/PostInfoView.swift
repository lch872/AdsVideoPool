//
//  PostInfoView.swift
//  AdsVideoPool
//
//  Created by lch on 2018/3/21.
//  Copyright © 2018年 ONEWAY. All rights reserved.
//

import UIKit

class PostInfoView: UIView {

  
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    func setupView() {
        
        //头像
        let padding:CGFloat = 10
        let icon = UIButton.init(frame: CGRect.init(x: padding, y: 5, width: 30, height: 30))
        icon.setImage(UIImage.init(named: "111.png"), for: .normal)
        icon.layer.cornerRadius = 15
        icon.layer.masksToBounds = true
        self.addSubview(icon)
        //昵称
        let name = UILabel.init(frame: CGRect.init(x: icon.frame.maxX + padding, y: icon.frame.origin.x, width: 200, height: 15))
        name.font = UIFont.systemFont(ofSize: 15)
        name.center = CGPoint.init(x: name.center.x, y: icon.center.y + 2)
        name.text = "Youtube精选推荐"
        self.addSubview(name)
        //关注
        let focus = UIButton.init(frame: CGRect.init(x: 300, y: 5, width: 63, height: 26))
        focus.setTitle("＋ 关注", for: .normal)
        focus.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        focus.setTitleColor(UIColor.red, for: .normal)
        focus.layer.cornerRadius = 12
        focus.layer.masksToBounds = true
        focus.center = CGPoint.init(x: focus.center.x, y: name.center.y)
        focus.layer.borderWidth = 0.3;
        focus.layer.cornerRadius = 13;
        focus.layer.borderColor = UIColor.red.cgColor
        self.addSubview(focus)
        
        //title
        let title = UILabel.init(frame: CGRect.init(x:padding, y: icon.frame.maxY + padding, width: SCREEN_WIDTH - 30, height: 60))
        title.font = UIFont.systemFont(ofSize: 20.0, weight: .light)
        title.numberOfLines = 0
        title.text = "女稍等我反对的的冯绍峰的女稍等我反对的的冯绍峰的"
        self.addSubview(title)
        
        //发布信息
        let postTime = UILabel.init(frame: CGRect.init(x:padding, y: title.frame.maxY + 5, width: SCREEN_WIDTH, height: 15))
        postTime.font = UIFont.systemFont(ofSize: 15)
        postTime.textColor = UIColor.init(white: 168/255.0, alpha: 1)
        postTime.text = "发布：2018-03-14   |   播放：987.2万"
        self.addSubview(postTime)
        
        
        let tag = tagBtn(name: "搞笑", frame: CGRect.init(x: padding, y: postTime.frame.maxY + padding, width: 50, height: 26))
        self.addSubview(tag)
        
        let tag2 = tagBtn(name: "广告", frame: CGRect.init(x: tag.frame.maxX+padding, y: postTime.frame.maxY + padding, width: 50, height: 26))
        self.addSubview(tag2)
        
        //点赞
        let btnW = SCREEN_WIDTH / 4
        
        let likeBtn = imgBtn(imgName: "like.png", title: "2234", frame: CGRect.init(x: 0, y: tag.frame.maxY + padding, width: btnW, height: 50))
        self.addSubview(likeBtn)
        
        let likeBtn2 = imgBtn(imgName: "like.png", title: "2234", frame: CGRect.init(x: btnW, y: likeBtn.frame.origin.y, width: btnW, height: 50))
        self.addSubview(likeBtn2)
        
        let likeBtn3 = imgBtn(imgName: "like.png", title: "2234", frame: CGRect.init(x: btnW*2, y: likeBtn.frame.origin.y, width: btnW, height: 50))
        self.addSubview(likeBtn3)
        
        let likeBtn4 = imgBtn(imgName: "like.png", title: "2234", frame: CGRect.init(x: btnW*3, y: likeBtn.frame.origin.y, width: btnW, height: 50))
        self.addSubview(likeBtn4)
        
    }
    
    
    func imgBtn(imgName:String, title:String, frame:CGRect) -> UIButton {
        let btn = UIButton.init(frame: frame)
        btn.setImage(UIImage.init(named: imgName), for: .normal)
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(UIColor.init(white: 168/255.0, alpha: 1), for: .normal)
        btn.titleEdgeInsets = UIEdgeInsets.init(top: btn.imageView!.frame.size.height, left: -btn.imageView!.frame.size.width, bottom: 0, right: 0)
        btn.imageEdgeInsets = UIEdgeInsets.init(top: -btn.titleLabel!.bounds.size.height, left: 0, bottom: 0, right: -btn.titleLabel!.bounds.size.width)
        return btn
    }
    
    func tagBtn(name:String,frame:CGRect) -> UIButton {
        let tagBtn = UIButton.init(frame: frame)
        tagBtn.setTitle(name, for: .normal)
        tagBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        tagBtn.setTitleColor(UIColor.lightGray, for: .normal)
        tagBtn.layer.cornerRadius = 12
        tagBtn.layer.masksToBounds = true
        tagBtn.layer.borderWidth = 0.3;
        tagBtn.layer.cornerRadius = frame.size.height/2;
        tagBtn.layer.borderColor = UIColor.lightGray.cgColor
        
        return tagBtn
    }
    

}
