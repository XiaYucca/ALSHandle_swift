//
//  PhysicsAnimationView.h
//  AlsRobot_4WD
//
//  Created by RainPoll on 2017/2/15.
//  Copyright © 2017年 RainPoll. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "XYDirectionCalculate.h"

#define DRANGBTNWIDTH 60

@protocol PhysicsAnimationViewProtocol <NSObject>

@optional

-(void)sendStr:(NSString *)str;

@end


@interface PhysicsAnimationView : UIView

@property(nonatomic,assign) CGFloat lineWidth;
@property(nonatomic,weak) UIColor *lineColor;
@property(nonatomic,strong) UIImage *itemImage;
@property(nonatomic,strong) UIImage *backImage;

-(void)didDidDrag:(void(^)(DERICTION der))didDrag;

-(void)stopAccelerometerUpdates;
-(void)startAccelerometerUpdates;

@end
