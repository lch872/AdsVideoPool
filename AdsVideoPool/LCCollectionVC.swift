//
//  LCCollectionVC.swift
//  AdsVideoPool
//
//  Created by lch on 2018/3/16.
//  Copyright © 2018年 ONEWAY. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class LCCollectionVC: UICollectionViewController,UICollectionViewDelegateFlowLayout {
    
    
    var json = [[
            "tag":"游戏推荐",
            "title":"勇闯迷宫，拯救公主",
            "videoName":"2.mp4",
            "detail":"进入《Crypt of the NecroDancer》的动感冒险",
            "width":"886",
            "height":"664",
        ],
        [   "tag":"今日推荐",
            "title":"知你喜好,为你调酒",
            "videoName":"3.mp4",
            "width":"1280",
            "height":"720",
            "detail":"与石原里美一起享受美味的好酒"
        ]]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // Register cell classes
        self.collectionView!.register(LCCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView!.delaysContentTouches = false

        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 7
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:reuseIdentifier, for: indexPath) as! LCCollectionViewCell
        
        cell.data = json[indexPath.row%2]
        cell.backgroundColor = UIColor.white
        
        cell.layer.cornerRadius = 16;
        cell.layer.masksToBounds = true;
        cell.layer.shadowColor = UIColor.lightGray.cgColor
        cell.layer.shadowOffset = CGSize.init(width: 5, height: 10)
        cell.layer.shadowOpacity = 0.8;
        cell.layer.shadowRadius = 5;
        
        
        
        
        return cell
    }
    
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "makeOriginal"), object: nil)
    }
}
