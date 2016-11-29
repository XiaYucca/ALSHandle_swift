//
//  AlertView.swift
//  ALSHandle_swift
//
//  Created by RainPoll on 2016/10/24.
//  Copyright © 2016年 RainPoll. All rights reserved.
//

import Foundation

class AlertView: UIView {
    
    @IBOutlet weak var contentLabel : CUSFlashLabel!
    @IBOutlet weak var tip: UIImageView!

    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }
    
    override func awakeFromNib() {
        super.awakeFromNib();
   
        print(self);
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect);
        
        if self.subviews.count == 0{
            
            return;
            
        }
        self.contentLabel.spotlightColor = #colorLiteral(red: 0.8235965371, green: 0.8545945883, blue: 0.9209875464, alpha: 1)
        self.contentLabel.contentMode = UIViewContentMode.center;
        self.contentLabel.startAnimating();
        
        if #available(iOS 10.0, *) {
            _ = Timer.scheduledTimer(withTimeInterval: 0.8, repeats: true, block: { (t) in
                UIView.animate(withDuration: 0.5, animations: {
                    
                    //tipsV.transform = tipsV.transform.scaledBy(x: 1.5, y: 1.5);
                    self.tip.transform = CGAffineTransform.init(scaleX: 1.5, y: 1.5)
                  //  print(self.tipsV);
                    }, completion: { (b) in
                        
                        self.tip.transform = CGAffineTransform.identity;
                        
                })
                
            })
        } else {
          
        }
        
    }
    
}
