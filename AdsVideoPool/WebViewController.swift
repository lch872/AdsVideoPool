//
//  WebViewController.swift
//  AdsVideoPool
//
//  Created by lch on 2018/4/8.
//  Copyright © 2018年 ONEWAY. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    var web = WKWebView()
    override func viewDidLoad() {
        super.viewDidLoad()

        web = WKWebView.init(frame: self.view.bounds)
        self.view.addSubview(web)
        
        self.navigationItem.title = "来源地址"
        
        let leftBtn = UIBarButtonItem.init(title: "关闭", style: .done, target: self, action: #selector(closeVC))
        
        self.navigationItem.rightBarButtonItem = leftBtn
    }

    func loadURL(url:String){
       
    }
    
    @objc func closeVC(){
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
         web.load(URLRequest.init(url: URL.init(string: "http://www.qq.com")!))
    }
    
}
