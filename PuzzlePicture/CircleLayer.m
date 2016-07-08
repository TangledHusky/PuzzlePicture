//
//  CircleLayer.m
//  PuzzlePicture
//
//  Created by 李亚军 on 16/6/20.
//  Copyright © 2016年 zyyj. All rights reserved.
//

#import "CircleLayer.h"

@interface CircleLayer()
@property (strong, nonatomic) UIBezierPath *circleSmallPath;
@property (strong, nonatomic) UIBezierPath *circleBigPath;
@property (strong, nonatomic) UIBezierPath *circleVerticalSquishPath;
@property (strong, nonatomic) UIBezierPath *circleHorizontalSquishPath;

@end

static const NSTimeInterval KAnimationBeginTime = 0.0;
static const NSTimeInterval KAnimationDuration = 0.3;

@implementation CircleLayer

-(instancetype)init{
    self = [super init];
    if (self) {
        self.fillColor = [UIColor colorWithHexString:@"#da70d6"].CGColor;
        self.path=self.circleSmallPath.CGPath;
    }
    return self;
}

-(UIBezierPath *)circleSmallPath{
    if(_circleSmallPath==nil){
        _circleSmallPath=[UIBezierPath bezierPathWithOvalInRect:CGRectMake(50, 50, 0, 0)];
    }
    return  _circleSmallPath;
}

-(UIBezierPath *)circleBigPath{
    if(_circleBigPath==nil){
        _circleBigPath=[UIBezierPath bezierPathWithOvalInRect:CGRectMake(2.5, 17.5, 95, 95)];
    }
    return  _circleBigPath;
}
- (UIBezierPath *)circleVerticalSquishPath {
    if (!_circleVerticalSquishPath) {
        _circleVerticalSquishPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(2.5, 20.0, 95.0, 90.0)];
    }
    return _circleVerticalSquishPath;
}
- (UIBezierPath *)circleHorizontalSquishPath {
    if (!_circleHorizontalSquishPath) {
        _circleHorizontalSquishPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(5.0, 20.0, 90.0, 90.0)];
    }
    return _circleHorizontalSquishPath;
}

-(void)wobbleAnimation{
    CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"path"];
    animation1.fromValue = (__bridge id _Nullable)(self.circleBigPath.CGPath);
    animation1.toValue = (__bridge id _Nullable)(self.circleVerticalSquishPath.CGPath);
    animation1.beginTime = KAnimationBeginTime;
    animation1.duration = KAnimationDuration;
    
    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"path"];
    animation2.fromValue = (__bridge id _Nullable)(self.circleVerticalSquishPath.CGPath);
    animation2.toValue = (__bridge id _Nullable)(self.circleHorizontalSquishPath.CGPath);
    animation2.beginTime = animation1.beginTime + animation1.duration;
    animation2.duration = KAnimationDuration;
    
    CABasicAnimation *animation3 = [CABasicAnimation animationWithKeyPath:@"path"];
    animation3.fromValue = (__bridge id _Nullable)(self.circleHorizontalSquishPath.CGPath);
    animation3.toValue = (__bridge id _Nullable)(self.circleVerticalSquishPath.CGPath);
    animation3.beginTime = animation2.beginTime + animation2.duration;
    animation3.duration = KAnimationDuration;
    
    CABasicAnimation *animation4 = [CABasicAnimation animationWithKeyPath:@"path"];
    animation4.fromValue = (__bridge id _Nullable)(self.circleVerticalSquishPath.CGPath);
    animation4.toValue = (__bridge id _Nullable)(self.circleBigPath.CGPath);
    animation4.beginTime = animation3.beginTime + animation3.duration;
    animation4.duration = KAnimationDuration;
    //    5
    CAAnimationGroup *animationGroup = [[CAAnimationGroup alloc] init];
    animationGroup.animations = @[animation1, animation2, animation3, animation4];
    animationGroup.duration = 4 * KAnimationDuration;
    animationGroup.repeatCount = 2;
    [self addAnimation:animationGroup forKey:nil];
    
    
}

- (void)expand {
    CABasicAnimation *expandAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    expandAnimation.fromValue = (__bridge id _Nullable)(self.circleSmallPath.CGPath);
    expandAnimation.toValue = (__bridge id _Nullable)(self.circleBigPath.CGPath);
    expandAnimation.duration = KAnimationDuration;
    expandAnimation.fillMode = kCAFillModeForwards;
    expandAnimation.removedOnCompletion = NO;
    [self addAnimation:expandAnimation forKey:nil];
    
}

- (void)contract {
    CABasicAnimation *expandAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    expandAnimation.fromValue = (__bridge id _Nullable)(self.circleBigPath.CGPath);
    expandAnimation.toValue = (__bridge id _Nullable)(self.circleSmallPath.CGPath);
    expandAnimation.duration = KAnimationDuration;
    expandAnimation.fillMode = kCAFillModeForwards;
    expandAnimation.removedOnCompletion = NO;
    [self addAnimation:expandAnimation forKey:nil];
}



@end
