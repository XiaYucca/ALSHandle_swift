//
//  SetingViewController.swift
//  ALSHandle_swift
//
//  Created by RainPoll on 2016/10/24.
//  Copyright © 2016年 RainPoll. All rights reserved.
//

import Foundation
import UIKit


protocol transformCanvas:NSObjectProtocol {
    func setData();
    func changleOption(option:OptionTag,value:String);
}
//MARK: 数据层
enum OptionTag:Int {
    case up = 1001;
    case upRight = 1002
    case right = 1003
    case downRight = 1004
    case down = 1005
    case downLeft = 1006
    case left = 1007
    case upLeft = 1008
    
    case aValue = 1009
    case bValue = 1010
    case cValue = 1011
    case dValue = 1012
    case oriValue = 1013
}
//MARK: 模型层
struct OptionData {
    
    var up = "";
    var upRight = ""
    var right = ""
    var downRight = ""
    var down = ""
    var downLeft = ""
    var left = ""
    var upLeft = ""
    var aValue = ""
    var bValue = ""
    var cValue = ""
    var dValue = ""
    var oriValue = ""
    
    weak public var delegate:transformCanvas?;
    
    init() {
        
        print("optiondata init");
    }
    

    mutating func setValueByTag(_ tag:Int, _ value:String) {
        
        let t:OptionTag = OptionTag(rawValue: tag)!;
        
        print(t);
        
        delegate?.changleOption(option: t, value: value);
        switch t {
        case .up:
            print("UP !!!")
            self.up = value;
        case .upRight:
            self.upRight = value;
        case .right:
            self.right = value;
        case .downRight :
            self.downRight = value;
        case .down:
            self.down = value;
        case .downLeft:
            self.downLeft = value;
        case .left:
            self.left = value;
        case .upLeft:
            self.upLeft = value;
        case.aValue:
            self.aValue = value;
        case .bValue:
            self.bValue = value
        case .cValue:
            self.cValue = value
        case .dValue:
            self.dValue = value
        case .oriValue:
            self.oriValue = value
        default:
            print("not found ");
        }
    }
    
    func getValueByTag(_ tag:Int) -> String {
        
        let t:OptionTag = OptionTag(rawValue: tag)!;
        
        switch t {
        case .up:
            print("UP !!!");
           return self.up ;
        case .upRight:
           return  self.upRight ;
        case .right:
           return self.right ;
        case .downRight :
           return self.downRight;
        case .down:
           return  self.down ;
        case .downLeft:
           return self.downLeft ;
        case .left:
          return  self.left ;
        case .upLeft:
           return self.upLeft;
        case.aValue:
           return self.aValue ;
        case .bValue:
           return self.bValue
        case .cValue:
           return self.cValue
        case .dValue:
           return self.dValue
        case .oriValue:
           return self.oriValue
            
        default:
            print("not found ");
            return "";
        }

    }
}

//MARK: 模型类
class OptionDataClass: NSObject,NSCoding {
    var up = ""
    var upRight = ""
    var right = ""
    var downRight = ""
    var down = ""
    var downLeft = ""
    var left = ""
    var upLeft = ""
    var aValue = ""
    var bValue = ""
    var cValue = ""
    var dValue = ""
    var oriValue = ""
    
