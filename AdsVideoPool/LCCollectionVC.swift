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

    
    var menu = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        self.collectionView?.isPagingEnabled = true

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        
        
        let  view  = UIView.init()
        view.backgroundColor = UIColor.green
        menu = UIScrollView.init(frame: CGRect.init(x: 0, y: 0, width: 288, height: 30))
        menu.showsHorizontalScrollIndicator = false
        menu.contentSize = CGSize.init(width: 500, height: 30)
        
        
        let view2 = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 500, height: 30))
        let arr = ["推荐","日报","创意","音乐","旅行","广告","游戏"]
        for item in arr.enumerated() {
            let lab = UILabel.init(frame: CGRect.init(x:(58*item.offset), y: 0, width: 58, height: 30))
            lab.text = item.element
            view2.addSubview(lab)
        }
        menu.addSubview(view2)
    
        
        
        self.navigationItem.titleView = menu
        
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
        return 4
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:reuseIdentifier, for: indexPath)
        cell.backgroundColor = UIColor.red
        let _frame = self.view.bounds
        let nil_label = UILabel(frame: _frame)
        nil_label.tag = 1;
        nil_label.text = "Hello";
        cell.contentView.addSubview(nil_label)
        
       
        return cell
    }
    
    
     private let sectionInsets = UIEdgeInsets(top: 0.0, left: 0, bottom: 0.0, right: 0)
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return sectionInsets
    }

    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        menu.setContentOffset(CGPoint.init(x: indexPath.row*58, y: 0), animated: true)
    }
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
