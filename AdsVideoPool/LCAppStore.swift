//
//  LCAppStore.swift
//  AdsVideoPool
//
//  Created by lch on 2018/4/12.
//  Copyright © 2018年 ONEWAY. All rights reserved.
//

import UIKit
import StoreKit
import AVKit
class LCAppStore: SKStoreProductViewController {
    
    
    
    var player = AVPlayer()
    
    override func viewWillAppear(_ animated: Bool) {
        
        return
        let video = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_WIDTH/16*9))
        video.backgroundColor = UIColor.white
        self.view.addSubview(video)
        
        
        let filePath = Bundle.main.path(forResource: "cijizhanchang.mp4" as! String, ofType:nil)
        let videoURL = URL(fileURLWithPath: filePath!)
        
        player = AVPlayer.init(url: videoURL)
        let layer = AVPlayerLayer.init(player: player)
        layer.frame = video.bounds
        video.layer.addSublayer(layer)
        
        player.play()
        
        
        let firstView = self.view.subviews.first as! UIView

        firstView.frame = CGRect.init(x: firstView.frame.origin.x, y: SCREEN_WIDTH/16*9, width: firstView.frame.size.width, height: firstView.frame.size.height)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        player.pause()
    }
 
    deinit {
        print("dssssss")
    }
}
