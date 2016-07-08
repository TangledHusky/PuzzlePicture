//
//  PuzzleTools.h
//  PuzzlePicture
//
//  Created by 李亚军 on 16/6/15.
//  Copyright © 2016年 zyyj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PuzzleBlockItem.h"
#import "PuzzleItemCtrlModel.h"

@interface PuzzleTools : NSObject
+(void)saveBackImage:(UIImage *) backImage;
+(UIImage*)getBackImage;
+(void)CtrlPuzzleMove:(PuzzleBlockItem*)thePuzzleBlock withDragDirection:(int*)Direct;
/**
 *  拼图的所有的数组
 */
+(void)setPuzzleGroup:(NSMutableArray *) groupArr;
+(void)exchangePuzzleWithBank:(PuzzleBlockItem *)thePuzzleBlock;


@end
