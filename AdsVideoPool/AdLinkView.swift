//
//  AdLinkView.swift
//  AdsVideoPool
//
//  Created by lch on 2018/4/2.
//  Copyright © 2018年 ONEWAY. All rights reserved.
//

import UIKit
import StoreKit
class AdLinkView: UIView, SKStoreProductViewControllerDelegate{

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupView(){
        
        let img = UIImageView.init(image: UIImage.init(named: "icon2.png"))
        img.contentMode = .scaleToFill
        img.frame = self.bounds
        self.addSubview(img)
        
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
        icon.image = UIImage.init(named: "icon2.png")
        self.addSubview(icon)
        
        
        //title
        let labe = UILabel.init(frame: CGRect.init(x: icon.frame.maxX + 5, y: icon.frame.origin.y + 5, width: 200, height: 20))
        labe.text = "绝地求生:刺激战场"
        labe.font = UIFont.systemFont(ofSize: 14.0, weight: .semibold)
        labe.textColor = UIColor.white
        self.addSubview(labe)
        
        //sub-title
        let sub = UILabel.init(frame: CGRect.init(x: icon.frame.maxX + 5, y: labe.frame.maxY + 3, width: 200, height: 20))
         sub.font = UIFont.systemFont(ofSize: 12.0, weight: .semibold)
        sub.text = "正版吃鸡 新春全新版本"
        sub.textColor = UIColor.white
        self.addSubview(sub)
        
        //ddd
        let focus = UIButton.init(frame: CGRect.init(x: self.frame.width - 70,   y: 0, width: 50, height: 20))
        focus.setTitle("获 取", for: .normal)
        focus.titleLabel?.font = UIFont.systemFont(ofSize: 14.0, weight: .semibold)
        focus.setBackgroundImage(UIImage.init(named: "cm4_list_btn_focus_prs"), for: .normal)
        focus.setBackgroundImage(UIImage.init(named: "cm4_list_btn_focus_prs"), for: .highlighted)
        focus.setTitleColor(UIColor.white, for: .normal)
        focus.isUserInteractionEnabled = false
        focus.center = CGPoint.init(x: focus.center.x, y: icon.center.y)
        self.addSubview(focus)
        
        self.layer.cornerRadius = 15
        self.layer.masksToBounds = true
    }
    
    
    let appStore = LCAppStore()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        let url = URL.init(string: "https://itunes.apple.com/cn/app/id1321803705")
//        UIApplication.shared.open(url!, options: [:], completionHandler: nil)
        
        
        appStore.delegate = self
        appStore.loadProduct(withParameters: ["id":"1321803705"], completionBlock: nil)
        UIApplication.shared.keyWindow?.rootViewController?.present(appStore, animated: true, completion: nil)
    }
    
    func productViewControllerDidFinish(_ viewController: SKStoreProductViewController) {
        appStore.dismiss(animated: true, completion: nil)
    }
}
