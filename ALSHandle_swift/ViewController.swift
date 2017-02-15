//
//  ViewController.swift
//  ALSHandle_swift
//
//  Created by RainPoll on 16/10/17.
//  Copyright © 2016年 RainPoll. All rights reserved.
//

import UIKit

//let serialManager :XYSerialManage? = nil;

enum opentionType {
    case touch
    case gravity
    case voice
    case downRight
};

var isBlueToothConnect:Bool = false ;

var serialManager :XYSerialManage! = XYSerialManage();

var optionData :OptionData? ;

var selectOpentionType:opentionType! = opentionType.touch;

//var motion = XYMotionManager.share();


class ViewController: UIViewController {
    
    @IBOutlet weak var AnimateBg: UIImageView!
    @IBOutlet weak var btn_d: UIButton!
    @IBOutlet weak var wheelV: SteeringWheel!
    //let sm = XYSerialManage();
    @IBOutlet weak var blueTouchStuts: UIButton!
    
    func btnClick(btn:UIButton) {
        switch btn.tag {
        case 100:
            serialManager.write(optionData!.aValue.data(using: String.Encoding.utf8));
            break
        case 101:
            serialManager.write(optionData!.bValue.data(using: String.Encoding.utf8));
            break
            
        case 102:
            serialManager.write(optionData!.cValue.data(using: String.Encoding.utf8));
            break
            
        case 103:
            serialManager.write(optionData!.dValue.data(using: String.Encoding.utf8));
            break
        default:
            print("clik unknow btn");
           
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // let fm = processImage(filePath:"/Users/rainpoll/Downloads/drawable-xhdpi");
        
        print("++++++++++++++++++++++++viewdid load")
        
       // motionTest();
        
        if(optionData == nil){
            optionData = optionFromDocument()
        }
        
        
        
        for tag in 100...103{
            let btn = self.view.viewWithTag(tag)as! UIButton;
            btn.addTarget(self, action: #selector(self.btnClick(btn:)), for: UIControlEvents.touchUpInside);
        }
        
        
        serialManager = XYSerialManage.init();
        
        
        serialManager?.misConnect({ (p) in
            print("misconnect");
            isBlueToothConnect = false;
            self.blueTouchStuts.isSelected = false;
            
            let acv = UIAlertAction.init(title: "好的", style: UIAlertActionStyle.default , handler: { (actoin) in
            })
            let acvc = UIAlertController.init(title: "系统提示", message: "蓝牙断开连接", preferredStyle: UIAlertControllerStyle.alert)
            acvc.addAction(acv);
            self.present(acvc, animated: true, completion: { 
            
                DispatchQueue.main.asyncAfter(deadline: (DispatchTime.now()+2.0), execute: { 
                    acvc.dismiss(animated: true, completion: nil);
                })
            });
         })
        
        self.rotationAnimation(view: AnimateBg)
        
        self.wheelV.bgImage = UIImage(named:"yaogan_bac");
        
//        self.wheelV.btnImage = UIImage(named:"drogBtn");
//        
        self.wheelV.btnDrgImage = UIImage(named:"drogBtn");
        
        self.wheelV.didDidDrag { (drag) in
            print(drag.rawValue);
            switch drag.rawValue{
            case 0:
               // print("org")
                
                serialManager.write(optionData!.oriValue.data(using: String.Encoding.utf8));
                break;
                
            case 1:
                serialManager.write(optionData!.up.data(using: String.Encoding.utf8));
                break;
            case 2:
                serialManager.write(optionData!.upRight.data(using: String.Encoding.utf8));
                break;
            case 3:
                serialManager.write(optionData!.right.data(using: String.Encoding.utf8));
                break;
            case 4:
                serialManager.write(optionData!.downRight.data(using: String.Encoding.utf8));
                break;
            case 5:
                serialManager.write(optionData!.down.data(using: String.Encoding.utf8));
                break;
            case 6:
                serialManager.write(optionData!.downLeft.data(using: String.Encoding.utf8));
                break;
            case 7:
                serialManager.write(optionData!.left.data(using: String.Encoding.utf8));
                break;
            case 8:
                serialManager.write(optionData!.upLeft.data(using: String.Encoding.utf8));
                break;
                
                
            default :
                print("")
            }
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear( animated)
        
        print("isblueTooth\(isBlueToothConnect)");
        
        if (isBlueToothConnect){
            self.blueTouchStuts.isSelected = true;
        }else{
            self.blueTouchStuts.isSelected = false;
        }
        
        

    //    var p =  processImage(filePath: "/Users/rainpoll/Desktop/小奥appUI")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func rotationAnimation(view:UIView){
        
        let anim = CABasicAnimation(keyPath:"transform.rotation");
        anim.toValue = M_PI;
        anim.duration = 2;
        anim.repeatCount = 10000;
        anim.isCumulative = true;
        anim.isRemovedOnCompletion = false;
        
        view.layer.anchorPoint = CGPoint.init(x: 0.4, y: 0.6)
        
        
        view.layer.add(anim, forKey: nil);
    }
    
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toConnectId"{
            print(segue.destination)
        }
    }

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
       
        if identifier == "toConnectId" {
            if(serialManager.isConnect){
                return false
            }else{
                return true
            }
        }else{
        return true
        }
    }
}












