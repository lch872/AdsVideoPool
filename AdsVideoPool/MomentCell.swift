//
//  MomentCell.swift
//  AdsVideoPool
//
//  Created by lch on 2018/3/30.
//  Copyright © 2018年 ONEWAY. All rights reserved.
//

import UIKit
import AVKit

class MomentCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        data = NSDictionary()
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var data:NSDictionary{
        didSet{
            setupData()
        }
    }
    
    var nameL = UILabel()
    var timeL = UILabel()
    var likeNumber = UILabel()
    var textLL = UILabel()
    var icon = UIButton()
    var likeBtn = UIButton()
    var postWay = UILabel()
    
    func setupData() {
        let dict = self.data["data"] as! NSDictionary
        
        let namn =  dict["user"] as? NSDictionary
        let avatar = namn!["avatar"] as! String
        let url = URL(string: avatar)
        icon.kf.setImage(with: url, for: .normal)
        
        nameL.text = namn!["nickname"] as! String
        
//        let ddd = dict.value(forKey: "createTime") as! NSNumber
        postWay.text = "评论了:"
        
        textLL.text = dict.value(forKey: "message") as! String!
        textLL.sizeToFit()
        let size = textLL.sizeThatFits(CGSize.init(width: SCREEN_WIDTH-icon.frame.maxX-15-10, height: CGFloat(MAXFLOAT)))
        textLL.frame = CGRect.init(x: textLL.frame.origin.x, y: textLL.frame.origin.y, width: SCREEN_WIDTH-icon.frame.maxX-15-10, height: size.height)
        
        timeL.text = "2018/03/12"

        likeBtn.isSelected = dict.value(forKey: "liked") as! Bool
        
        likeNumber.text = (dict.value(forKey: "likeCount") as! NSNumber).stringValue
        likeNumber.textColor = likeBtn.isSelected ? (UIColor.init(red: 211/255.0, green: 58/255.0, blue: 41/255.0, alpha: 1)) : UIColor.init(white: 168/255.0, alpha: 1)
        
    }
    
    func setupView() {
        let padding:CGFloat = 10
        icon = UIButton.init(frame: CGRect.init(x: padding, y: 5, width: 30, height: 30))
        icon.layer.cornerRadius = 15
        icon.layer.masksToBounds = true
        self.contentView.addSubview(icon)
        
        nameL = UILabel.init(frame: CGRect.init(x: icon.frame.maxX + padding, y: icon.frame.origin.y, width: 200, height: 13))
        nameL.font = UIFont.systemFont(ofSize: 13)
        nameL.textColor = UIColor.init(white: 70/255.0, alpha: 1)
        self.contentView.addSubview(nameL)
        
        postWay = UILabel.init(frame: CGRect.init(x: icon.frame.maxX + padding, y: icon.frame.maxY - 11, width: 100, height: 11))
        postWay.font = UIFont.systemFont(ofSize: 11)
        postWay.textColor = UIColor.init(white: 168/255.0, alpha: 1)
        self.contentView.addSubview(postWay)
        
        textLL = UILabel.init(frame: CGRect.init(x: icon.frame.maxX + padding, y: postWay.frame.maxY + padding, width:SCREEN_WIDTH-icon.frame.maxX-15-padding, height: 150))
        textLL.font = UIFont.systemFont(ofSize: 15)
        textLL.numberOfLines = 0
        textLL.textColor = UIColor.init(white: 50/255.0, alpha: 1)
        self.contentView.addSubview(textLL)

        
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
        
        let reply = UIButton.init(frame: CGRect.init(x: icon.frame.maxX + padding, y: repostView.frame.maxY + padding, width: 28, height: 30))
        reply.setTitle("回复", for: .normal)
        reply.setTitleColor(UIColor.lightGray, for: .normal)
        reply.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        reply.addTarget(self, action: #selector(replyBtnClick), for: .touchUpInside)
        self.contentView.addSubview(reply)
        
        
        timeL = UILabel.init(frame: CGRect.init(x: reply.frame.maxX + 50, y: reply.frame.origin.y, width: 80, height: 13))
        timeL.font = UIFont.systemFont(ofSize: 13)
        timeL.textColor = UIColor.init(white: 168/255.0, alpha: 1)
        timeL.center = CGPoint.init(x: timeL.center.x, y: reply.center.y)
        self.contentView.addSubview(timeL)
        
        
        
        likeBtn = UIButton.init(frame: CGRect.init(x: SCREEN_WIDTH - 30, y: reply.frame.origin.y, width: 20, height: 20))
        likeBtn.setImage(UIImage.init(named: "cm2_act_icn_praise_prs"), for: .normal)
        likeBtn.setImage(UIImage.init(named: "cm2_act_icn_praised"), for: .selected)
        //        likeBtn.addTarget(self, action: #selector(likeBtnClick), for: .touchUpInside)
        likeBtn.center = CGPoint.init(x: likeBtn.center.x, y: reply.center.y)
        self.contentView.addSubview(likeBtn)
        
        
        likeNumber = UILabel.init(frame: CGRect.init(x: likeBtn.frame.minX - 100, y: reply.frame.origin.y, width: 100, height: 15))
        likeNumber.font = UIFont.systemFont(ofSize: 10)
        likeNumber.textColor = UIColor.init(white: 168/255.0, alpha: 1)
        likeNumber.textAlignment = .right
        likeNumber.center = CGPoint.init(x: likeNumber.center.x, y: likeBtn.center.y + 2)
        self.contentView.addSubview(likeNumber)
        
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
