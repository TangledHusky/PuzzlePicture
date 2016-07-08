//
//  ImageScale.h
//  HudongImageDemo
//
//  Created by admin on 15/5/26.
//  Copyright (c) 2015年 admin. All rights reserved.
//  设置按钮内部图片大小

#import <UIKit/UIKit.h>

@interface UIImage(scale)
-(UIImage*)scaleToSize:(CGSize)size;

+(UIImage *)imageFromColor:(UIColor *)color withSize:(CGSize) size;
@end
