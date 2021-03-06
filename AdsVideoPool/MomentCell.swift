//
//  MomentCell.swift
//  AdsVideoPool
//
//  Created by lch on 2018/3/30.
//  Copyright © 2018年 ONEWAY. All rights reserved.
//

import UIKit
import AVKit
import JPVideoPlayer

class MomentCell: UITableViewCell {

    var isRepost = false
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        data = NSDictionary()
        userInfoClick = {(data:Dictionary<String,String>) -> Void in
            

        }
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var userInfoClick:(Dictionary<String,String>) -> Void?
    
    var data:NSDictionary{
        didSet{
            setupData()
        }
    }
    
    var nameL = UIButton()
    var timeL = UILabel()
    var likeNumber = UILabel()
    var textLL = UILabel()
    var icon = UIButton()
    var likeBtn = UIButton()
    var postWay = UILabel()
    var reply = UIButton()
    
    func setupData() {
        let dict = self.data["data"] as! NSDictionary
        
        let namn =  dict["user"] as? NSDictionary
//        let avatar = namn!["avatar"] as! String
//        let url = URL(string: avatar)
//        icon.kf.setImage(with: url, for: .normal)
        icon.setImage(UIImage.init(named: "userIcon"), for: .normal)
        
        
        nameL.setTitle(namn!["nickname"] as! String, for: .normal)

        //
//        postWay.text = "评论了:"
        
        textLL.text = dict.value(forKey: "message") as! String!
        textLL.sizeToFit()
        let size = textLL.sizeThatFits(CGSize.init(width: SCREEN_WIDTH-icon.frame.maxX-15-10, height: CGFloat(MAXFLOAT)))
        textLL.frame = CGRect.init(x: textLL.frame.origin.x, y: textLL.frame.origin.y, width: SCREEN_WIDTH-icon.frame.maxX-15-10, height: size.height)
        
//        let ddd = dict.value(forKey: "createTime") as! NSNumber
        timeL.text = "2018/04/12 13:23"
        
        

        likeBtn.isSelected = dict.value(forKey: "liked") as! Bool
        likeBtn.setTitle((dict.value(forKey: "likeCount") as! NSNumber).stringValue, for:.normal)
        likeBtn.titleEdgeInsets = UIEdgeInsets.init(top: 4, left: -likeBtn.imageView!.frame.size.width-2, bottom: 0, right: likeBtn.imageView!.frame.size.width)
        likeBtn.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: likeBtn.titleLabel!.frame.size.width+2, bottom: 0, right: -likeBtn.titleLabel!.frame.size.width)
        
        
    }
   @objc func userInfoDidClick() {
        userInfoClick(["111":"3333"])
    }
    
    func setupView() {
        
//        self.contentView.backgroundColor = randomColor()
        let padding:CGFloat = 10
        icon = UIButton.init(frame: CGRect.init(x: padding, y: 5, width: 30, height: 30))
        icon.layer.cornerRadius = 15
        icon.layer.masksToBounds = true
        icon.addTarget(self, action: #selector(userInfoDidClick), for: .touchUpInside)
        self.contentView.addSubview(icon)
        
        nameL = UIButton.init(frame: CGRect.init(x: icon.frame.maxX + padding, y: icon.frame.origin.y, width: 200, height: 13))
        nameL.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        nameL.setTitleColor(UIColor.init(white: 70/255.0, alpha: 1), for: .normal)
        nameL.center = CGPoint.init(x: nameL.center.x, y: icon.center.y)
        nameL.contentHorizontalAlignment = .left;
        nameL.addTarget(self, action: #selector(userInfoDidClick), for: .touchUpInside)
        self.contentView.addSubview(nameL)
        
        postWay = UILabel.init(frame: CGRect.init(x: icon.frame.maxX + padding, y: icon.frame.maxY - 11, width: 100, height: 11))
        postWay.font = UIFont.systemFont(ofSize: 11)
        postWay.textColor = AppDarkColor
        self.contentView.addSubview(postWay)
        
        textLL = UILabel.init(frame: CGRect.init(x: icon.frame.maxX + padding, y: postWay.frame.maxY + padding, width:SCREEN_WIDTH-icon.frame.maxX-15-padding, height: 150))
        textLL.font = UIFont.systemFont(ofSize: 15)
        textLL.numberOfLines = 0
        textLL.textColor = UIColor.init(white: 50/255.0, alpha: 1)
        self.contentView.addSubview(textLL)

        
        var ddd = self.contentView.frame.size.height - 30 - padding
        if isRepost {
            let repostView = UIView.init(frame: CGRect.init(x: icon.frame.maxX + padding, y: 80 + padding, width: textLL.frame.size.width, height: 90))
            repostView.backgroundColor = UIColor.init(white: 240/255.0, alpha: 1)
            repostView.layer.cornerRadius = 5
            repostView.layer.masksToBounds = true
            
            let subImg = UIImageView.init(image: UIImage.init(named: "1111.png"))
            subImg.frame = CGRect.init(x: 15, y: 11.5, width: 120, height: 67)
            subImg.layer.cornerRadius = 5
            subImg.layer.masksToBounds = true
            repostView.addSubview(subImg)
            
            let lr = UILabel.init(frame: CGRect.init(x: subImg.frame.maxX + padding, y:11.5, width: repostView.frame.width-subImg.frame.maxX - 30, height: 30))
            lr.font = UIFont.systemFont(ofSize: 13.0, weight: .bold)
            lr.text = "知你喜好,为你调酒"
            repostView.addSubview(lr)
            
            let tag = UILabel.init(frame: CGRect.init(x: subImg.frame.maxX + padding, y:lr.frame.maxY , width: repostView.frame.width-subImg.frame.maxX - 30, height: 30))
            tag.font = UIFont.systemFont(ofSize: 12.0, weight:.thin)
            tag.text = "#广告#"
            repostView.addSubview(tag)
            self.contentView.addSubview(repostView)
        
        
            let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapAction))
            repostView.addGestureRecognizer(tap)
            
            ddd = repostView.frame.maxY + padding
        }
        
        
        reply = UIButton.init(frame: CGRect.init(x: icon.frame.maxX + padding, y: ddd, width: 28, height: 30))
        reply.setTitle("回复", for: .normal)
        reply.setTitleColor(UIColor.lightGray, for: .normal)
        reply.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        reply.addTarget(self, action: #selector(replyBtnClick), for: .touchUpInside)
        self.contentView.addSubview(reply)
        reply.snp.makeConstraints { (make) in
            make.left.equalTo(icon.snp.right).offset(+padding)
            make.bottom.equalTo(self.contentView.snp.bottom).offset(-padding)
        }
        
        
        timeL = UILabel.init(frame: CGRect.init(x: reply.frame.maxX + 20, y: ddd, width: 80, height: 13))
        timeL.font = UIFont.systemFont(ofSize: 13)
        timeL.textColor = AppDarkColor
        timeL.center = CGPoint.init(x: timeL.center.x, y: reply.center.y)
        self.contentView.addSubview(timeL)
        timeL.snp.makeConstraints { (make) in
            make.centerY.equalTo(reply.snp.centerY)
            make.left.equalTo(reply.snp.right).offset(+20)
        }
        
        reply.center = CGPoint.init(x: reply.center.x, y: timeL.center.y)
        
        likeBtn = UIButton.init(frame: CGRect.init(x: SCREEN_WIDTH - 60, y: reply.frame.origin.y, width: 50, height: 50))
        likeBtn.setImage(UIImage.init(named: "cm2_act_icn_praise_prs"), for: .normal)
        likeBtn.setImage(UIImage.init(named: "cm2_act_icn_praised"), for: .selected)
        likeBtn.addTarget(self, action: #selector(likeBtnClick(btn:)), for: .touchUpInside)
        likeBtn.setTitleColor(AppRedColor, for: .selected)
        likeBtn.setTitleColor(AppDarkColor, for: .normal)
        likeBtn.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        likeBtn.center = CGPoint.init(x: likeBtn.center.x, y: reply.center.y)
        self.contentView.addSubview(likeBtn)
        likeBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(timeL.snp.centerY)
            make.right.equalTo(self.contentView.snp.right).offset(-padding*2)
        }
        
    }
    
    
    @objc func likeBtnClick(btn:UIButton) {
        let title = btn.titleLabel?.text
        btn.isSelected = !btn.isSelected
        let new = btn.isSelected ? String(Int(title!)!+1):String(Int(title!)!-1)
        btn.setTitle(new, for: .normal)
        
    }
    
    
    
    @objc func tapAction() {
    
        let detail = VideoDetailView()
        detail.data = JSON[0]
        detail.currentIndex = IndexPath.init(row: -1, section: -1)
        
        UIApplication.shared.keyWindow?.rootViewController?.present(detail, animated: true, completion: nil)
    }
    
    @objc func replyBtnClick() {
//        AppTool.checkLogin()
        
        let generator = UIImpactFeedbackGenerator.init(style: .light)
        generator.prepare()
        generator.impactOccurred()
        
        

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
   

}
