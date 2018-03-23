//
//  LCCollectionViewCell.swift
//  AdsVideoPool
//
//  Created by lch on 2018/3/19.
//  Copyright © 2018年 ONEWAY. All rights reserved.
//

import UIKit
import AVKit
import SnapKit

class MainViewCell: UITableViewCell {
    
    
    var data:[String:String] = ["":""]
    {
        didSet
        {
            setupData()
        }
    }
    
    var isScaled = false
    var playerView = AVPlayerView()
    
    var screenImg = UIView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.clear;
        self.contentView.backgroundColor = UIColor.clear;
        setupView()
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    var tagL = UILabel()
    var title = UILabel()
    var detail = UILabel()
    var bgView = UIView()
    
    func setupData(){
        tagL.text = data["tag"]
        title.text = data["title"]
        detail.text = data["detail"]
        
        let filePath = Bundle.main.path(forResource: data["videoName"], ofType:nil)
        let videoURL = URL(fileURLWithPath: filePath!)
        let viewItem = AVPlayerItem.init(url: videoURL)
        
        playerView.playWithItem(item: viewItem)
        //开始播放
//        avPlayer.replaceCurrentItem(with: viewItem)
//        avPlayer.play()
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let div:Float = Float(data["height"]!)!/Float(data["width"]!)!
        playerView.frame = CGRect.init(x: (-SCREEN_WIDTH+bgView.bounds.width)/2.0, y: 0, width: SCREEN_WIDTH, height: CGFloat(div)*bgView.bounds.width)
    
    }
    func setupView() {
        print("创建")
        bgView = UIView.init(frame: CGRect.init(x: 20, y: 0, width: SCREEN_WIDTH-40, height: (SCREEN_WIDTH-40)*1.3))
        bgView.layer.cornerRadius = 15;
        bgView.layer.masksToBounds = true;
        bgView.backgroundColor = UIColor.white
        self.contentView.addSubview(bgView)
        
        let div:Float = 0.56
        playerView = AVPlayerView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: CGFloat(div)*bgView.bounds.width))
        bgView.addSubview(playerView)

        
        
        
        let padding:CGFloat = 18
        let width:CGFloat = self.bounds.width - padding*2
        tagL = UILabel.init(frame: CGRect.init(x: 0, y:0, width: width, height: 20))
        tagL.textColor = UIColor.lightGray
        tagL.font = UIFont.boldSystemFont(ofSize: 15)
        tagL.isOpaque = false
       
        bgView.addSubview(tagL)
        tagL.snp.makeConstraints { (make) in
            make.left.equalTo(padding)
            make.top.equalTo(playerView.snp.bottom).offset(+20)
        }
        
        
        title = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: width, height: 30))
        title.font = UIFont.boldSystemFont(ofSize: 25.0)
        title.isOpaque = false
        bgView.addSubview(title)
        title.snp.makeConstraints { (make) in
            make.left.equalTo(tagL.snp.left)
            make.top.equalTo(tagL.snp.bottom).offset(+10)
        }
        
        
        detail = UILabel.init(frame: CGRect.init(x: 0, y: 0 , width: width, height: 45))
        detail.lineBreakMode = .byWordWrapping
        detail.numberOfLines = 0
        detail.isOpaque = false
        detail.textColor = UIColor.lightGray
        detail.font = UIFont.boldSystemFont(ofSize: 16.0)
        bgView.addSubview(detail)
        detail.snp.makeConstraints { (make) in
            make.left.equalTo(tagL.snp.left)
            make.top.equalTo(title.snp.bottom).offset(+5)
            make.width.equalTo(bgView.snp.width).offset(-padding*2)
        }

    }
    

    
    
 
    
    
    
}
