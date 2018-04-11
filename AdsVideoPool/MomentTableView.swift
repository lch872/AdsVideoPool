//
//  MomentTableView.swift
//  AdsVideoPool
//
//  Created by lch on 2018/3/30.
//  Copyright © 2018年 ONEWAY. All rights reserved.
//

import UIKit
import DGElasticPullToRefresh

class MomentTableView: UITableViewController {

    var jsonDic = NSDictionary()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "动态"
        let jsonPath = Bundle.main.path(forResource: "pinglun", ofType: "json")
        let data = NSData.init(contentsOfFile: jsonPath!)
        jsonDic = try! JSONSerialization.jsonObject(with: data! as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
        
        self.tableView.register(MomentCell.self, forCellReuseIdentifier: "MomentCell")
        self.tableView.rowHeight = 230
        
//        let loadingView = DGElasticPullToRefreshLoadingViewCircle()
//        loadingView.tintColor = UIColor(red: 78/255.0, green: 221/255.0, blue: 200/255.0, alpha: 1.0)
//        tableView.dg_addPullToRefreshWithActionHandler({ [weak self] () -> Void in
//            // Add your logic here
//            // Do not forget to call dg_stopLoading() at the end
//            self?.tableView.dg_stopLoading()
//            }, loadingView: loadingView)
//        tableView.dg_setPullToRefreshFillColor(UIColor(red: 57/255.0, green: 67/255.0, blue: 89/255.0, alpha: 1.0))
//        tableView.dg_setPullToRefreshBackgroundColor(tableView.backgroundColor!)
//
//        self.navigationController?.navigationBar.ba
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jsonDic.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let arr = jsonDic["itemList"] as! NSArray
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MomentCell", for: indexPath) as! MomentCell
        cell.selectionStyle = .none
        cell.frame = CGRect.init(x: -5, y: -20, width: cell.frame.size.width-10, height: cell.frame.size.height)
        
        cell.userInfoClick = { (data) -> Void in
                print(data)    
            let user = UserInfoView.init()
            self.navigationController?.pushViewController(user, animated: true)
        }
        cell.data = arr[indexPath.row] as! NSDictionary
        return cell
    }
    
    
    
}
