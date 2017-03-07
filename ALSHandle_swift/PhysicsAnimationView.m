//
//  PhysicsAnimationView.m
//  AlsRobot_4WD
//
//  Created by RainPoll on 2017/2/15.
//  Copyright © 2017年 RainPoll. All rights reserved.
//

#import "PhysicsAnimationView.h"
#import "XYMotionManager.h"
#import "XYDirectionCalculate.h"



#define ratGraty(s) (s)*10

@interface BallView : UIImageView<UIDynamicItem>
@property (nonatomic) UIDynamicItemCollisionBoundsType collisionBoundsType;
@end

@implementation BallView
@synthesize collisionBoundsType; //一定要写上这句代码
@end

@interface SelfLayer : CALayer

@property(nonatomic ,assign)CGFloat lineWidth;
@property(nonatomic ,strong)UIColor *lineColor;

@property(nonatomic ,strong)UIImage *backIm;

@end

@implementation SelfLayer

@synthesize backIm = _backIm;
+(instancetype)layer{
    return [super layer];
}

-(void)setLineWidth:(CGFloat)lineWidth{
    if (_lineWidth != lineWidth) {
        _lineWidth = lineWidth;
        [self setNeedsDisplay];
    }
}

-(void)setLineColor:(UIColor *)lineColor{
    if (_lineColor != lineColor) {
        _lineColor = lineColor;
        [self setNeedsDisplay];
    }
}


-(void)setBackIm:(UIImage *)backIm{
    if (_backIm != backIm) {
        _backIm = backIm;
        
        [self setNeedsDisplay];
    }
}



-(void)drawInContext:(CGContextRef)ctx{
    NSLog(@"%s",__func__);
    NSLog(@"iamge ----%@",self.backIm);
    
    UIGraphicsPushContext(ctx);
    if (self.backIm) {
        
        [self.backIm drawInRect:CGRectMake(0, 0, self.frame.size.width,self.frame.size.height)];
        //    [self.backIm drawAsPatternInRect:CGRectMake(0, 0, self.frame.size.width,self.frame.size.height)];
    }
    
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path addArcWithCenter:CGPointMake(CGRectGetWidth(self.frame)*0.5, self.frame.size.height*0.5) radius:(self.frame.size.width-self.lineWidth*2) * 0.5 startAngle:0 endAngle:M_PI*2  clockwise:NO];
    CGContextAddPath(ctx, path.CGPath);
    
    CGContextSetLineWidth(ctx, 10);
    
    CGContextSetStrokeColorWithColor(ctx , self.lineColor.CGColor);
    CGContextStrokePath(ctx);
}
@end


@interface PhysicsAnimationView()

@property(nonatomic,strong)UIDynamicAnimator *animator;

@property(nonatomic,strong) UIGravityBehavior *gravityBehavitor;
@property(nonatomic,strong) UISnapBehavior *snapBehavitor;
@property (nonatomic ,copy)void(^didDrag)(DERICTION der);


@end

