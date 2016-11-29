//
//  AppDelegate.swift
//  ALSHandle_swift
//
//  Created by RainPoll on 16/10/17.
//  Copyright © 2016年 RainPoll. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var vc:UIViewController?
    
    
    func animate1(imagev:UIImageView) {
        
        print(imagev.superview);
      //    imagev.frame.origin.y = 275;
        imagev.image = UIImage.init(named: "loading1")
        print("animate \(imagev)")
        
    }
    func animate2(imagev:UIImageView) {
      //        imagev.frame.origin.y = 275;
        imagev.image = UIImage.init(named: "loading2")
    }

    func animate3(imagev:UIImageView) {
       //       imagev.frame.origin.y = 275;
        imagev.image = UIImage.init(named: "loading3")
    }

    func animate4(imagev:UIImageView) {
       //       imagev.frame.origin.y = 275;
        imagev.image = UIImage.init(named: "loading4")
    }

    func animate5(imagev:UIImageView) {
        //      imagev.frame.origin.y = 275;
        imagev.image = UIImage.init(named: "loading5")
    }

    func animate6(imagev:UIImageView) {
       //       imagev.frame.origin.y = 275;
        imagev.image = UIImage.init(named: "loading6")
    }

    func animate7(imagev:UIImageView) {
       //       imagev.frame.origin.y = 275;
        imagev.image = UIImage.init(named: "loading7")
    }
    func animate8(imagev:UIImageView) {
       //       imagev.frame.origin.y = 275;
        imagev.image = UIImage.init(named: "loading8")
        imagev.superview?.removeFromSuperview()
        print("loading8")
    }


    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        print(launchOptions?.first)
        
        let mainWindow = UIApplication.shared.delegate?.window!
        mainWindow?.makeKeyAndVisible()
        
        
        let launchStory = UIStoryboard.init(name: "LaunchScreen", bundle:nil)
        let vc = launchStory.instantiateViewController(withIdentifier: "launch")
        
//        let vc = UIViewController.init();
//        self.vc = vc
        vc.view.frame = (mainWindow?.frame)!;
        
        let imageV = UIImageView.init(frame: (mainWindow?.frame)!);
        
        vc.view.addSubview(imageV)
        
        print(mainWindow)
        
        print(mainWindow?.subviews)
        
        
        let mainView = vc.view
        mainView?.frame = (mainWindow?.frame)!;
       
        print(mainView?.subviews)
        //vc.view.frame = (mainWindow?.frame)!
        
        mainWindow?.addSubview(mainView!);
        
        print(mainWindow?.subviews)
        
        let oldAnimate = mainView?.viewWithTag(100)as! UIImageView
        
        print(oldAnimate.image)

        let animateV = UIImageView.init(frame: CGRect.init(x: 0, y: 275, width: 500, height: 56));
        
        mainView?.addSubview(animateV)
        animateV.center = (mainView?.center)!;
        animateV.frame.origin.y = 275;
        
        mainWindow?.bringSubview(toFront: vc.view)
   
        

       // oldAnimate?.removeFromSuperview()
        
        self.perform(#selector(self.animate1(imagev:)), with: animateV, afterDelay: 0.1)
        self.perform(#selector(self.animate2(imagev:)), with: animateV, afterDelay: 0.3)
        self.perform(#selector(self.animate3(imagev:)), with: animateV, afterDelay: 0.5)
        self.perform(#selector(self.animate4(imagev:)), with: animateV, afterDelay: 0.7)
        self.perform(#selector(self.animate5(imagev:)), with: animateV, afterDelay: 1.0)
        self.perform(#selector(self.animate6(imagev:)), with: animateV, afterDelay: 1.2)
        self.perform(#selector(self.animate7(imagev:)), with: animateV, afterDelay: 1.4)
        self.perform(#selector(self.animate8(imagev:)), with: animateV, afterDelay: 1.6)

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






