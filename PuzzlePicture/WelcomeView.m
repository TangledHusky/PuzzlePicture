//
//  WelcomeView.m
//  PuzzlePicture
//
//  Created by 李亚军 on 16/6/20.
//  Copyright © 2016年 zyyj. All rights reserved.
//

#import "WelcomeView.h"
#import "AnimationView.h"
#import "AppDelegate.h"

@interface WelcomeView()<AnimationViewDelegate>
@property (strong, nonatomic) AnimationView *animationView;
@end


@implementation WelcomeView

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self _initAnimationView];
}

- (void)_initAnimationView {
    CGFloat size = 100.0;
    self.animationView = [[AnimationView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame)/2 - size/2, CGRectGetHeight(self.view.frame)/2 - size/2, size, size)];
    _animationView.delegate = self;
    _animationView.parentFrame = self.view.frame;
    [self.view addSubview:_animationView];
}


- (void)completeAnimation {
    [_animationView removeFromSuperview];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#40e0b0"];
    
    // 2
    UILabel *label = [[UILabel alloc] initWithFrame:self.view.frame];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:50.0];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"Welcome";
    label.transform = CGAffineTransformScale(label.transform, 0.25, 0.25);
    [self.view addSubview:label];
    
    [UIView animateWithDuration:0.4 delay:0.0 usingSpringWithDamping:0.7 initialSpringVelocity:0.1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        label.transform = CGAffineTransformScale(label.transform, 4.0, 4.0);
        
    } completion:^(BOOL finished) {
        [self addTouchButton];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self btnClick];
        });
    }];
}

- (void)addTouchButton {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0.0, 0.0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)btnClick {
    self.view.backgroundColor = [UIColor whiteColor];
    for (UIView *view in self.view.subviews) {
        [view removeFromSuperview];
    }
    self.animationView = nil;
    //[self _initAnimationView];
    

    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self presentViewController:tempAppDelegate.LeftSlideVC animated:YES completion:nil];
}

@end
