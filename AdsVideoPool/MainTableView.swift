    //
//  MainTableView.swift
//  AdsVideoPool
//
//  Created by lch on 2018/3/23.
//  Copyright © 2018年 ONEWAY. All rights reserved.
//

import UIKit
import JPVideoPlayer
import StoreKit
    
class MainTableView: UITableViewController, UINavigationControllerDelegate, UIViewControllerAnimatedTransitioning, SKStoreProductViewControllerDelegate {
  
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.separatorStyle = .none
        self.tableView.register(MainViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        self.tableView.delaysContentTouches = true
        
        let header = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 50))
        self.tableView.tableHeaderView = header
        
        
        
        let arr = ["新闻","游戏","音乐","搞笑","科技","军事","动画","体育"]
        let padding = 25
        for index in 1...6 {
            
            let tag1 = PostInfoView.tagBtn(name: arr[index], frame: CGRect.init(x: Double((padding+22)*index), y: 20.0, width: 40.0, height: 18.5))
            header.addSubview(tag1)
        }

        
        
        self.tableView.canCancelContentTouches = true
    }

    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.delegate = self
        self.navigationController?.setNavigationBarHidden(true,animated: false)
        
        self.tabBarController?.tabBar.isHidden = false
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return JSON.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! MainViewCell
        cell.data = JSON[indexPath.row]
        cell.selectionStyle = .none
        cell.indexo = indexPath
        cell.clickClosure = { (index) -> Void in
            print(index)
            self.click(indexPath: index!)
        }
        return cell
    }
    
    let appStore = LCAppStore()
    func productViewControllerDidFinish(_ viewController: SKStoreProductViewController) {
        appStore.dismiss(animated: true) {
            self.playingCell.playerView.jp_resume()
        }
        
    }
    
    
    func click(indexPath:IndexPath){
        
        
        let data = JSON[indexPath.row]
        
        if data["type"] == "ads" {
            
            
            appStore.delegate = self
            appStore.loadProduct(withParameters: ["id":"1321803705"], completionBlock: nil)
            playingCell.playerView.jp_pause()
            UIApplication.shared.keyWindow?.rootViewController?.present(appStore, animated: true, completion: nil)
            
            return
        }
        
        let detail = VideoDetailView()
        detail.bgImg = imageFromView(view: self.view)
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
        
        let ss:[String:String] = JSON[indexPath.row]
       return ss["type"] == "ads" ? (SCREEN_WIDTH*0.7)+25 : (SCREEN_WIDTH*0.7)+25
         
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
            

//            print("fromView.subviews.last\(fromView.subviews.last)")
//            
//            let sss = fromView.subviews[fromView.subviews.count-2] as? UIView
//            sss?.backgroundColor = UIColor.init(red: 1.0, green: 0, blue: 0, alpha: 0.4)
//            sss?.frame = fromView.bounds
            
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
                
                if filePath != nil {
                    let videoURL = URL(fileURLWithPath: filePath!)
                    if videoURL.absoluteString != current {
                        playingCell.playerView.jp_stopPlay()
                        
                        bestCell.playerView.jp_playVideo(with: videoURL, options: [.layerVideoGravityResizeAspect,.showProgressView], progress: nil, completed: nil)
                        bestCell.playerView.playBtn.isSelected = false
                        bestCell.playerView.hideView(true, delay: 0.7)
                        
                        //.mutedPlay
                }
                
                
//                let ccc = URL.init(string: "https://cdn.oneway.mobi/cre/109/d1428ce9d90fd857b8fcbc7c0e92b2f7.mp4")

                
                    
                    
                    
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
        playingCell.playerView.playBtn.isSelected = false
    }
    
    
    static var imageDict:[String:UIImage] = NSMutableDictionary() as! [String : UIImage]
    
    static func getImage(videoUrl:URL) -> UIImage {
        let url = videoUrl.absoluteString
        
        
        let ddd = imageDict[url]
        if ddd != nil {
            return ddd!
        }
        
        
        let avAsset = AVAsset.init(url: videoUrl as URL)
        print("创建了图片")
        //生成视频截图
        let generator = AVAssetImageGenerator(asset: avAsset)
        generator.appliesPreferredTrackTransform = true
        let time = CMTimeMakeWithSeconds(0.0,600)
        var actualTime:CMTime = CMTimeMake(0, 0)
        let imageRef = try?generator.copyCGImage(at: time, actualTime: &actualTime)
        if imageRef == nil {
            return UIImage.init(named: "1.png")!
        }
        
        let frameImg = UIImage.init(cgImage: imageRef!)
        
        imageDict[url] = frameImg
//        let imageData = UIImageJPEGRepresentation(frameImg, 1.0) as! NSData
//        let name = String.init(format: "/Users/lch/Desktop/\(url.hashValue).png")
//        imageData.write(toFile: name, atomically: true)
        
        return frameImg
    }
 
}
    
 
