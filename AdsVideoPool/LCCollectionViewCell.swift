//
//  LCCollectionViewCell.swift
//  AdsVideoPool
//
//  Created by lch on 2018/3/19.
//  Copyright © 2018年 ONEWAY. All rights reserved.
//

import UIKit
import AVKit

class LCCollectionViewCell: UICollectionViewCell {
    
    
    var data:[String:String] = ["":""]
    {
        didSet
        {
            setupView()
        }
    }
    
    var isScaled = false
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        NotificationCenter.default.addObserver(self, selector: #selector(makeOriginal), name: NSNotification.Name(rawValue: "makeOriginal"), object: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupView() {
        let filePath = Bundle.main.path(forResource: data["videoName"], ofType:nil)
        let videoURL = URL(fileURLWithPath: filePath!)
        //定义一个视频播放器，通过本地文件路径初始化
        let player = AVPlayer(url: videoURL)
        //设置大小和位置（全屏）
        let playerLayer = AVPlayerLayer(player: player)
        
        let div:Float = Float(data["height"]!)!/Float(data["width"]!)!
        print(div)
        playerLayer.frame = CGRect.init(x: 0, y: 0, width: self.bounds.width, height: CGFloat(div)*self.bounds.width)
        //添加到界面上
        self.layer.addSublayer(playerLayer)
        //开始播放
        player.play()
        
        
        let padding:CGFloat = 18
        let width:CGFloat = self.bounds.width - padding*2
        
        let tag = UILabel.init(frame: CGRect.init(x: padding, y: playerLayer.frame.maxY + 20, width: width, height: 20))
        tag.textColor = UIColor.lightGray
        tag.text = data["tag"]
        self.addSubview(tag)
        
        let title = UILabel.init(frame: CGRect.init(x: padding, y: tag.frame.maxY + 10, width: width, height: 35))
        title.text = data["title"]
        title.font = UIFont.boldSystemFont(ofSize: 30.0)
        self.addSubview(title)
        
        
        let detail = UILabel.init(frame: CGRect.init(x: padding, y: title.frame.maxY + 5 , width: width, height: 45))
        detail.text = data["detail"]
        detail.lineBreakMode = .byWordWrapping
        detail.numberOfLines = 0
        
        detail.textColor = UIColor.lightGray
        self.addSubview(detail)
        
        
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if !isScaled {
            isScaled = true
            UIView.animate(withDuration: 0.28) {
                self.transform = self.transform.scaledBy(x: 0.96, y: 0.96)
            }
        }
    }
    
    @objc func makeOriginal() {
        if isScaled {
            isScaled = false
            UIView.animate(withDuration: 0.28) {
                self.transform = CGAffineTransform.identity
            }
        }
    }
}
