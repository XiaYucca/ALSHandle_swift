//
//  PhysicsAnimationView.m
//  AlsRobot_4WD
//
//  Created by RainPoll on 2017/2/15.
//  Copyright © 2017年 RainPoll. All rights reserved.
//

#import "PhysicsAnimationView.h"
#import "XYMotionManager.h"

#define ratGraty(s) (s)*100
#pragma mark - 中间小球
@interface BallView : UIImageView<UIDynamicItem>
@property (nonatomic) UIDynamicItemCollisionBoundsType collisionBoundsType;
@end

@implementation BallView
@synthesize collisionBoundsType; //一定要写上这句代码
@end

#pragma mark - 边框显示层
@interface SelfLayer : CALayer

@property(nonatomic ,assign)CGFloat lineWidth;

@property(nonatomic ,strong)UIColor *lineColor;

@end

@implementation SelfLayer

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

-(void)drawInContext:(CGContextRef)ctx{
    NSLog(@"%s",__func__);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path addArcWithCenter:CGPointMake(CGRectGetWidth(self.frame)*0.5, self.frame.size.height*0.5) radius:(self.frame.size.width-self.lineWidth*2) * 0.5 startAngle:0 endAngle:M_PI*2  clockwise:NO];
    CGContextAddPath(ctx, path.CGPath);
    
    CGContextSetLineWidth(ctx, 10);
    
    CGContextSetStrokeColorWithColor(ctx , self.lineColor.CGColor);
    CGContextStrokePath(ctx);
}
@end

#pragma mark - 逻辑处理层
@interface PhysicsAnimationView()

@property(nonatomic,strong)UIDynamicAnimator *animator;

@property(nonatomic,strong) UIGravityBehavior *gravityBehavitor;
@property(nonatomic,strong) UISnapBehavior *snapBehavitor;
@property(nonatomic,assign) CGFloat lineWidth;
@property(nonatomic,weak) UIColor *lineColor;

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
    if (_lineWidth == 0) {
        _lineWidth = 5.0;
    }
    return  _lineWidth;
}

-(UIColor *)lineColor{
    if (!_lineColor) {
        _lineColor = [UIColor blueColor];
    }
    return _lineColor;
}

-(void)setGrateVector:(CGVector)vector{
    
    vector = CGVectorMake(-vector.dx * 100, -vector.dy * 100);
    NSLog(@"------x%.2f------y%.2f",vector.dx,vector.dy);
    
    if ( (vector.dx < ratGraty(0.15) && vector.dx > -ratGraty(0.15))&& (vector.dy < ratGraty(0.15) && vector.dy > -ratGraty(0.15))) {
        
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
    
    [motionM accelerometerUpdateInterval:0.5 CallBack:^(XYacceleration acceleration, NSError *error) {
        
        NSLog(@"accelerationX:%.2f accelerationY:%.2f accelerationZ:%.2f",acceleration.X,acceleration.Y,acceleration.Z);
        
        [weakSelf setGrateVector:CGVectorMake(acceleration.Y, acceleration.X)];
    }];
    
    return [super initWithFrame:frame];
}

-(void)drawRect:(CGRect)rect{
    
    SelfLayer *sl = [SelfLayer layer];
    sl.frame = self.layer.frame;
    sl.lineWidth = (double)self.lineWidth;
    sl.lineColor = self.lineColor;

    [self.layer addSublayer:sl];
    
    [self setupPyhsicsAnimate:rect];
}


-(void)setupPyhsicsAnimate:(CGRect)rect{
    
    NSLog(@"%s",__func__);
    BallView *itemV = [[BallView alloc]initWithFrame:CGRectMake(self.frame.size.width * 0.5, self.frame.size.height*0.5, 50, 50)];
//  itemV.backgroundColor = [UIColor redColor];
    itemV.layer.cornerRadius = 25;
    itemV.layer.masksToBounds = YES;
    itemV.collisionBoundsType = UIDynamicItemCollisionBoundsTypeEllipse;

    itemV.image = [UIImage imageNamed:@"ball_icon.png"];
    [self addSubview:itemV];
    
    self.animator = [[UIDynamicAnimator alloc]initWithReferenceView:self];
    
    UIGravityBehavior *gravityBehavitor = [[UIGravityBehavior alloc]initWithItems:@[itemV]];
//  gravityBehavitor.gravityDirection = CGVectorMake(1, 0.5);
   
    gravityBehavitor.magnitude = 5;
    
    UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc]initWithItems:@[itemV]];
    collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path addArcWithCenter:self.center radius:self.frame.size.width * 0.5-self.lineWidth startAngle:0 endAngle:M_PI*2  clockwise:NO];
    
    [collisionBehavior addBoundaryWithIdentifier:@"path1" forPath:path];
    
    UISnapBehavior *snapBehavior = [[UISnapBehavior alloc]initWithItem:itemV snapToPoint:CGPointZero];
    UIDynamicItemBehavior *itemBehavior = [[UIDynamicItemBehavior alloc]initWithItems:@[itemV,self]];
    itemBehavior.friction = 0.5;
    
    
    [self.animator addBehavior:gravityBehavitor];
    [self.animator addBehavior:collisionBehavior];
    [self.animator addBehavior:itemBehavior];
//    [self.animator addBehavior:snapBehavior];
    
    self.gravityBehavitor = gravityBehavitor;
    self.snapBehavitor = snapBehavior;
}





@end
