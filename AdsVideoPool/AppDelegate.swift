//
//  AppDelegate.swift
//  AdsVideoPool
//
//  Created by lch on 2018/3/16.
//  Copyright © 2018年 ONEWAY. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        
        let tabbar = UITabBarController.init()
        
        
        let layout = UICollectionViewFlowLayout.init()
        layout.itemSize = CGSize.init(width: self.window!.bounds.width-40, height: 414)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 30;
        layout.minimumInteritemSpacing = 0;
        

        
        let table = MainTableView.init(style: .plain)
        table.tableView!.backgroundColor = UIColor.init(red: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1)
        let nav = UINavigationController.init(rootViewController: table)
        
        
        nav.tabBarItem.title = "首页"
        nav.tabBarItem.image = UIImage.init(named: "main")
        
        let focus = UITableViewController.init(style: .plain)
        focus.tabBarItem.title = "动态"
        focus.tabBarItem.image = UIImage.init(named: "focus")
        
        let mine = UITableViewController.init(style: .plain)
        mine.tabBarItem.title = "我"
        mine.tabBarItem.image = UIImage.init(named: "mine")
        
        
        tabbar.addChildViewController(nav)
        tabbar.addChildViewController(focus)
        tabbar.addChildViewController(mine)
        
    
        self.window!.rootViewController = tabbar
        
        self.window!.makeKeyAndVisible()
        
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