    func encode(with aCoder: NSCoder){
        aCoder.encode(self.up, forKey: "up")
        aCoder.encode(self.upRight, forKey: "upRight")
        aCoder.encode(self.right, forKey: "right")
        aCoder.encode(self.downRight, forKey: "downRight")
        aCoder.encode(self.down, forKey: "down")
        aCoder.encode(self.downLeft, forKey: "downLeft")
        aCoder.encode(self.left, forKey: "left")
        aCoder.encode(self.upLeft, forKey: "upLeft")
        aCoder.encode(self.aValue, forKey: "aValue")
        aCoder.encode(self.bValue, forKey: "bValue")
        aCoder.encode(self.cValue, forKey: "cValue")
        aCoder.encode(self.dValue, forKey: "dValue")
        aCoder.encode(self.oriValue, forKey: "oriValue")
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init();
        self.up = aDecoder.decodeObject(forKey: "up")as! String;
        self.upRight = aDecoder.decodeObject(forKey: "upRight")as! String;
        self.right = aDecoder.decodeObject(forKey: "right")as! String;
        self.downRight = aDecoder.decodeObject(forKey: "downRight")as! String;
        self.down = aDecoder.decodeObject(forKey: "down")as! String;
        self.downLeft = aDecoder.decodeObject(forKey: "downLeft")as! String;
        self.left = aDecoder.decodeObject(forKey: "left")as! String;
        self.upLeft = aDecoder.decodeObject(forKey: "upLeft")as! String;
        
        self.aValue = aDecoder.decodeObject(forKey: "aValue")as! String;
        self.bValue = aDecoder.decodeObject(forKey: "bValue")as! String;
        self.cValue = aDecoder.decodeObject(forKey: "cValue")as! String;
        self.dValue = aDecoder.decodeObject(forKey: "dValue")as! String;
        self.oriValue = aDecoder.decodeObject(forKey: "oriValue")as! String;
    }
    
    override init(){
        super.init();
       // self.up = "init up"
    }
    
    deinit {
        print("option Class deinit");
    }
}

//MARK: -- 归档文件
//内部函数
func unarchive()->Any?{
    
    let path:String! = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first;
    
    let filePath = path.appending("/my_Archiver")
    let unArchive = NSKeyedUnarchiver.unarchiveObject(withFile: filePath);
    return unArchive;
}
func optionFromDocument() -> OptionData {
    
    if(optionData == nil){
        optionData = OptionData()
    }
    var optionClass = unarchive()as? OptionDataClass;
    
    print("-----------------------\(optionClass?.up)")
    
    if(optionClass == nil){
        optionClass = OptionDataClass();
    }
        
    optionData!.up = optionClass!.up;
    optionData!.upRight = optionClass!.upRight;
    optionData!.right = optionClass!.right;
    optionData!.downRight = optionClass!.downRight;
    optionData!.down = optionClass!.down;
    optionData!.downLeft = optionClass!.downLeft;
    optionData!.left = optionClass!.left;
    optionData!.upLeft = optionClass!.upLeft;
    
    optionData!.aValue = optionClass!.aValue;
    optionData!.bValue = optionClass!.bValue;
    optionData!.cValue = optionClass!.cValue;
    optionData!.dValue = optionClass!.dValue;
    optionData!.oriValue = optionClass!.oriValue;
    
    return optionData!;
}

func optionWriteToFile() -> Bool {
    
    /// 归档代码
    func archive(obj:Any!)->Bool {
        // 之前保存的位置
        let path:String! = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first;
        
        let filePath = path.appending("/my_Archiver")
        print(filePath);
        return NSKeyedArchiver.archiveRootObject(obj, toFile: filePath);
    }
    
    let optionClass:OptionDataClass = OptionDataClass();
    
    optionClass.up = optionData!.up;
    optionClass.upRight = optionData!.upRight;
    optionClass.right = optionData!.right;
    optionClass.downRight = optionData!.downRight;
    optionClass.down = optionData!.down;
    optionClass.downLeft = optionData!.downLeft;
    optionClass.left = optionData!.left;
    optionClass.upLeft = optionData!.upLeft;
    
    optionClass.aValue = optionData!.aValue;
    optionClass.bValue = optionData!.bValue;
    optionClass.cValue = optionData!.cValue;
    optionClass.dValue = optionData!.dValue;
    optionClass.oriValue = optionData!.oriValue;
    
    
    let result = archive(obj: optionClass);
    return result
}

//MARK: 设置界面控制器

class SetingViewController: UIViewController,UITextFieldDelegate {
    
    var selectTextField : UITextField?;
    
    @IBOutlet weak var tailLabel: CUSFlashLabel!
    @IBOutlet weak var tipsLabel: CUSFlashLabel!
    
    @IBOutlet weak var centerLine: NSLayoutConstraint!
    
    var tempOptionData:OptionData?;
    
