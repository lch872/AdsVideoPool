//
//  AdLinkView.swift
//  AdsVideoPool
//
//  Created by lch on 2018/4/2.
//  Copyright © 2018年 ONEWAY. All rights reserved.
//

import UIKit

class AdLinkView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupView(){
        
//        let img = UIImageView.init(image: UIImage.init(named: "icon.png"))
//        img.contentMode = .scaleToFill
//        img.frame = self.bounds
//        self.addSubview(img)
////
        
        let effect = UIBlurEffect.init(style: .light)
        let effectView = UIVisualEffectView.init(effect: effect)
        effectView.frame = self.bounds
        self.addSubview(effectView)
        
//        let vibrancyEffect = UIVibrancyEffect(blurEffect: effect)
//        let vibrancyView = UIVisualEffectView(effect:vibrancyEffect)
//        vibrancyView.frame = self.bounds
//        effectView.contentView.addSubview(vibrancyView)
        
        //图标
        let icon = UIImageView.init(frame: CGRect.init(x: 10, y: 2.5, width: 55, height: 55))
        icon.image = UIImage.init(named: "icon.png")
        self.addSubview(icon)
        
        
        //title
        let labe = UILabel.init(frame: CGRect.init(x: icon.frame.maxX + 5, y: icon.frame.origin.y + 5, width: 200, height: 20))
        labe.text = "绝地求生:刺激战场"
        labe.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(labe)
        
        //sub-title
        let sub = UILabel.init(frame: CGRect.init(x: icon.frame.maxX + 5, y: labe.frame.maxY + 3, width: 200, height: 20))
         sub.font = UIFont.systemFont(ofSize: 12)
        sub.text = "正版吃鸡 新春全新版本"
        self.addSubview(sub)
        
        self.layer.cornerRadius = 15
        self.layer.masksToBounds = true
        
    }
}
