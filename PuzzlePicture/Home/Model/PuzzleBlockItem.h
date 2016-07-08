//
//  PuzzleBlockItem.h
//  PuzzlePicture
//
//  Created by 李亚军 on 16/6/15.
//  Copyright © 2016年 zyyj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PuzzleItemCtrlModel.h"

@interface PuzzleBlockItem : UIImageView


@property (nonatomic,strong) PuzzleItemCtrlModel  *puzzleModel;

+(instancetype)puzzleBlcokWithModel:(PuzzleItemCtrlModel *)puzzleModel;

-(void)showTipsWithTimeSec:(int)sec;


-(BOOL)isAtObjIdx;
-(void)showRealImage;



@end
