//
//  CommentView.swift
//  AdsVideoPool
//
//  Created by lch on 2018/3/20.
//  Copyright © 2018年 ONEWAY. All rights reserved.
//

import UIKit
import MBProgressHUD
class CommentInputView: UIView, UITextFieldDelegate {

    
    var click:(Bool)->Void = { (name:Bool) -> Void in
        
    }
    
//    var replyDidClick:(String)->Void = { (name:String) -> Void in
//        print("\(name)")
//    }
    
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
        
        
        //按钮
        let btn = UIButton.init(frame: CGRect.init(x: 10, y: 10, width: 30, height: 30))
        btn.addTarget(self, action: #selector(buttonDidClick), for: .touchUpInside)
        btn.setImage(UIImage.init(named: "cm2_act_icn_cmt_prs"), for: .selected)
        btn.setImage(UIImage.init(named: "top"), for: .normal)
        self.addSubview(btn)
        
        
        //输入框
        let textF = UITextField.init(frame: CGRect.init(x: btn.frame.maxX, y: 10, width: self.bounds.width - 60, height: 30))
        textF.placeholder = "发表评论"
        
        textF.leftView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 10, height: 10))
        textF.leftViewMode = .always
        textF.layer.borderWidth = 0.5;
        textF.layer.cornerRadius = 14;
        textF.layer.borderColor = UIColor.lightGray.cgColor
        textF.returnKeyType = .send
        textF.delegate = self
        self.addSubview(textF)
        
      
      
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        
        self.endEditing(true)
        //只显示文字
        let hud = MBProgressHUD.showAdded(to: self.superview!, animated: true)
        hud.mode = .text
        hud.label.text = "发表成功!"
        hud.margin = 10
        hud.offset.y = 50
        hud.removeFromSuperViewOnHide = true
        hud.hide(animated: true, afterDelay: 2.0)
        
        return true

    }
    
    @objc func buttonDidClick(_ btn:UIButton){
        btn.isSelected = !btn.isSelected
        self.click(!btn.isSelected)
    }
}
