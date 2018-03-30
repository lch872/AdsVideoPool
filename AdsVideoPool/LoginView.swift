//
//  LoginView.swift
//  AdsVideoPool
//
//  Created by lch on 2018/3/30.
//  Copyright © 2018年 ONEWAY. All rights reserved.
//

import UIKit

class LoginView: UIViewController {
    
    @IBOutlet weak var logoView: UIImageView!
    @IBOutlet weak var bgView: UIImageView!
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var registerBtn: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        UIView.animate(withDuration: 10.0) {
            self.logoView.alpha = 1
            self.bgView.transform = CGAffineTransform.identity
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.logoView.alpha = 0
        self.bgView.transform = CGAffineTransform.init(scaleX: 1.2, y: 1.2)
        
        self.username.setValue(UIColor.lightGray, forKeyPath: "_placeholderLabel.textColor")
        self.password.setValue(UIColor.lightGray, forKeyPath: "_placeholderLabel.textColor")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismiss(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func forgetBtnClick(_ sender: UIButton) {
    }
    
    @IBAction func agreementClick(_ sender: UIButton) {
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}
