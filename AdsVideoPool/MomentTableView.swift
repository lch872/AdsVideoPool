//
//  MomentTableView.swift
//  AdsVideoPool
//
//  Created by lch on 2018/3/30.
//  Copyright © 2018年 ONEWAY. All rights reserved.
//

import UIKit

class MomentTableView: UITableViewController {

    var jsonDic = NSDictionary()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let jsonPath = Bundle.main.path(forResource: "pinglun", ofType: "json")
        let data = NSData.init(contentsOfFile: jsonPath!)
        jsonDic = try! JSONSerialization.jsonObject(with: data! as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
        
        self.tableView.register(MomentCell.self, forCellReuseIdentifier: "MomentCell")
        self.tableView.rowHeight = 150
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return jsonDic.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let arr = jsonDic["itemList"] as! NSArray
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MomentCell", for: indexPath) as! MomentCell
        cell.selectionStyle = .none
        cell.frame = CGRect.init(x: -5, y: -20, width: cell.frame.size.width-10, height: cell.frame.size.height)
        
        cell.data = arr[indexPath.row] as! NSDictionary
        return cell
    }
    
}
