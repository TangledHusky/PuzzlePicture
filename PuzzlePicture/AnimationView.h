//
//  AnimationView.h
//  PuzzlePicture
//
//  Created by 李亚军 on 16/6/20.
//  Copyright © 2016年 zyyj. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AnimationViewDelegate <NSObject>
-(void)completeAnimation;

@end

@interface AnimationView : UIView

@property (nonatomic,assign) CGRect  parentFrame;
@property (nonatomic,weak) id<AnimationViewDelegate> delegate;

@end
