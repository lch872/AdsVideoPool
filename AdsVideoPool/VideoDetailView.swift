//
//  LCViewController.swift
//  AdsVideoPool
//
//  Created by lch on 2018/3/20.
//  Copyright © 2018年 ONEWAY. All rights reserved.
//

import UIKit
import AVKit
import JPVideoPlayer


class VideoDetailView: UIViewController,UITableViewDataSource, UIGestureRecognizerDelegate, UINavigationControllerDelegate, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning, UITableViewDelegate {
    
    var data:[String:Any]!
    {
        didSet{
            setupView()
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    var currentIndex = IndexPath()
    
    var  textView = CommentInputView()
    var table = UITableView()
    var playerView = UIImageView()
      var bgImg = UIImage()
    var mainView = UIView()
    var cellRect = CGRect()
    var jsonDic = NSDictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let jsonPath = Bundle.main.path(forResource: "pinglun", ofType: "json")
        let data = NSData.init(contentsOfFile: jsonPath!)
        jsonDic = try! JSONSerialization.jsonObject(with: data! as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
        

//      let yy = UIImageView.init(image: imageFromView(view: self.view))
//        yy.frame = self.view.bounds
//        self.view.insertSubview(yy, belowSubview: mainView)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        
        let pan = UIPanGestureRecognizer.init(target: self, action: #selector(scaleDissmiss(_:)))
        pan.delegate = self
        self.view.addGestureRecognizer(pan)
        
        
        let ss = UIScreenEdgePanGestureRecognizer.init(target: self, action: #selector(scaleDissmiss(_:)))
        ss.edges = .left
        ss.delegate = self
        self.view.addGestureRecognizer(ss)
        
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.delegate = self;
         self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    func addView(view:UIImageView){
        self.playerView.removeFromSuperview()
        self.mainView.addSubview(view)
        self.playerView = view
        self.playerView.isUserInteractionEnabled = false
        
        mainView.bringSubview(toFront: close)
    }
    
    
    var close = UIButton()
    
    func setupView() {
        
        let bgImageView = UIImageView.init(frame: self.view.bounds)
        bgImageView.image = bgImg
        self.view.addSubview(bgImageView)
        
        
        
        
        let effect = UIBlurEffect.init(style: .light)
        let effectView = UIVisualEffectView.init(effect: effect)
        
        effectView.frame = CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
        self.view.addSubview(effectView)
        
//        let vibrancyEffect = UIVibrancyEffect(blurEffect: effect)
//        let vibrancyView = UIVisualEffectView(effect:vibrancyEffect)
//        vibrancyView.frame = self.view.bounds
//        effectView.contentView.addSubview(vibrancyView)
//
        
        mainView = UIView.init(frame: self.view.bounds)
        mainView.backgroundColor = UIColor.white
        self.view.addSubview(mainView)
        
//        // 播放器
//        let div:Float = Float(data["height"] as! String)!/Float(data["width"]as! String)!
        
        let div = 0.564
        playerView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: CGFloat(div)*SCREEN_WIDTH))
        mainView.addSubview(playerView)


        
        
        
        // MARK: - 评论列表
        table = UITableView.init(frame: CGRect.init(x: 0, y: playerView.frame.maxY, width: self.view.bounds.width, height: self.view.bounds.height - playerView.bounds.height - 50), style: .plain)
        table.dataSource = self
        table.delegate = self
        
        
        table.register(MomentCell.self, forCellReuseIdentifier: "aCell")
        table.rowHeight = 150
        
        
//        table.estimatedRowHeight = 213
//        table.rowHeight = UITableViewAutomaticDimension
        
        mainView.addSubview(table)
        
        let head = PostInfoView.init(frame: CGRect.init(x: 0, y: 0, width: table.bounds.width, height: 400))
        table.tableHeaderView = head
        
        //MARK: 评论
        textView = CommentInputView.init(frame: CGRect.init(x: 0, y: table.frame.maxY, width: self.view.bounds.width, height: 50))
        textView.click = { (lll)->Void in
            if lll {
                self.table.scrollToRow(at: IndexPath.init(row: 0, section: 0), at: .top, animated: true)
            }else{
                self.table.setContentOffset(CGPoint.init(x: 0, y: 0), animated: true)
            }
        }
        mainView.addSubview(textView)
        
//        
//        close = UIButton.init(frame: CGRect.init(x: SCREEN_WIDTH-40, y: 10, width: 30, height: 30))
//        close.setImage(UIImage.init(named: "close"), for: .normal)
//        mainView.addSubview(close)
//        close.addTarget(self, action: #selector(popViewController), for: .touchUpInside)
//        
    }
    
    @objc func popViewController() {
        
        mainView.transform = CGAffineTransform.init(scaleX: 0.9, y: 0.9)
        self.navigationController?.popViewController(animated: true)
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "精彩评论"
//    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // create the parent view that will hold header Label
        let customView = UIView.init(frame: CGRect.init(x: 10, y: 0, width: 300, height:    28))
        customView.backgroundColor = UIColor.init(white: 247/255.0, alpha: 1)
        
        
        // create the button object
        let headerLabel = UILabel.init(frame: CGRect.zero)
        headerLabel.backgroundColor = UIColor.clear
        headerLabel.isOpaque = false
        headerLabel.textColor = UIColor.black
        headerLabel.highlightedTextColor = UIColor.white
        headerLabel.font = UIFont.systemFont(ofSize: 13)
        headerLabel.frame = CGRect.init(x: 10, y: 0, width: 300, height:28)


        headerLabel.text = "用户评论"
        customView.addSubview(headerLabel)
        return customView;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let dd = jsonDic["itemList"] as! NSArray
        return dd.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        if indexPath.section == 0 {
////            let cell = tableView.dequeueReusableCell(withIdentifier: "aCell", for: indexPath) as! CommentCell
//
//            let cell = UITableViewCell.init(style: .default, reuseIdentifier: "oolol")
//            cell.contentView.subviews.forEach({ (view) in
//                view.removeFromSuperview()
//            })
//            
//            let scr = UIScrollView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 80))
////            scr.backgroundColor = UIColor.red
//            scr.contentSize = CGSize.init(width: 197*6+5, height: 80)
//            scr.showsHorizontalScrollIndicator = false
//            cell.contentView.addSubview(scr)
//            for index in 0...5 {
//                let ll = UIView.init(frame: CGRect.init(x: 5+index*(192+5), y: 0, width: 192, height: 80))
//                ll.backgroundColor = UIColor.init(white: 240/255.0, alpha: 1)
//                ll.layer.cornerRadius = 10.0
//                ll.layer.masksToBounds = true
//                scr.addSubview(ll)
//            }
//            return cell
//        }
//        
        let arr = jsonDic["itemList"] as! NSArray
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "aCell", for: indexPath) as! MomentCell
        cell.selectionStyle = .none
        cell.frame = CGRect.init(x: -5, y: -20, width: cell.frame.size.width-10, height: cell.frame.size.height)
        
        cell.data = arr[indexPath.row] as! NSDictionary
        return cell
    }
    
    //MARK: - 监听键盘
    @objc func keyBoardWillShow(_ notification: Notification){
        //获取userInfo
        let kbInfo = notification.userInfo
        //获取键盘的size
        let kbRect = (kbInfo?[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        //键盘的y偏移量
        let changeY = kbRect.origin.y - self.view.bounds.height
        //键盘弹出的时间
        let duration = kbInfo?[UIKeyboardAnimationDurationUserInfoKey] as! Double
        //界面偏移动画
        UIView.animate(withDuration: duration) {
            self.textView.transform = CGAffineTransform(translationX: 0, y: changeY)
        }
        
        table.isUserInteractionEnabled = false
        
        
    }
    
    //键盘的隐藏
    @objc func keyBoardWillHide(_ notification: Notification){
        let duration = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as! Double
        UIView.animate(withDuration: duration) {
            self.textView.transform = CGAffineTransform.identity
        }
        table.isUserInteractionEnabled = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    deinit {
        //移除通知
        NotificationCenter.default.removeObserver(self)
    }

    var startPoint:CGPoint  = CGPoint(x: 0, y:0)
    var scale:CGFloat = 0.0
    
    @objc func scaleDissmiss(_ pan:UIGestureRecognizer) {
        
        switch pan.state {
            case .began:    // 手势开始
                startPoint = pan.location(in: self.playerView)
            
            case .changed:  // 手势状态改变
                let currentPoint = pan.location(in: self.playerView)
                scale = (SCREEN_HEIGHT-(currentPoint.y-startPoint.y))/SCREEN_HEIGHT
                if pan.isKind(of: UIScreenEdgePanGestureRecognizer.self){
                    scale = (SCREEN_WIDTH-(currentPoint.x-startPoint.x))/SCREEN_WIDTH
                }

                if (scale > 1.0) {
                    scale = 1.0;
                } else if (scale < 0.9) {
                    scale = 0.9;
//                        self.mainView.transform = CGAffineTransform.identity
                    self.navigationController?.popViewController(animated: true)
                }
                
                if true {
                    // 缩放
                    self.mainView.transform = CGAffineTransform.init(scaleX: scale, y: scale)
                    // 圆角
                    self.mainView.layer.cornerRadius = 15 * (1-scale)*5*1.08;
                    self.mainView.layer.masksToBounds = true
                }
                
                if (scale < 0.99) {
                    self.table.isScrollEnabled = false
                } else {
                    self.table.isScrollEnabled = true
                }
            case .ended:  // 手势结束
                print("手势结束")
                scale = 1;
                self.table.isScrollEnabled = true;
                if (scale>0.9) {
                    
                    UIView.animate(withDuration: 0.2, animations: {
                        self.mainView.layer.cornerRadius = 0;
                        self.mainView.transform = CGAffineTransform.identity
                    }, completion: { (void) in
//                        print("completion")
//                        print(self.playerView.frame)
//                        print(self.playerView.avPlayerLayer.frame)
                    })
                    
                    
                }
            default:
                return
        }
    }
    
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset.y)
        if scrollView.contentOffset.y < -40 {
            self.dismiss(animated: true, completion: nil)
        }
        //        if scrollView.contentOffset.y < 0 {
//            scrollView.contentOffset.y = 0
//        }
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.6
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        
        let toVC = transitionContext.viewController(forKey: .to) as! MainTableView
        let fromVC = transitionContext.viewController(forKey: .from) as! VideoDetailView
        let containerView = transitionContext.containerView
        containerView.backgroundColor = UIColor.clear
        let fromView = fromVC.playerView
        
        toVC.view.frame = transitionContext.finalFrame(for: toVC)
        
        let cell = toVC.tableView.cellForRow(at: currentIndex) as? MainViewCell
       
        print("currentIndex:\(currentIndex)")
        if cell == nil {
            print("nil ----- \(toVC.tableView)")
        }
        let toView = cell?.playerView
        
        fromView.frame = containerView.convert(fromView.frame, from: fromView.superview)
        toView?.isHidden = true
        
        containerView.insertSubview(toVC.view, belowSubview: fromVC.view)
        containerView.addSubview(fromView)
        
        fromView.isHidden = false
        print(fromView.isHidden)
    
        
        let context = UIGraphicsGetCurrentContext()
        let rectanglePath = UIBezierPath.init(roundedRect: fromView.bounds, byRoundingCorners:[.topLeft,.topRight], cornerRadii: CGSize.init(width: 15, height: 15))
        let aa = CAShapeLayer.init()
        aa.frame = fromView.bounds
        aa.path = rectanglePath.cgPath
        fromView.layer.mask = aa

        
        
        
        
        
        UIView.animate(withDuration: self.transitionDuration(using:transitionContext ), delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options:.curveEaseOut, animations: {
            
            containerView.layoutIfNeeded()
            fromVC.view.alpha = 0.0
            
            let fra = containerView.convert(fromView.frame, from: fromView.superview!.superview!)
            fromView.frame = CGRect.init(x: fra.origin.x, y: self.cellRect.origin.y, width: fra.size.width, height: fra.size.height)
            
           let tabBar = self.tabBarController!.tabBar as UITabBar
               tabBar.frame = CGRect.init(x: 0, y: SCREEN_HEIGHT-49, width: SCREEN_WIDTH, height: 49)
            
            
            JPVideoPlayerPlayVideoTool.shared().currentPlayVideoItem?.currentPlayerLayer?.frame = fromView.bounds
        }) { (finished) -> Void in
            
            fromView.isHidden = false
            toView?.isHidden = false
            fromView.removeFromSuperview()
            cell!.addView(view: fromView)
            fromView.layer.mask = nil
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        
    }
    

    
    override func viewDidAppear(_ animated: Bool) {
        
        let filePath = Bundle.main.path(forResource: self.data["videoName"] as? String, ofType:nil)
        let videoURL = URL(fileURLWithPath: filePath!)
        
        let ddd = self.playerView.jp_videoLayer
        
        print(ddd)
        
        self.playerView.jp_playVideoMutedHiddenStatusView(with: videoURL)
        
        self.table.scrollToRow(at: IndexPath.init(row: 0, section: 0), at: .top, animated: true)
    }

}


