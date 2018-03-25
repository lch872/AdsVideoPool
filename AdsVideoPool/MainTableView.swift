//
//  MainTableView.swift
//  AdsVideoPool
//
//  Created by lch on 2018/3/23.
//  Copyright © 2018年 ONEWAY. All rights reserved.
//

import UIKit

class MainTableView: UITableViewController, UINavigationControllerDelegate, UIViewControllerAnimatedTransitioning {
  
    
    override func viewDidLoad() {
        super.viewDidLoad()


        self.tableView.separatorStyle = .none
        self.tableView.register(MainViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        self.tableView.delaysContentTouches = false
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.delegate = self
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! MainViewCell
        cell.data = JSON[indexPath.row%2]
        cell.selectionStyle = .none
        return cell
    }
    //点击
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detail = VideoDetailView()
        detail.bgImg = imageFromView()
        detail.data = JSON[indexPath.row%2]
        detail.currentIndex = indexPath

        let cell = self.tableView.cellForRow(at: indexPath) as! MainViewCell
        let rc = cell.convert(cell.playerView.frame, to:(UIApplication.shared.delegate?.window)!)
        detail.cellRect = rc
        
        self.navigationController?.pushViewController(detail, animated: true)
    }
    
    //动画
    override func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        let cell = tableView.cellForRow(at: indexPath) as! MainViewCell
        
        UIView.animate(withDuration: 0.2) {
            cell.bgView.transform = CGAffineTransform.init(scaleX: 0.9, y: 0.9)
        }
        return true
    }
    
    override func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! MainViewCell
        
        UIView.animate(withDuration: 0.2) {
            cell.bgView.transform = CGAffineTransform.identity
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (SCREEN_WIDTH-40)*1.3+25;
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func imageFromView() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.view.frame.size, false, UIScreen.main.scale);
        let context = UIGraphicsGetCurrentContext()
        self.view.layer .render(in: context!)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }

    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1.0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let cell = self.tableView.cellForRow(at: self.tableView.indexPathForSelectedRow!) as! MainViewCell
        let toVC = transitionContext.viewController(forKey: .to)as! VideoDetailView
        let toView = toVC.playerView
        let fromView = cell.playerView
        let containerView = transitionContext.containerView
        
        
        
       let snapShotView = cell.playerView
        snapShotView.frame = containerView.convert(fromView.frame, from: fromView.superview!)
        
        
        toVC.view.frame = transitionContext.finalFrame(for: toVC)
        toVC.view.alpha = 0;
        toView.isHidden = true;
        
        
        containerView.addSubview(toVC.view)
        containerView.addSubview(snapShotView)
        
        UIView.animate(withDuration: self.transitionDuration(using:transitionContext), delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options:.curveLinear, animations: {
            containerView.layoutIfNeeded()
            toVC.view.alpha = 1.0
            let tabBar = self.tabBarController?.tabBar
            tabBar?.frame = CGRect.init(x: 0, y: SCREEN_HEIGHT, width: SCREEN_WIDTH, height: 49)
            
            snapShotView.frame = containerView.convert(toView.frame, from: toView.superview)
    
            
            }) { (finished) -> Void in
                toView.isHidden = false
                fromView.isHidden = false
                snapShotView.removeFromSuperview()
                toVC.addView(view: snapShotView)
//                [self.tableView reloadData];
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
    
    }

}