    override func viewDidLoad() {
        
        if(self.tempOptionData == nil){
            self.tempOptionData = OptionData();
        }
        
        print("seting view didload optiondata\(optionData)")
        NotificationCenter.default.addObserver(self, selector:#selector(SetingViewController.keyboardWillShow(info:)), name: Notification.Name.UIKeyboardWillShow, object: nil);
        
                NotificationCenter.default.addObserver(self, selector:#selector(SetingViewController.keyboardWillHide(info:)), name: Notification.Name.UIKeyboardWillHide, object: nil);
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print(optionData)
    }
    
    
    func keyboardWillShow(info:Notification) {
        
        let temp = info.userInfo?[AnyHashable("UIKeyboardBoundsUserInfoKey")]
        let temp2 = (info.userInfo?[AnyHashable("UIKeyboardBoundsUserInfoKey")] as! NSValue).cgRectValue;
        
        print("\(temp)")
        print(temp2.size);
        
        
        let het = (self.selectTextField?.frame.maxY)! + (self.selectTextField?.superview?.frame.minY)! + (self.selectTextField?.superview?.superview?.frame.minY)!+(self.selectTextField?.superview?.superview?.superview?.frame.minY)!
        print("het----\(het)");
        
        let height_t = self.view.frame.height - het-44
        let allowMaxY_k = temp2.size.height
        
        print("height \(height_t)  allowmaxY\(allowMaxY_k)")
        
        if height_t < allowMaxY_k {
            
            let orgC = self.centerLine.constant;
            self.centerLine.constant = orgC - (allowMaxY_k - height_t);
            
            UIView.animate(withDuration: 0.25, animations: { 
                self.view.layoutIfNeeded();
            });
            
        }
     }
 
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated);
        
         NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
         NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
    func keyboardWillHide(info:Notification) {
        self.centerLine.constant = 0;

        UIView.animate(withDuration: 0.25, animations: {
            self.view.layoutIfNeeded();
        });
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        optionData = optionFromDocument()
        
        self.tempOptionData = optionData;
        
         print("seting view didappear optiondata\(optionData)")
         if(self.tempOptionData == nil){
            self.tempOptionData = optionData
         }
        
        super.viewWillAppear(animated);
        for tag in 1001...1013 {

            let testF1 = self.view.viewWithTag(tag) as! UITextField;
            testF1.text = self.tempOptionData!.getValueByTag(tag);
            testF1.delegate = self;
        }
        if isBlueToothConnect {
            self.tipsLabel.text = "TIPS: 手机/平板已经连接到蓝牙设备"
        }else{
            self.tipsLabel.text = "TIPS:连接时将手机/平板靠近蓝牙设备"
        }
        self.tailLabel.spotlightColor = UIColor.white;
        self.tipsLabel.spotlightColor = UIColor.white;
        
        self.tailLabel.contentMode = UIViewContentMode.topRight
        self.tipsLabel.contentMode = UIViewContentMode.topRight
        
        self.tailLabel.startAnimating();
        self.tipsLabel.startAnimating();
        
        self.loadOptionData(data: selectOpentionType);
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
        
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        self.selectTextField = textField;
        print("开始编辑");
        return true;
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        

        return true;
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
       
        print("textfield will return");
        self.tempOptionData!.setValueByTag(textField.tag, textField.text!);
        textField.resignFirstResponder();
        return true
    }
    
    @IBAction func backBtn_click(_ sender: AnyObject) {
        self.dismiss(animated: true) { 
            
        };
    }

    @IBAction func saveBtn_click(_ sender: AnyObject) {
        
        optionData = self.tempOptionData!;
        if optionWriteToFile() {
            
            let acv = UIAlertAction.init(title: "好的", style: UIAlertActionStyle.default , handler: { (actoin) in
            })
            let acvc = UIAlertController.init(title: "保存成功", message:nil, preferredStyle: UIAlertControllerStyle.alert)
            acvc.addAction(acv);
            self.present(acvc, animated: true, completion: {
                
                DispatchQueue.main.asyncAfter(deadline: (DispatchTime.now()+2.0), execute: {
                    acvc.dismiss(animated: true, completion: nil);
                })
            });
    
        }
    }
    
    @IBAction func optionBtnclick(sender: UIButton){
        
        print( "send++ ",sender.tag);
        
        let bt0 = self.view.viewWithTag(2000) as! UIButton!
        let bt1 = self.view.viewWithTag(2001) as! UIButton!

        let bt2 = self.view.viewWithTag(2002) as! UIButton!

        
        if sender.tag == 2000 {
            selectOpentionType = opentionType.touch
            bt0?.isSelected = true;
            bt1?.isSelected = false;
            bt2?.isSelected = false;
        
        }else if sender.tag == 2001{
            selectOpentionType = opentionType.gravity
            bt0?.isSelected = false;
            bt1?.isSelected = true;
            bt2?.isSelected = false;
        }else{
            selectOpentionType = opentionType.voice
            bt0?.isSelected = false;
            bt1?.isSelected = false;
            bt2?.isSelected = true;
            
        }
        }
    
    
    func loadOptionData(data:opentionType) {
        
        let bt0 = self.view.viewWithTag(2000) as! UIButton!
        let bt1 = self.view.viewWithTag(2001) as! UIButton!
        let bt2 = self.view.viewWithTag(2002) as! UIButton!
        
        
        if(data == opentionType.gravity){
            bt0?.isSelected = false;
            bt1?.isSelected = true;
            bt2?.isSelected = false;
        }else if data == opentionType.voice{
            bt0?.isSelected = false;
            bt1?.isSelected = false;
            bt2?.isSelected = true;
            
        }else{
            bt0?.isSelected = true;
            bt1?.isSelected = false;
            bt2?.isSelected = false;
        }
        
    }

    
    
    
    
 

}


class AboutViewController: UIViewController {
    
