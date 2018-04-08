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
        let postTime = UILabel.init(frame: CGRect.init(x:padding, y: title.frame.maxY + 5, width: SCREEN_WIDTH - 115, height: 15))
        postTime.font = UIFont.systemFont(ofSize: 14)
        postTime.textColor = UIColor.init(white: 168/255.0, alpha: 1)
        postTime.text = "发布：2018-03-14  |  播放：987.2万  |  来源："
        self.addSubview(postTime)
        
        let btn = UIButton.init(frame: CGRect.init(x:postTime.frame.maxX, y: title.frame.maxY + 5, width: 60, height: 15))
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
        
        let likeBtn = imgBtn(imgName: "cm2_act_icn_praise_prs", title: "2234", frame: CGRect.init(x: 0, y: tag2.frame.maxY + padding, width: btnW, height: 50))
        self.addSubview(likeBtn)
        
        let likeBtn2 = imgBtn(imgName: "cm2_playlist_icn_fav_prs", title: "2234", frame: CGRect.init(x: btnW, y: likeBtn.frame.origin.y, width: btnW, height: 50))
        self.addSubview(likeBtn2)
        
        let likeBtn3 = imgBtn(imgName: "cm2_act_icn_cmt_prs", title: "2234", frame: CGRect.init(x: btnW*2, y: likeBtn.frame.origin.y, width: btnW, height: 50))
        self.addSubview(likeBtn3)
        
        let likeBtn4 = imgBtn(imgName: "cm2_act_icn_share_prs", title: "2234", frame: CGRect.init(x: btnW*3, y: likeBtn.frame.origin.y, width: btnW, height: 50))
        self.addSubview(likeBtn4)
        
        
        let scr = UIScrollView.init(frame: CGRect.init(x: 0, y: self.bounds.size.height - 80 - padding, width: SCREEN_WIDTH, height: 80))
        scr.contentSize = CGSize.init(width: 220*6+5, height: 80)
        scr.showsHorizontalScrollIndicator = false
        self.addSubview(scr)
        for index in 0...5 {
            let ll = maybeLikeView(frame: CGRect.init(x: 5+index*(220+5), y: 0, width: 220, height: 80))
            scr.addSubview(ll)
        }
        
        let customView = UIView.init(frame: CGRect.init(x: 0, y:self.bounds.size.height - 80 - padding-padding-28 , width: SCREEN_WIDTH, height:28))
        customView.backgroundColor = UIColor.init(white: 247/255.0, alpha: 1)
        self.addSubview(customView)
        
        let headerLabel = UILabel.init(frame: CGRect.zero)
        headerLabel.backgroundColor = UIColor.clear
        headerLabel.isOpaque = false
        headerLabel.textColor = UIColor.black
        headerLabel.highlightedTextColor = UIColor.white
        headerLabel.font = UIFont.systemFont(ofSize: 13)
        headerLabel.frame = CGRect.init(x: 10, y: 0, width: SCREEN_WIDTH, height:28)
        
        headerLabel.text = "相关推荐"
        customView.addSubview(headerLabel)
        
    }
    
    
    @objc func sourceBtnDidClick(){
      
        let web = WebViewController.init()
        let nav = UINavigationController.init(rootViewController: web)
        web.loadURL(url: "http://www.qq.com")
    
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
