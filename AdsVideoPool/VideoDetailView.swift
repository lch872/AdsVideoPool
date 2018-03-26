//
//  LCViewController.swift
//  AdsVideoPool
//
//  Created by lch on 2018/3/20.
//  Copyright © 2018年 ONEWAY. All rights reserved.
//

import UIKit
import AVKit
class VideoDetailView: UIViewController,UITableViewDataSource, UIGestureRecognizerDelegate, UINavigationControllerDelegate, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning, UITableViewDelegate {
    
    var data:[String:String] = ["":""]
    {
        didSet
        {
            setupView()
        }
    }
    
    var currentIndex = IndexPath()
    
    var  textView = UIView()
    var table = UITableView()
    var playerView = AVPlayerView()
      var bgImg = UIImage()
    var mainView = UIView()
    var cellRect = CGRect()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        let swipe = UISwipeGestureRecognizer.init(target: self, action: #selector(dismiss(animated:completion:)))
        self.view.addGestureRecognizer(swipe)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        
        let pan = UIPanGestureRecognizer.init(target: self, action: #selector(scaleDissmiss(_:)))
        pan.delegate = self
        self.view.addGestureRecognizer(pan)
        
        
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.delegate = self;
        
    }

    func addView(view:AVPlayerView){
        
//        self.playerView.backgroundColor = UIColor.red
        self.playerView.layer.addSublayer(view.avPlayerLayer)
        self.playerView.isUserInteractionEnabled = false
    }
    
    
    func setupView() {
        
        let bgImageView = UIImageView.init(frame: self.view.bounds)
        bgImageView.image = bgImg
        self.view.addSubview(bgImageView)
        
        let effect = UIBlurEffect.init(style: .light)
        let effectView = UIVisualEffectView.init(effect: effect)
        
        effectView.frame = CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
        self.view.addSubview(effectView)
        
        let vibrancyEffect = UIVibrancyEffect(blurEffect: effect)
        let vibrancyView = UIVisualEffectView(effect:vibrancyEffect)
        vibrancyView.frame = self.view.bounds
        effectView.contentView.addSubview(vibrancyView)
        
        
        mainView = UIView.init(frame: self.view.bounds)
        mainView.backgroundColor = UIColor.white
        self.view.addSubview(mainView)
        
//        // 播放器
        let div:Float = Float(data["height"]!)!/Float(data["width"]!)!
        playerView = AVPlayerView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: CGFloat(div)*SCREEN_WIDTH))
        mainView.addSubview(playerView)



        
        
        // MARK: - 评论列表
        table = UITableView.init(frame: CGRect.init(x: 0, y: playerView.frame.maxY, width: self.view.bounds.width, height: self.view.bounds.height - playerView.bounds.height - 50), style: .plain)
        table.dataSource = self
        table.delegate = self
        
        
        table.register(CommentCell.self, forCellReuseIdentifier: "aCell")
        table.rowHeight = 150
        
        
//        table.estimatedRowHeight = 100
//        table.rowHeight = UITableViewAutomaticDimension
        
        mainView.addSubview(table)
        
        let head = PostInfoView.init(frame: CGRect.init(x: 0, y: 0, width: table.bounds.width, height: 300))
        table.tableHeaderView = head
        
        //MARK: 评论
        textView = CommentView.init(frame: CGRect.init(x: 0, y: table.frame.maxY, width: self.view.bounds.width, height: 50))
        mainView.addSubview(textView)
        
        
        
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "eeeee"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "aCell", for: indexPath)
        cell.selectionStyle = .none
        cell.frame = CGRect.init(x: -5, y: -20, width: cell.frame.size.width-10, height: cell.frame.size.height)
//        cell.textLabel?.text = "\(indexPath.row)"
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

    
    var startPointY:CGFloat  = 0.0
    var scale:CGFloat = 0.0
    
    @objc func scaleDissmiss(_ pan:UIPanGestureRecognizer) {
        
        switch pan.state {
            case .began:    // 手势开始
                let currentPoint = pan.location(in: self.playerView)
                startPointY = currentPoint.y;
            
            case .changed:  // 手势状态改变
                let currentPoint = pan.location(in: self.playerView)
                scale = (SCREEN_HEIGHT-(currentPoint.y-startPointY))/SCREEN_HEIGHT
//                print(scale)
                if (scale > 1.0) {
                    scale = 1.0;
                } else if (scale < 0.9) {
                    scale = 0.8;
                    DispatchQueue.main.asyncAfter(deadline: .now()+0.03, execute: {
                        self.navigationController?.popViewController(animated: true)
                    })
                }
                if (self.table.contentOffset.y<=0) {
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
                if (scale>0.8) {
                    UIView.animate(withDuration: 0.2, animations: {
                        self.mainView.layer.cornerRadius = 0;
                        self.mainView.transform = CGAffineTransform.identity
                    })
                }
            default:
                print("ffff")
        }
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset.y)
        print(scrollView.contentSize.height)
        print(scrollView.bounds.size.height)
        // 禁止上拉
        if scrollView.contentOffset.y < 0 {
            
            scrollView.contentOffset.y = 0
        }

    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1.0
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
        
        
        let snapShotView = fromView
        snapShotView.frame = containerView.convert(fromView.frame, from: fromView.superview)
//
//        fromView.isHidden = true
        toView?.isHidden = true
        
        containerView.insertSubview(toVC.view, belowSubview: fromVC.view)
        containerView.addSubview(snapShotView)
        
        UIView.animate(withDuration: self.transitionDuration(using:transitionContext ), delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options:.curveEaseOut, animations: {
            
            containerView.layoutIfNeeded()
            fromVC.view.alpha = 0.0
            snapShotView.layer.cornerRadius = 15
            
            
            print(self.cellRect)
            
//            print("originView?.frame \(toView?.frame)")
//            let ddd = snapShotView.frame  //ddd.origin.x
            
            snapShotView.frame = CGRect.init(x: 20, y: self.cellRect.origin.y, width: SCREEN_WIDTH-60, height: self.cellRect.size.height+100)
            snapShotView.backgroundColor = UIColor.yellow
            snapShotView.layoutSubviews()
            
            
            
//            snapShotView.frame = containerView.convert((cell?.contentView.frame)!, from: cell.v)
            print("changed: \(snapShotView.frame)")
            
            
            
            
           let tabBar = self.tabBarController!.tabBar as UITabBar
               tabBar.frame = CGRect.init(x: 0, y: SCREEN_HEIGHT-49, width: SCREEN_WIDTH, height: 49)

        }) { (finished) -> Void in
            fromView.isHidden = false
            toView?.isHidden = false
//            snapShotView.removeFromSuperview()
//            cell!.addView(view: snapShotView)
            
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        
    }
    
}
