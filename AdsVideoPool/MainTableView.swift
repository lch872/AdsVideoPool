    //
//  MainTableView.swift
//  AdsVideoPool
//
//  Created by lch on 2018/3/23.
//  Copyright © 2018年 ONEWAY. All rights reserved.
//

import UIKit
import JPVideoPlayer
class MainTableView: UITableViewController, UINavigationControllerDelegate, UIViewControllerAnimatedTransitioning {
  
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.separatorStyle = .none
        self.tableView.register(MainViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        self.tableView.delaysContentTouches = false
        
        let header = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 100))
        
        let date = UILabel.init(frame: CGRect.init(x: 20, y: 20, width: 200, height: 15))
        date.text = "4月9日 星期一"
        date.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        date.textColor = UIColor.init(white: 150/255.0, alpha: 1)
        header.addSubview(date)
        
        let title = UILabel.init(frame: CGRect.init(x: 20, y: date.frame.maxY + 5, width: 200, height: 30))
        title.text = "今日推荐"
        title.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        header.addSubview(title)
        
        
        
        self.tableView.tableHeaderView = header
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.delegate = self
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        self.tabBarController?.tabBar.isHidden = false
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
        cell.indexo = indexPath
        cell.clickClosure = { (index) -> Void in
            print(index)
            self.click(indexPath: index!)
        }
        return cell
    }
    
    
    
    func click(indexPath:IndexPath){
        let detail = VideoDetailView()
        detail.bgImg = imageFromView(view: self.view)
        let data = JSON[indexPath.row%2]
        detail.data = data
        detail.currentIndex = indexPath
        
        let cell = self.tableView.cellForRow(at: indexPath) as! MainViewCell
        let rc = cell.convert(cell.playerView.frame, to:(UIApplication.shared.delegate?.window)!)
        detail.cellRect = rc
        
        let filePath = Bundle.main.path(forResource: data["videoName"] as! String, ofType:nil)
        let videoURL = URL(fileURLWithPath: filePath!)
        
        let cxx = JPVideoPlayerPlayVideoTool.shared().currentPlayVideoItem?.playingKey
        
        if videoURL.absoluteString != cxx {
            JPVideoPlayerPlayVideoTool.shared().stopPlay()
        }
        
        jumpToDetail = true
        self.navigationController?.pushViewController(detail, animated: true)
    }
    //点击
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        click(indexPath: indexPath)
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
        return (SCREEN_WIDTH-40)+25;
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    
    
    
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        offsetY_last = scrollView.contentOffset.y
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        handleScrollDerectionWithOffset(offsetY: scrollView.contentOffset.y)
        handleQuickScroll()
    }
    
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if decelerate==false {
            handleScrollStop()
        }
    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        handleScrollStop()
    }
    
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.6
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
//        let cell = self.tableView.cellForRow(at: self.tableView.indexPathForSelectedRow!) as! MainViewCell
        let toVC = transitionContext.viewController(forKey: .to)as! VideoDetailView
        let toView = toVC.playerView
        
        
        let cell = self.tableView.cellForRow(at: toVC.currentIndex) as! MainViewCell
        let fromView = cell.playerView
        let containerView = transitionContext.containerView
        
        fromView.frame = containerView.convert(fromView.frame, from: fromView.superview!)
        
        toVC.view.frame = transitionContext.finalFrame(for: toVC)
        toVC.view.alpha = 0;
        toView.isHidden = true;
        
        containerView.addSubview(toVC.view)
        containerView.addSubview(fromView)
        
        UIView.animate(withDuration: self.transitionDuration(using:transitionContext), delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options:.curveLinear, animations: {
            containerView.layoutIfNeeded()
            toVC.view.alpha = 1.0
            let tabBar = self.tabBarController?.tabBar
            tabBar?.frame = CGRect.init(x: 0, y: SCREEN_HEIGHT, width: SCREEN_WIDTH, height: 49)
            
            let mee = containerView.convert(toView.frame, from: toView.superview)
            print(mee)

            fromView.frame = mee
             JPVideoPlayerPlayVideoTool.shared().currentPlayVideoItem?.currentPlayerLayer?.frame = fromView.bounds
            
            }) { (finished) -> Void in
                toView.isHidden = false
                fromView.isHidden = false
                toVC.addView(view: fromView)
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
    
    }
    
    
    var lastScrollOffset:CGFloat = 0
    
    
    var playingCell = MainViewCell()

        // Find first cell need play video in visiable cells.
        func playVideoInVisiableCells() {
            let visiableCells = self.tableView.visibleCells
            
            var targetCell : MainViewCell?
            for c in visiableCells {
                let cell = c as! MainViewCell
                if cell.videoPath.characters.count>0 {
                    targetCell = cell
                    break
                }
            }
            
            // If found, play.
            guard let videoCell = targetCell else {
                return
            }
            playingCell = videoCell
            
            // display status view.
//            videoCell.playerView.jp_playVideoMutedDisplayStatusView(with: URL(string: videoCell.videoPath))
            
            // hide status view.
            // videoCell.videoImv.jp_playVideoMuted(with: URL(string: videoCell.videoPath))
        }
        
        func handleScrollStop() {
            
            guard let bestCell = findTheBestToPlayVideoCell() else {
                return
            }
            
            // If the found cell is the cell playing video, this situation cannot play video again.
            // 注意, 如果正在播放的 cell 和 finnalCell 是同一个 cell, 不应该在播放.
            if playingCell.hash != bestCell.hash {
                
                let current = JPVideoPlayerPlayVideoTool.shared().currentPlayVideoItem?.playingKey
                let filePath = Bundle.main.path(forResource: bestCell.data["videoName"], ofType:nil)
                let videoURL = URL(fileURLWithPath: filePath!)
                
//                let ccc = URL.init(string: "https://cdn.oneway.mobi/cre/109/d1428ce9d90fd857b8fcbc7c0e92b2f7.mp4")

                if videoURL.absoluteString != current {
                    playingCell.playerView.jp_stopPlay()
                    
                bestCell.playerView.jp_playVideo(with: videoURL, options: [.layerVideoGravityResizeAspect,.mutedPlay,.showProgressView], progress: nil, completed: nil)
//                    bestCell.playerView.jp_playVideoMutedDisplayStatusView(with: videoURL)
                    
                    
                    
                    playingCell = bestCell
                }
                
            }
        }
    
    var currentDerection:kJPPlayUnreachCellStyle = .none
    
        func handleQuickScroll() {
            if playingCell.hash==0 {
                return
            }
            
            // 防止弹出新的控制器时 tableView 自动调用滚动方法, 导致最后一个 cell 无法播放视频.
            if tableViewRange.isHidden {
                return;
            }
            
            // Stop play when the cell playing video is unvisiable.
            // 当前播放视频的cell移出视线，要移除播放器.
            if !playingCellIsVisiable() {
                stopPlay()
            }
        }
    // MARK: - Properties
    
    lazy var tableViewRange : UIView = self.generateTableViewRange()
    let JPVideoPlayerDemoNavAndStatusTotalHei : CGFloat = 64.0
    let JPVideoPlayerDemoTabbarHei : CGFloat = 49.0
    let screenSize = UIScreen.main.bounds.size
    let JPVideoPlayerDemoReuseID = "JPVideoPlayerDemoReuseID"
    let  JPVideoPlayerDemoRowHei : CGFloat = CGFloat(SCREEN_WIDTH)*9.0/16.0
    
    var jumpToDetail = false
    
    let generateTableViewRange = { () -> UIView in
        let tableViewRange = UIView(frame: CGRect(x: 0, y: 64, width: SCREEN_WIDTH, height: SCREEN_HEIGHT-64-49))
        tableViewRange.isUserInteractionEnabled = false
        tableViewRange.backgroundColor = UIColor.clear
        tableViewRange.isHidden = true
        return tableViewRange
    }
        func stopPlay() {
            playingCell.playerView.jp_stopPlay()
//            playingCell = nil
        }
        var offsetY_last : CGFloat = 0.0
        func handleScrollDerectionWithOffset(offsetY : CGFloat) {
            currentDerection = (offsetY-offsetY_last) > 0 ? .up : .down
            offsetY_last = offsetY
        }
    
    


        func findTheBestToPlayVideoCell() -> MainViewCell? {

            var windowRect = UIScreen.main.bounds
            windowRect.origin.y = JPVideoPlayerDemoNavAndStatusTotalHei;
            windowRect.size.height -= (JPVideoPlayerDemoNavAndStatusTotalHei + JPVideoPlayerDemoTabbarHei);

            // To find next cell need play video.
            // 找到下一个要播放的cell(最在屏幕中心的).

            var finialCell : MainViewCell?
            let visiableCells : [MainViewCell] = tableView.visibleCells as! [MainViewCell];
            var gap : CGFloat = CGFloat(MAXFLOAT)
            for cell in visiableCells {

                if cell.videoPath.characters.count==0 { // If need to play video, 如果这个cell有视频

                    // Find the cell cannot stop in screen center first.
                    // 优先查找滑动不可及cell.
                    if cell.cellStyle != .none {

                        // Must the all area of the cell is visiable.
                        // 并且不可及cell要全部露出.
                        if cell.cellStyle == .up {
                            var cellLeftUpPoint = cell.frame.origin
                            // 不要在边界上.
                            cellLeftUpPoint.y += 1
                            let coorPoint = cell.superview?.convert(cellLeftUpPoint, to: nil)
                            let contain = windowRect.contains(coorPoint!)
                            if  contain {
                                finialCell = cell
                                break
                            }
                        }
                        else if(cell.cellStyle == .down){
                            let cellLeftUpPoint = cell.frame.origin
                            let cellDownY = cellLeftUpPoint.y+cell.frame.size.height
                            var cellLeftDownPoint = CGPoint(x: 0, y: cellDownY)
                            // 不要在边界上.
                            cellLeftDownPoint.y -= 1
                            let coorPoint = cell.superview?.convert(cellLeftDownPoint, to: nil)
                            let contain = windowRect.contains(coorPoint!)
                            if contain {
                                finialCell = cell
                                break;
                            }
                        }
                    }
                    else{
                        let coorCenter = cell.superview?.convert(cell.center, to: nil)
                        let delta = fabs((coorCenter?.y)!-JPVideoPlayerDemoNavAndStatusTotalHei-windowRect.size.height*0.5)
                        if delta < gap {
                            gap = delta
                            finialCell = cell
                        }
                    }
                }
            }
            return finialCell
        }

        func playingCellIsVisiable() -> Bool {
            let cell = playingCell
            if cell == nil {
                return false
            }else{
                
            }
            
            var windowRect = UIScreen.main.bounds
            windowRect.origin.y = JPVideoPlayerDemoNavAndStatusTotalHei;
            // because have UINavigationBar here.
            windowRect.size.height -= JPVideoPlayerDemoNavAndStatusTotalHei;

            if currentDerection == .up { // 向上滚动
                let cellLeftUpPoint = cell.frame.origin
                let cellDownY = cellLeftUpPoint.y+cell.frame.size.height
                var cellLeftDownPoint = CGPoint(x: 0, y: cellDownY)
                // 不要在边界上.
                cellLeftDownPoint.y -= 1
                let coorPoint = playingCell.superview?.convert(cellLeftDownPoint, to: nil)

                let contain = windowRect.contains(coorPoint!)
                return contain
            }
            else if(currentDerection == .down){ // 向下滚动
                var cellLeftUpPoint = cell.frame.origin
                // 不要在边界上.
                cellLeftUpPoint.y += 1
                let coorPoint = cell.superview?.convert(cellLeftUpPoint, to: nil)

                let contain = windowRect.contains(coorPoint!)
                return contain
            }
            
            
            return true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if !jumpToDetail {
            playingCell.playerView.jp_pause()
        }
        
        
    }

    override func viewDidAppear(_ animated: Bool) {
        jumpToDetail = false
        playingCell.playerView.jp_resume()
    }
}
