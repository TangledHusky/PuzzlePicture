//
//  PuzzleInstance.h
//  PuzzlePicture
//
//  Created by 李亚军 on 16/6/15.
//  Copyright © 2016年 zyyj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PuzzleInstance : NSObject

+(PuzzleInstance *)shareInstance;

//九宫格 数目，现在分为9、16、25  三种
@property (nonatomic,assign) int  puzzleNum;

//图片系列， 从0开始
//顺序不能乱
/*  0:dog(狗狗)
    1:cat(喵咪)
 
 */
@property (nonatomic,assign) int  puzzleType;

//图片在系列中的第几个
@property (nonatomic,assign) int  puzzleIndex;

@end
