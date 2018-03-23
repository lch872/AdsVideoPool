//
//  CommentView.swift
//  AdsVideoPool
//
//  Created by lch on 2018/3/20.
//  Copyright © 2018年 ONEWAY. All rights reserved.
//

import UIKit

class CommentView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        //分割线
        let line = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.bounds.width, height: 0.5))
        line.backgroundColor = UIColor.init(white: 203/255.0, alpha: 1)
        self.addSubview(line)
        
        //输入框
        let textF = UITextField.init(frame: CGRect.init(x: 10, y: 10, width: self.bounds.width - 60, height: 30))
        textF.placeholder = "发表评论"
        
        textF.leftView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 10, height: 10))
        textF.leftViewMode = .always
        textF.layer.borderWidth = 0.5;
        textF.layer.cornerRadius = 14;
        textF.layer.borderColor = UIColor.lightGray.cgColor
        self.addSubview(textF)
        
        //按钮
        let btn = UIButton.init(frame: CGRect.init(x: textF.frame.maxX + 10, y: 10, width: 30, height: 30))
        btn.setImage(UIImage.init(named: "top"), for: .normal)
        self.addSubview(btn)
        
        
        
    }
}