@implementation PhysicsAnimationView{
    CGVector grateVector;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
-(CGFloat )lineWidth{
    if (!_lineWidth ) {
        _lineWidth = 5.0;
    }
    return  _lineWidth;
}

-(UIColor *)lineColor{
    if (!_lineColor) {
        _lineColor = [UIColor clearColor];
    }
    return _lineColor;
}
-(UIImage *)backImage{
    if (!_backImage) {
        _backImage = [UIImage imageNamed:@"摇杆-点击背景.png"];
    }
    return  _backImage;
}
-(UIImage *)itemImage{
    if (!_itemImage) {
        _itemImage = [UIImage imageNamed:@"ball_icon.png"];
    }
    return _itemImage;
}

-(void)setGrateVector:(CGVector)vector{
    
    vector = CGVectorMake(vector.dx * 10, vector.dy * 10);
    NSLog(@"------x%.2f------y%.2f",vector.dx,vector.dy);
    
    if ( (vector.dx < ratGraty(0.2) && vector.dx > -ratGraty(0.2))&& (vector.dy < ratGraty(0.2) && vector.dy > -ratGraty(0.2))) {
        
        _gravityBehavitor.gravityDirection = CGVectorMake(0, 0);
        grateVector = CGVectorMake(0, 0);
        [self.animator removeBehavior:self.gravityBehavitor];
        [self moveToCenter];
        return;
    }
    if (grateVector.dx != vector.dx || grateVector.dy != vector.dy ) {
        grateVector = vector;
        _gravityBehavitor.gravityDirection = vector;
        [self.animator removeBehavior:self.snapBehavitor];
        [self.animator addBehavior:self.gravityBehavitor];
    }
}

-(void)moveToCenter{
    
    self.snapBehavitor.damping = 1;
    self.snapBehavitor.snapPoint = CGPointMake(CGRectGetWidth(self.frame)*0.5, CGRectGetHeight(self.frame)*0.5);
    [self.animator addBehavior:self.snapBehavitor];
}

-(instancetype)initWithFrame:(CGRect)frame{
    
    XYMotionManager *motionM = [XYMotionManager shareMotionManager];
    
    // #define MJWeakSelf __weak typeof(self) weakSelf = self;
    __weak PhysicsAnimationView *weakSelf = self;
    
    __block int i = 0;
    [motionM accelerometerUpdateInterval:0.05 CallBack:^(XYacceleration acceleration, NSError *error) {
        
        NSLog(@"accelerationX:%.2f accelerationY:%.2f accelerationZ:%.2f",acceleration.X,acceleration.Y,acceleration.Z);
        
        [weakSelf setGrateVector:CGVectorMake(acceleration.Y, acceleration.X)];
        
        if(i++ >10){
         [weakSelf autoSendOrderWithTranslation:CGPointMake((int)(acceleration.Y*10), (int)(acceleration.X*10))];
            i=0;
        }
     }];
    
    return [super initWithFrame:frame];
}

-(void)stopAccelerometerUpdates{
    XYMotionManager *motionM = [XYMotionManager shareMotionManager];
    [motionM stopAccelerometerUpdates];
}
-(void)startAccelerometerUpdates{
    
    XYMotionManager *motionM = [XYMotionManager shareMotionManager];
    [motionM startAccelerometerUpdates];
}

-(void)drawRect:(CGRect)rect{
    
    SelfLayer *sl = [SelfLayer layer];
    sl.frame = self.layer.frame;
    sl.lineWidth = (double)self.lineWidth;
    sl.lineColor = self.lineColor;
    sl.backIm = self.backImage;
    
    [self.layer addSublayer:sl];
    
    [self setupPyhsicsAnimate:rect];
}


-(void)setupPyhsicsAnimate:(CGRect)rect{
    
    NSLog(@"%s",__func__);
    BallView *itemV = [[BallView alloc]initWithFrame:CGRectMake(self.frame.size.width * 0.5, self.frame.size.height*0.5, DRANGBTNWIDTH, DRANGBTNWIDTH)];
    //  itemV.backgroundColor = [UIColor redColor];
  //  itemV.layer.cornerRadius = 25;
  //  itemV.layer.masksToBounds = YES;
    itemV.collisionBoundsType = UIDynamicItemCollisionBoundsTypeRectangle;
    

    itemV.image =  self.itemImage;
    
    [self addSubview:itemV];
    
    self.animator = [[UIDynamicAnimator alloc]initWithReferenceView:self];
    
    UIGravityBehavior *gravityBehavitor = [[UIGravityBehavior alloc]initWithItems:@[itemV]];
    //  gravityBehavitor.gravityDirection = CGVectorMake(1, 0.5);
    
    gravityBehavitor.magnitude = 0.5;
    
    UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc]initWithItems:@[itemV]];
    collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path addArcWithCenter:self.center radius:self.frame.size.width * 0.5-self.lineWidth startAngle:0 endAngle:M_PI*2  clockwise:NO];
    
    [collisionBehavior addBoundaryWithIdentifier:@"path1" forPath:path];
    
    UISnapBehavior *snapBehavior = [[UISnapBehavior alloc]initWithItem:itemV snapToPoint:CGPointZero];
    UIDynamicItemBehavior *itemBehavior = [[UIDynamicItemBehavior alloc]initWithItems:@[itemV,self]];
    itemBehavior.friction = 0.05;
    
    
    [self.animator addBehavior:gravityBehavitor];
    [self.animator addBehavior:collisionBehavior];
    [self.animator addBehavior:itemBehavior];
    //    [self.animator addBehavior:snapBehavior];
    
    self.gravityBehavitor = gravityBehavitor;
    self.snapBehavitor = snapBehavior;
}


#pragma mark  计算坐标 并发送数据
-(NSInteger)autoSendOrderWithTranslation:(CGPoint)translation
{   static BOOL stop = NO;
    
    DERICTION D = WHEEL_ORIGOIN;
    
    CGFloat r = getAngleWithVector(translation);
    int result = getDeriction(r);
    
    NSLog(@" angle --%f   v --%d",r,result);
    printf("angle -%f v--%d\n",r,result);
    //只运行一次
    if (result == 0) {
        if (stop == NO) {
            [self sendStr:@"s"];
            stop = YES;
        }
    }
    else{
        stop = NO;
        switch (result) {
            case 0:
                //       [self sendStr:@"s"];
                D = WHEEL_ORIGOIN;
                break;
            case 1:
                [self sendStr:@"d"];
                D = WHEEL_LEFT;
                break;
            case 2:
                [self sendStr:@"e"];
                D = WHEEL_LEFT_UP;
                break;
            case 3:
                [self sendStr:@"w"];
                D = WHEEL_UP;
                break;
            case 4:
                [self sendStr:@"q"];
                D = WHEEL_RIGHT_UP;
                break;
            case 5:
                [self sendStr:@"a"];
                D = WHEEL_RIGHT;
                break;
            case 6:
                [self sendStr:@"z"];
                D = WHEEL_RIGHT_DOWN;
                break;
            case 7:
                [self sendStr:@"x"];
                D = WHEEL_DOWN;
                break;
            case 8:
                [self sendStr:@"c"];
                D = WHEEL_LEFT_DOWN;
                break;
                
            default:
                break;
        }
    }
    
    !self.didDrag ?: self.didDrag(D);
    
    
    return result;
}

-(void)didDidDrag:(void(^)(DERICTION der))didDrag
{
    self.didDrag = didDrag;
}

-(void)sendStr:(NSString *)str
{
    
}




@end
