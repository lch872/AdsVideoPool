//
//  AVPlayerView.swift
//  AdsVideoPool
//
//  Created by lch on 2018/3/23.
//  Copyright © 2018年 ONEWAY. All rights reserved.
//

import UIKit
import AVKit
class AVPlayerView: UIView {

    var avPlayer = AVPlayer()
    var avPlayerLayer = AVPlayerLayer()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func playWithItem(item:AVPlayerItem) {
        avPlayer.replaceCurrentItem(with: item)
        avPlayer.play()
    }
    
    
    func setupView() {
        avPlayer = AVPlayer.init()
        
        //设置大小和位置（全屏）
        avPlayerLayer = AVPlayerLayer(player: avPlayer)
        self.layer.addSublayer(avPlayerLayer)
    }

    
    override func layoutSubviews() {
        avPlayerLayer.frame = self.bounds
        super.layoutSubviews()
    }
}
