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
        let icon = UIButton.init(frame: CGRect.init(x: padding, y: 15, width: 30, height: 30))
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
        let focus = UIButton.init(frame: CGRect.init(x: self.bounds.size.width - 80, y: 5, width: 63, height: 23))
        focus.setTitle("＋ 关注", for: .normal)
        focus.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        focus.setBackgroundImage(UIImage.init(named: "cm4_act_btn_follow"), for: .normal)
        focus.setBackgroundImage(UIImage.init(named: "cm4_act_btn_follow"), for: .highlighted)
        focus.setTitleColor(UIColor.init(red: 211/255.0, green: 58/255.0, blue: 41/255.0, alpha: 1), for: .normal)
        focus.center = CGPoint.init(x: focus.center.x, y: name.center.y)
        
        self.addSubview(focus)
        
        //title
        let title = UILabel.init(frame: CGRect.init(x:padding, y: icon.frame.maxY + padding, width: SCREEN_WIDTH - 30, height: 30))
        title.font = UIFont.systemFont(ofSize: 20.0, weight: .light)
        title.numberOfLines = 0
        title.text = "戏精的日常 当你在队友面前犯中二病"
        self.addSubview(title)
        
        //发布信息
        let postTime = UILabel.init(frame: CGRect.init(x:padding, y: title.frame.maxY + 5, width: SCREEN_WIDTH - 100, height: 15))
        postTime.font = UIFont.systemFont(ofSize: 14)
        postTime.textColor = UIColor.init(white: 168/255.0, alpha: 1)
        postTime.text = "发布：2018-03-14  |  播放：987.2万  |  来源："
        self.addSubview(postTime)
        
        let btn = UIButton.init(frame: CGRect.init(x:postTime.frame.maxX, y: title.frame.maxY + 5, width: 100, height: 15))
        btn.setImage(UIImage.init(named: "you.png"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.addTarget(self, action: #selector(sourceBtnDidClick), for: .touchUpInside)
        self.addSubview(btn)
        
        
        let tag = tagBtn(name: "搞笑", frame: CGRect.init(x: padding, y: postTime.frame.maxY + padding, width: 40, height: 18.5))
        self.addSubview(tag)
        
        let tag2 = tagBtn(name: "广告", frame: CGRect.init(x: tag.frame.maxX+padding, y: postTime.frame.maxY + padding, width: 40, height: 18.5))
        self.addSubview(tag2)
        
        //点赞
        let btnW = SCREEN_WIDTH / 4
        
        let likeBtn = imgBtn(imgName: "cm2_act_icn_praise_prs", title: "2234", frame: CGRect.init(x: 0, y: self.bounds.size.height - 60 + padding, width: btnW, height: 50))
        self.addSubview(likeBtn)
        
        let likeBtn2 = imgBtn(imgName: "cm2_playlist_icn_fav_prs", title: "2234", frame: CGRect.init(x: btnW, y: likeBtn.frame.origin.y, width: btnW, height: 50))
        self.addSubview(likeBtn2)
        
        let likeBtn3 = imgBtn(imgName: "cm2_act_icn_cmt_prs", title: "2234", frame: CGRect.init(x: btnW*2, y: likeBtn.frame.origin.y, width: btnW, height: 50))
        self.addSubview(likeBtn3)
        
        let likeBtn4 = imgBtn(imgName: "cm2_act_icn_share_prs", title: "2234", frame: CGRect.init(x: btnW*3, y: likeBtn.frame.origin.y, width: btnW, height: 50))
        self.addSubview(likeBtn4)
        
    }
    
    
    @objc func sourceBtnDidClick(){
        let webVC = UIViewController.init()
        let nav = UINavigationController.init(rootViewController: webVC)
        let web = UIWebView.init(frame: webVC.view.bounds)
            webVC.view.addSubview(web)


        
        web.loadRequest(URLRequest.init(url: URL.init(string: "http://www.qq.com")!))
        UIApplication.shared.keyWindow?.rootViewController?.present(nav, animated: true, completion: nil)
        
    }
    
    func tagBtn(name:String,frame:CGRect) -> UIButton {
        let tagBtn = UIButton.init(frame: frame)
        tagBtn.setTitle(name, for: .normal)
        tagBtn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        tagBtn.setBackgroundImage(UIImage.init(named: "cm4_btn_gray_hollow"), for: .normal)
        tagBtn.setTitleColor(UIColor.init(white: 92/255.0, alpha: 1), for: .normal)
        
        return tagBtn
    }
    

}
