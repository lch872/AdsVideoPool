//
//  MYLayer.swift
//  AdsVideoPool
//
//  Created by lch on 2018/3/26.
//  Copyright © 2018年 ONEWAY. All rights reserved.
//

import UIKit
import AVKit

class MYLayer: AVPlayerLayer {
    
    
    override var frame: CGRect {
        get {
            return super.frame
        }
        set {
        super.frame = newValue
        }
    }
    
    override init(layer: Any) {
        super.init(layer: layer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
