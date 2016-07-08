//
//  PuzzleItemCtrlModel.m
//  PuzzlePicture
//
//  Created by 李亚军 on 16/6/15.
//  Copyright © 2016年 zyyj. All rights reserved.
//

#import "PuzzleItemCtrlModel.h"

@implementation PuzzleItemCtrlModel

-(void)setCurIdx:(int)curIdx{
    _curIdx = curIdx;
    //重新计算坐标
    if (self.itemRect.size.width!=0&&self.itemRect.size.height!=0&&self.maxIdx!=0) {
        int xItem = self.curIdx%((int)sqrt(self.maxIdx));
        int yItem = self.curIdx/((int)sqrt(self.maxIdx));
        self.itemRect =  CGRectMake(xItem*self.itemRect.size.width, yItem*self.itemRect.size.width, self.itemRect.size.width, self.itemRect.size.height);
        
        
    }
    
}

@end
