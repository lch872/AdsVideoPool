//
//  CommentCell.swift
//  AdsVideoPool
//
//  Created by lch on 2018/3/20.
//  Copyright © 2018年 ONEWAY. All rights reserved.
//

import UIKit

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
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
    
        
        let padding:CGFloat = 10
        let icon = UIButton.init(frame: CGRect.init(x: padding, y: 5, width: 30, height: 30))
        icon.setImage(UIImage.init(named: "111.png"), for: .normal)
        icon.layer.cornerRadius = 15
        icon.layer.masksToBounds = true
        self.contentView.addSubview(icon)
        
        let name = UILabel.init(frame: CGRect.init(x: icon.frame.maxX + padding, y: icon.frame.origin.y + 3, width: 200, height: 13))
        name.font = UIFont.systemFont(ofSize: 13)
        name.textColor = UIColor.init(white: 70/255.0, alpha: 1)
        name.text = "开心的凯西PPPaaa321"
        self.contentView.addSubview(name)
        
        let timeL = UILabel.init(frame: CGRect.init(x: icon.frame.maxX + padding, y: name.frame.maxY + 2, width: 100, height: 9))
        timeL.font = UIFont.systemFont(ofSize: 9)
        timeL.textColor = UIColor.init(white: 168/255.0, alpha: 1)
        timeL.text = "2017年11月31日"
        self.contentView.addSubview(timeL)
        
        
        let likeImg = UIImageView.init(frame: CGRect.init(x: SCREEN_WIDTH - 30, y: name.frame.origin.y, width: 20, height: 20))
        likeImg.image = UIImage.init(named: "like.png")
        self.contentView.addSubview(likeImg)
        
        
        let likeNumber = UILabel.init(frame: CGRect.init(x: likeImg.frame.minX - 100, y: name.frame.origin.y, width: 100, height: 15))
        likeNumber.font = UIFont.systemFont(ofSize: 10)
        likeNumber.textColor = UIColor.init(white: 168/255.0, alpha: 1)
        likeNumber.text = "144333"
        likeNumber.textAlignment = .right
        likeNumber.center = CGPoint.init(x: likeNumber.center.x, y: likeImg.center.y + 2)
        self.contentView.addSubview(likeNumber)
        
        
        let textLL = UILabel.init(frame: CGRect.init(x: icon.frame.maxX + padding, y: timeL.frame.maxY + padding, width:SCREEN_WIDTH-icon.frame.maxX-15-padding, height: 150))
        textLL.font = UIFont.systemFont(ofSize: 15)
        textLL.text = "漂亮还是漂亮，但是我真的觉得这个妹子像刚上岸的水鬼"
        textLL.numberOfLines = 0
        textLL.textColor = UIColor.init(white: 50/255.0, alpha: 1)
        textLL.sizeToFit()
        self.contentView.addSubview(textLL)
        
    }
    
    //MARK: - 动画
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self as? UIViewControllerAnimatedTransitioning
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1.0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        print("wwwwww")
    }

}
