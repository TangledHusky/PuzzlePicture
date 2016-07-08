//
//  UIButton+Extension.m
//  PuzzlePicture
//
//  Created by 李亚军 on 16/6/16.
//  Copyright © 2016年 zyyj. All rights reserved.
//

#import "UIButton+Extension.h"

@implementation UIButton (Extension)

+(UIImage *)buttonImageFromColor:(UIColor *)color withSize:(CGSize)size{
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    return  img;
}

@end
