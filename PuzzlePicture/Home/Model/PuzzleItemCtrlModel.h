//
//  PuzzleItemCtrlModel.h
//  PuzzlePicture
//
//  Created by 李亚军 on 16/6/15.
//  Copyright © 2016年 zyyj. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 控制移动方向
 */
typedef enum
{
    PuzzleItemCtrlDirectNone=0,//不移动
    PuzzleItemCtrlDirectLeft=1,
    PuzzleItemCtrlDirectRight=2,
    PuzzleItemCtrlDirectUp=3,
    PuzzleItemCtrlDirectDown=4,
    
}PuzzleItemCtrlDirect;

@interface PuzzleItemCtrlModel : NSObject


@property (nonatomic,assign)PuzzleItemCtrlDirect direct;
/**
 *  大小
 */
@property (nonatomic,assign) CGRect itemRect;
/**
 *  目标位置
 */
@property (nonatomic,assign) int objIdx;
/**
 *  当前位置
 */
@property (nonatomic,assign) int curIdx;
/**
 *  最大的位置，用来计算坐标的x,y值
 */
@property (nonatomic,assign) int maxIdx;

@end
