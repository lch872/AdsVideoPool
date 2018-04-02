//
//  MineView.swift
//  AdsVideoPool
//
//  Created by lch on 2018/3/30.
//  Copyright © 2018年 ONEWAY. All rights reserved.
//

import UIKit

class MineView: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var iconBtn: UIButton!
    @IBOutlet weak var iconText: UILabel!
    
    

    
    

    @IBOutlet weak var tableview: UITableView!
    
    let titleData:[String] = ["我的关注", "观看记录", "功能开关", "意见反馈"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableview.dataSource = self
        tableview.delegate = self
        
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "mineCell")
        tableview.separatorStyle = .none
        tableview.rowHeight = 100
        
        iconBtn.adjustsImageWhenHighlighted = false
        iconBtn.showsTouchWhenHighlighted = false
        
        let dd = AdLinkView.init(frame: CGRect.init(x: 10, y: 500, width: SCREEN_WIDTH - 20, height: 60))
        self.view.addSubview(dd)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mineCell", for: indexPath)
        
        cell.textLabel?.text = titleData[indexPath.row]
        cell.textLabel?.textAlignment = .center
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        AppTool.checkLogin()
    }

    @IBAction func likeListBtn(_ sender: UIButton) {
        AppTool.checkLogin()
    }
    
    @IBAction func downloadClick(_ sender: UIButton) {
    }
    
    @IBAction func iconBtnDidClick(_ sender: UIButton) {
        AppTool.checkLogin()
    }
}