    override func viewDidLoad() {
        

        
    }
    @IBAction func backBtnClick(_ sender: AnyObject) {
        
        self.dismiss(animated: true, completion: nil);
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        let clabel = self.view.viewWithTag(1002)as! CUSFlashLabel
//        clabel.spotlightColor = UIColor.black
//        clabel.contentMode = UIViewContentMode.topRight
//        clabel.startAnimating()
//
        
        for i in 1003...1005 {
            let clabel = self.view.viewWithTag(i)as! CUSFlashLabel
            
            if i < 1003{
                 clabel.spotlightColor = UIColor.black

            }else{
                clabel.spotlightColor = UIColor.white

            }
            clabel.contentMode = UIViewContentMode.topRight
            clabel.startAnimating()
        }
    }
}


//func motionTest() {
//    motion?.accelerometerUpdateInterval(0.5, callBack: { (acceleration, error) in
//        print(acceleration)
//      //  print(error!);
//    })
//}




/*(function(){var ver="1.0.1";
    try{ver=opener.QC.getVersion();}
    catch(e){}
    ver=ver?"-"+ver:ver;
    var qc_script;var reg=/\/qzone\/openapi\/qc_loader\.js/i;
    var scripts=document.getElementsByTagName("script");
    for(var i=0,script,l=scripts.length;i<l;i++){script=scripts[i];
        var src=script.src||"";var mat=src.match(reg);
        if(mat){qc_script=script;break;}}
            var s_src='http://qzonestyle.gtimg.cn/qzone/openapi/qc'+ver+'.js';
            var arr=['src='+s_src+''];for(var i=0,att;i<qc_script.attributes.length;i++){att=qc_script.attributes[i];if(att.name!="src"&&att.specified){arr.push([att.name.toLowerCase(),'"'+att.value+'"'].join("="));}}
    if(document.readyState!='complete'){document.write('<script '+arr.join(" ")+' ><'+'/script>');}
    else{var s=document.createElement("script"),attr;s.type="text/javascript";s.src=s_src;
        
        for(var i=arr.length;i--;){attr=arr[i].split("=");if(attr[0]=="data-appid"||attr[0]=="data-redirecturi"||attr[0]=="data-callback"){s.setAttribute(attr[0],attr[1].replace(/\"/g,""));}}
        var h=document.getElementsByTagName("head");if(h&&h[0]){h[0].appendChild(s);}}})();*//*  |xGv00|c41a0054e10e6c99d6396d40e369e1a0 */













