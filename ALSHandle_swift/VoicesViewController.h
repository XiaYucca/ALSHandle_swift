//
//  VoicesViewController.h
//  AlsRobot_4WD
//
//  Created by RainPoll on 2017/1/10.
//  Copyright © 2017年 RainPoll. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYDirectionCalculate.h"


@interface VoicesViewController : UIViewController

-(void)startRecognitionWithoutUI;
-(void)endRecongnitionWithInstraction:(void(^)(DERICTION deric))callback;

-(void)endRecongnitionWithString:(void(^)(NSString *result))recongnitionString;

-(void)endMetchWithString:(void(^)(NSArray *result))metchBlock;

-(void)speakEnd;

@end
