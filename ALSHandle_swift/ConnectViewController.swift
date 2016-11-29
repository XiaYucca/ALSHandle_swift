//
//  ConnectViewController.swift
//  ALSHandle_swift
//
//  Created by RainPoll on 2016/10/24.
//  Copyright © 2016年 RainPoll. All rights reserved.
//

import Foundation



class ConnectViewController: ViewController {
    @IBOutlet weak var leftConstraints: NSLayoutConstraint!
    @IBOutlet weak var tipsLabel: CUSFlashLabel!
    @IBOutlet weak var handleLabel: CUSFlashLabel!
    
    @IBOutlet weak var contentView: AlertView!
    @IBOutlet weak var backBtn: UIButton!
    
    @IBOutlet weak var blueToothStuts: UIButton!
    
    var timer:Timer?;
    
    override func viewDidLoad() {
        
        self.backBtn.addTarget(self, action:#selector(ConnectViewController.backBtn_click), for: UIControlEvents.touchUpInside);
    }
   
    func backBtn_click() {
        self.dismiss(animated: true, completion: nil);
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let result = (serialManager.isConnect)
        print(result);
        
        if(result){
            return
        }
        
        if(!result){
            serialManager?.blueToothAutoScaning(1, withTimeOut: 15, autoConnectDistance: -50, didConnected: { (p) in
                print("connected");
                                print(p)
                                isBlueToothConnect = true;
                                self.blueToothStuts.isSelected = true
                
                
                                let acv = UIAlertAction.init(title: "好的", style: UIAlertActionStyle.default , handler: { (actoin) in
                
                                    self.dismiss(animated: true, completion: nil);
                                })
                                let acvc = UIAlertController.init(title: "系统提示", message: "蓝牙已经连接", preferredStyle: UIAlertControllerStyle.alert)
                                acvc.addAction(acv);
                                self.present(acvc, animated: true, completion: {
                
                                    DispatchQueue.main.asyncAfter(deadline: (DispatchTime.now()+2), execute: {
                                        acvc.dismiss(animated: true, completion: nil)
                                        self.dismiss(animated: true, completion: nil)
                                    })
                                    
                                });
                
            }) {
                print("time out")
            }
            
        }
        
        if(isBlueToothConnect){
            self.blueTouchStuts.isSelected = true;
        }else{
            self.blueToothStuts.isSelected = false;
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated);

         let _contentView = Bundle.main.loadNibNamed("AlertView", owner: nil, options: nil)?.first as! AlertView;
        _contentView.frame = self.contentView.frame;
        self.contentView = _contentView;
        
        self.view.addSubview(self.contentView);
        
        
        tipsLabel.contentMode = UIViewContentMode.topRight;
        tipsLabel.spotlightColor = UIColor.white;
        tipsLabel.startAnimating();
        
        handleLabel.spotlightColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1);
        handleLabel.startAnimating();
        
        if #available(iOS 10.0, *) {
            self.timer = Timer.scheduledTimer(withTimeInterval: 1.7, repeats: true) { (t) in
                
                            UIView.animate(withDuration: 1, animations: {
                                self.leftConstraints.constant = 100;
                                self.view.layoutIfNeeded();
                            }) { (_) in
                                
                                UIView.animate(withDuration: 0.6, animations: {
                                    self.leftConstraints.constant = 101;
                                    self.view.layoutIfNeeded();
                                    }, completion: { (_) in
                                        self.leftConstraints.constant = -100;
                                        self.view.layoutIfNeeded();

                                })
                            }

                print("time run");
            }
        } else {
            // Fallback on earlier versions
        }
        
        
        
        
        //_timer.invalidate()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        self.timer?.invalidate();
        self.timer = nil;
        
        serialManager.unenableAutoScaning();
    }
}






