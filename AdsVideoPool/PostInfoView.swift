//
//  PostInfoView.swift
//  AdsVideoPool
//
//  Created by lch on 2018/3/21.
//  Copyright © 2018年 ONEWAY. All rights reserved.
//

import UIKit
import MBProgressHUD
class PostInfoView: UIView {

    
    var data:[String:String] = ["":""]
    {
        didSet
        {
            setupData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    
    func setupData(){
        name.text = "YouTube精选推荐"//data["title"]
        title.text = data["title"]
    }
    
    var icon = UIButton()
     var name = UILabel()
     var title = UILabel()
//     let title = UILabel()
    
    
    
    
    
    func setupView() {
        
        //头像
        let padding:CGFloat = 10
        icon = UIButton.init(frame: CGRect.init(x: padding, y: 15, width: 30, height: 30))
        icon.setImage(UIImage.init(named: "postIcon.png"), for: .normal)
        icon.layer.cornerRadius = 15
        icon.layer.masksToBounds = true
        self.addSubview(icon)
        //昵称
        name = UILabel.init(frame: CGRect.init(x: icon.frame.maxX + padding, y: icon.frame.origin.x, width: 200, height: 15))
        name.font = UIFont.systemFont(ofSize: 15)
        name.center = CGPoint.init(x: name.center.x, y: icon.center.y + 2)
        name.text = ""
        self.addSubview(name)
        //关注
        let focus = UIButton.init(frame: CGRect.init(x: self.bounds.size.width - 80, y: 5, width: 63, height: 23))
        focus.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        
        focus.setTitle("＋ 关注", for: .normal)
        focus.setBackgroundImage(UIImage.init(named: "cm4_act_btn_follow"), for: .normal)
        focus.setTitleColor(AppRedColor, for: .normal)
        
        focus.setTitle("已关注", for: .selected)
        focus.setBackgroundImage(UIImage.init(named: "cm4_act_btn_praise"), for: .selected)
        focus.setTitleColor(AppDarkColor, for: .selected)
        
        focus.addTarget(self, action: #selector(focusBtnDidClick(btn:)), for: .touchUpInside)
        focus.center = CGPoint.init(x: focus.center.x, y: name.center.y)
        self.addSubview(focus)
        
        //title
        title = UILabel.init(frame: CGRect.init(x:padding, y: icon.frame.maxY + padding, width: SCREEN_WIDTH - 30, height: 30))
        title.font = UIFont.systemFont(ofSize: 20.0, weight: .light)
        title.numberOfLines = 0
        self.addSubview(title)
        
        //发布信息
        let postTime = UILabel.init(frame: CGRect.init(x:padding, y: title.frame.maxY + 5, width: SCREEN_WIDTH*0.75, height: 15))   //0.68
        postTime.font = UIFont.systemFont(ofSize: 13)
        postTime.textColor = AppDarkColor
        postTime.text = "发布：2018-03-14  |  播放：987.2万  |  来源："
        self.addSubview(postTime)
        
        let btn = UIButton.init(frame: CGRect.init(x:postTime.frame.maxX, y: title.frame.maxY + 5, width: 60, height: 15))
        btn.setImage(UIImage.init(named: "you.png"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.addTarget(self, action: #selector(sourceBtnDidClick), for: .touchUpInside)
        self.addSubview(btn)
        
        
        let tag = PostInfoView.tagBtn(name: "搞笑", frame: CGRect.init(x: padding, y: postTime.frame.maxY + padding, width: 40, height: 18.5))
        self.addSubview(tag)
        
        let tag2 = PostInfoView.tagBtn(name: "广告", frame: CGRect.init(x: tag.frame.maxX+padding, y: postTime.frame.maxY + padding, width: 40, height: 18.5))
        self.addSubview(tag2)
        
        //点赞
        let btnW = SCREEN_WIDTH / 4
        let likeBtn = imgBtn(imgName: "cm2_act_icn_praise_prs", title: String(arc4random()%2333), frame: CGRect.init(x: 0, y: self.frame.height - padding - 200, width: btnW, height: 50))
            likeBtn.setImage(UIImage.init(named: "cm2_act_icn_praised"), for: .selected)
        likeBtn.addTarget(self, action: #selector(likeBtnDidClick(btn:)), for: .touchUpInside)
         likeBtn.setTitleColor(AppRedColor, for: .selected)
        self.addSubview(likeBtn)
        
        let likeBtn2 = imgBtn(imgName: "踩", title: String(arc4random()%89), frame: CGRect.init(x: btnW, y: likeBtn.frame.origin.y, width: btnW, height: 50))
        likeBtn2.addTarget(self, action: #selector(likeBtnDidClick(btn:)),for: .touchUpInside)
        likeBtn2.setImage(UIImage.init(named: "踩_p"), for: .selected)
        self.addSubview(likeBtn2)
        
        let likeBtn3 = imgBtn(imgName: "cm2_act_icn_share_prs", title: String(arc4random()%893), frame: CGRect.init(x: btnW*2, y: likeBtn.frame.origin.y, width: btnW, height: 50))
        likeBtn3.addTarget(self, action: #selector(shareBtnDidClick(btn:)), for: .touchUpInside)
        self.addSubview(likeBtn3)
        
        let likeBtn4 = imgBtn(imgName: "更多", title: "", frame: CGRect.init(x: btnW*3, y: likeBtn.frame.origin.y, width: btnW, height: 50))
        likeBtn4.addTarget(self, action: #selector(moreMenu(btn:)), for: .touchUpInside)
        self.addSubview(likeBtn4)
        
//        let likeBtn5 = imgBtn(imgName: "", title: "", frame: CGRect.init(x: btnW*4, y: likeBtn.frame.origin.y, width: btnW, height: 50))
//        self.addSubview(likeBtn5)
        
        
        let scr = UIScrollView.init(frame: CGRect.init(x: 0, y: self.bounds.size.height - 80 - padding, width: SCREEN_WIDTH, height: 80))
        scr.contentSize = CGSize.init(width: 220*6+5 + 30, height: 80)
        scr.showsHorizontalScrollIndicator = false
        self.addSubview(scr)
        for index in 0...5 {
            let ll = maybeLikeView(frame: CGRect.init(x: 5+index*(220+5), y: 0, width: 220, height: 80), index: index)
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
    
    @objc func moreMenu(btn:UIButton) {
        
        
        
        let bg = UIView.init(frame: self.frame)
        bg.backgroundColor = UIColor.init(white: 10/255.0, alpha: 0.6)
        self.addSubview(bg)
        
        
        let rect = self.convert(btn.frame, from: btn.superview!)
        
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
    
     @objc func shareBtnDidClick(btn:UIButton) {
//        let share = ShareView()
//        UIApplication.shared.keyWindow?.rootViewController?.present(share, animated: true, completion: nil)
//        let dd = UIImageView.init(frame: CGRect.init(x: 0, y: SCREEN_HEIGHT - 200, width: SCREEN_WIDTH, height: 150))
//        dd.contentMode = .scaleAspectFit
//        dd.image = UIImage.init(named: "IMG_7786")
//        
//        let win = UIApplication.shared.keyWindow
//        win?.addSubview(dd)
        
        
    
    }
    
    //点击 更多 按钮
    @objc func moreBtnDidClick(btn:UIButton) {
        
        print(btn.tag)
        
        btn.superview!.superview!.removeFromSuperview()
        
        let hud = MBProgressHUD.showAdded(to: self, animated: true)
        hud.mode = .text
        hud.label.text = "操作成功"
        hud.margin = 10
        hud.offset.y = 50
        hud.removeFromSuperViewOnHide = true
        hud.hide(animated: true, afterDelay: 2.0)
        
        
    }
    @objc func focusBtnDidClick(btn:UIButton){
        btn.isSelected = !btn.isSelected
    }
    
    @objc func likeBtnDidClick(btn:UIButton){
        let title = btn.titleLabel?.text
        btn.isSelected = !btn.isSelected
        let new = btn.isSelected ? String(Int(title!)!+1):String(Int(title!)!-1)
        btn.setTitle(new, for: .normal)
    }
    
    
    @objc func sourceBtnDidClick(){
      
        let web = WebViewController.init()
        let nav = UINavigationController.init(rootViewController: web)
        web.loadURL(url: "http://www.qq.com")
    
        UIApplication.shared.keyWindow?.rootViewController?.present(nav, animated: true, completion: nil)
        
    }
    
    static func tagBtn(name:String,frame:CGRect) -> UIButton {
        let tagBtn = UIButton.init(frame: frame)
        tagBtn.setTitle(name, for: .normal)
        tagBtn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        tagBtn.setBackgroundImage(UIImage.init(named: "cm4_btn_gray_hollow"), for: .normal)
        tagBtn.setTitleColor(UIColor.init(white: 92/255.0, alpha: 1), for: .normal)
        
        return tagBtn
    }
    

}
