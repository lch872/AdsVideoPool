//
//  CommentCell.swift
//  AdsVideoPool
//
//  Created by lch on 2018/3/20.
//  Copyright © 2018年 ONEWAY. All rights reserved.
//

import UIKit
import Kingfisher
import SnapKit

class CommentCell: UITableViewCell {
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
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
    
    func setupData() {
        let dict = self.data["data"] as! NSDictionary
        
        
        
        let namn =  dict["user"] as? NSDictionary
        let avatar = namn!["avatar"] as! String
        let url = URL(string: avatar)
        icon.kf.setImage(with: url, for: .normal)
        
        nameL.text = namn!["nickname"] as! String
        
        let ddd = dict.value(forKey: "createTime") as! NSNumber
        timeL.text = timeStampToString(timeStamp: ddd.stringValue)

        textLL.text = dict.value(forKey: "message") as! String!
        textLL.sizeToFit()
        let size = textLL.sizeThatFits(CGSize.init(width: SCREEN_WIDTH-icon.frame.maxX-15-10, height: CGFloat(MAXFLOAT)))
        textLL.frame = CGRect.init(x: textLL.frame.origin.x, y: textLL.frame.origin.y, width: SCREEN_WIDTH-icon.frame.maxX-15-10, height: size.height)

        likeNumber.text = (dict.value(forKey: "likeCount") as! NSNumber).stringValue
        
        likeBtn.isSelected = dict.value(forKey: "liked") as! Bool
         likeNumber.textColor = likeBtn.isSelected ? (AppRedColor) : AppDarkColor
    
    }
    
    func setupView() {
        let padding:CGFloat = 10
        icon = UIButton.init(frame: CGRect.init(x: padding, y: 5, width: 30, height: 30))
        icon.layer.cornerRadius = 15
        icon.layer.masksToBounds = true
        self.contentView.addSubview(icon)
//        icon.snp.makeConstraints { make in
//            make.top.equalTo(icon.superview!.snp.bottom).offset(5)
//            make.size.equalTo(CGSize.init(width: 30, height: 30))
//            make.left.equalTo(icon.superview!.snp.left).offset(5)
//        }
        
        
        
        nameL = UILabel.init(frame: CGRect.init(x: icon.frame.maxX + padding, y: icon.frame.origin.y + 3, width: 200, height: 13))
        nameL.font = UIFont.systemFont(ofSize: 13)
        nameL.textColor = UIColor.init(white: 70/255.0, alpha: 1)
        self.contentView.addSubview(nameL)
        
        timeL = UILabel.init(frame: CGRect.init(x: icon.frame.maxX + padding, y: nameL.frame.maxY + 2, width: 100, height: 9))
        timeL.font = UIFont.systemFont(ofSize: 9)
        timeL.textColor = AppDarkColor
        self.contentView.addSubview(timeL)
        
        
        likeBtn = UIButton.init(frame: CGRect.init(x: SCREEN_WIDTH - 30, y: nameL.frame.origin.y, width: 20, height: 20))
        likeBtn.setImage(UIImage.init(named: "cm2_act_icn_praise_prs"), for: .normal)
        likeBtn.setImage(UIImage.init(named: "cm2_act_icn_praised"), for: .selected)
        likeBtn.addTarget(self, action: #selector(likeBtnClick), for: .touchUpInside)
        self.contentView.addSubview(likeBtn)
        
        
        likeNumber = UILabel.init(frame: CGRect.init(x: likeBtn.frame.minX - 100, y: nameL.frame.origin.y, width: 100, height: 15))
        likeNumber.font = UIFont.systemFont(ofSize: 10)
        likeNumber.textColor = AppDarkColor
        likeNumber.textAlignment = .right
        likeNumber.center = CGPoint.init(x: likeNumber.center.x, y: likeBtn.center.y + 2)
        self.contentView.addSubview(likeNumber)
        
        
        textLL = UILabel.init(frame: CGRect.init(x: icon.frame.maxX + padding, y: timeL.frame.maxY + padding, width:SCREEN_WIDTH-icon.frame.maxX-15-padding, height: 150))
        textLL.font = UIFont.systemFont(ofSize: 15)
        textLL.numberOfLines = 0
        
        textLL.textColor = UIColor.init(white: 50/255.0, alpha: 1)
        self.contentView.addSubview(textLL)
    }
    
    @objc func likeBtnClick(_ btn:UIButton) {
        btn.isSelected = !btn.isSelected
        likeNumber.textColor = btn.isSelected ? (AppRedColor) : AppDarkColor
    }
    
    

}
