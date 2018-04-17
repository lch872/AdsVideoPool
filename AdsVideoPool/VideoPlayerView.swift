//
//  Videoself.swift
//  AdsVideoPool
//
//  Created by lch on 2018/4/11.
//  Copyright © 2018年 ONEWAY. All rights reserved.
//

import UIKit

class VideoPlayerView: UIView {

    
    var data:[String:String] = ["":""]
    {
        didSet{
            setupView()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    var control = UIView()
    var postIcon = UIButton()
    var playBtn = UIButton()
    var playNum = UIButton()
    var length = UIButton()
    var adTag = UIButton()
    
    var bgImage = UIImageView()
    

    func setupView() {
        bgImage = UIImageView.init(frame: self.bounds)
        self.addSubview(bgImage)
        
        control = UIView.init(frame: self.bounds)
        //        bgView.insertSubview(control, aboveSubview: self)
//        control.backgroundColor = randomColor(alp: 0.4)
        self.addSubview(control)
        self.isUserInteractionEnabled = true
        
//        postIcon = UIButton.init(frame: CGRect.init(x: 5, y: 5, width: 25, height: 25))
//        postIcon.setImage(UIImage.init(named: "postIcon"), for: .normal)
//        control.addSubview(postIcon)
        
        adTag = UIButton.init(frame: CGRect.init(x: self.frame.width - 35, y: 5, width: 30, height: 12))
        adTag.setTitle("广告", for: .normal)
        adTag.setBackgroundImage(UIImage.init(named: "cm2_mv_center_bg"), for: .normal)
        adTag.isHidden = true
        adTag.setTitleColor(UIColor.white, for: .normal)
        adTag.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        control.addSubview(adTag)
        
        //播放暂停
        playBtn = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 100, height: 100))
        playBtn.setImage(UIImage.init(named: "播放"), for: .selected)
        playBtn.center = control.center
        playBtn.addTarget(self, action: #selector(pauseDidClick(btn:)), for: .touchUpInside)
        control.addSubview(playBtn)
        
        
        //观看量
        playNum = imgBtn(imgName: "观看数", title: "24万", frame: CGRect.init(x: 3, y: self.frame.height - 30, width: 50, height: 30))
        playNum.setTitleColor(UIColor.white, for: .normal)
        control.addSubview(playNum)
        
        length = imgBtn(imgName: "时长", title: data["length"]!, frame: CGRect.init(x: self.frame.width - 50, y: self.frame.height - 30, width: 50, height: 30))
        length.setTitleColor(UIColor.white, for: .normal)
        //        length.titleLabel?.font = UIFont.systemFont(ofSize: <#T##CGFloat#>, weight: <#T##UIFont.Weight#>)
        control.addSubview(length)
    }
    
  
    
    func hideView(_ isHide:Bool, delay:Double) {
        
        
        let alp:CGFloat = isHide ? 0.0 : 1.0
        let time = isHide ? 1 : 0
        UIView.animate(withDuration: TimeInterval(time), delay: delay, options: .curveLinear, animations: {
            self.postIcon.alpha = alp
            self.playNum.alpha = alp
            self.length.alpha = alp
        }, completion: nil)
 
        
    }
    
    override func layoutSubviews() {
        bgImage.frame = self.bounds
        control.frame = self.bounds
        playNum.frame = CGRect.init(x: 3, y: self.frame.height - 30, width: 50, height: 30)
        length.frame = CGRect.init(x: self.frame.width - 60, y: self.frame.height - 30, width: 60, height: 30)
        playBtn.center = control.center
        adTag.frame =  CGRect.init(x: self.frame.width - 30, y: 5, width: 25, height: 13)
        
        self.bringSubview(toFront: control)
        
        self.refreshIndicatorViewForPortrait()
        super.layoutSubviews()
    }
    
    @objc func pauseDidClick(btn:UIButton){
        btn.isSelected = !btn.isSelected

        if btn.isSelected {
            self.jp_pause()
            self.hideView(false, delay: 0)
        }else{
            self.jp_resume()
            self.hideView(true, delay: 0.7)
            
//            let lll = LCAppStore()
//            lll.loadProduct(withParameters: ["id":"444934666"], completionBlock: nil)
//            UIApplication.shared.keyWindow?.rootViewController?.present(lll, animated: true, completion: nil)
            
        }

    }
    
    
    
    
}
