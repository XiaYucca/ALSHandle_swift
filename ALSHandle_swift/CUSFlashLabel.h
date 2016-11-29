//
//  CUSFlashLabel.h
//  CUSFlashLabel
//
//  Created by xsw on 16/5/30.
//  Copyright © 2016年 xsw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CUSFlashLabel : UILabel
@property (nonatomic, retain) UIColor *spotlightColor;

- (void)startAnimating;

- (void)stopAnimating;
@end
