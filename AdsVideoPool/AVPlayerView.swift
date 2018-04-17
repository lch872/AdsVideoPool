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
//    
//    
//   override var frame: CGRect{
//    didSet {
//        print("--------------")
//        print("old: \(super.frame)  \nnew: \(frame)")
//        super.frame = frame
//        }
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func playWithItem(item:AVPlayerItem) {
        avPlayer.replaceCurrentItem(with: item)
        avPlayer.volume = 0
        
    }
    
    
    func setupView() {
        avPlayer = AVPlayer.init()
        
        avPlayerLayer = AVPlayerLayer(player: avPlayer)
        self.layer.addSublayer(avPlayerLayer)
        
//        self.backgroundColor = UIColor.red
    }

//    
//    override func layoutSubviews() {
//        
////        CATransaction.begin()
////        CATransaction.setDisableActions(true)
////        print("self.bounds : \(self.bounds)")
////        print("self.avPlayerLayer.bounds : \(self.avPlayerLayer.bounds)")
//        
//        avPlayerLayer.frame = self.bounds
////        CATransaction.commit()
//        
//        super.layoutSubviews()
//    }
}
