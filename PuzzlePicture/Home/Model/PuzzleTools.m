//
//  PuzzleTools.m
//  PuzzlePicture
//
//  Created by 李亚军 on 16/6/15.
//  Copyright © 2016年 zyyj. All rights reserved.
//

#import "PuzzleTools.h"

static NSArray * puzzleGroup;

@implementation PuzzleTools


+(void)saveBackImage:(UIImage *)backImage{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    path = [path stringByAppendingPathComponent:@"backImage"];
    [UIImagePNGRepresentation(backImage) writeToFile:path atomically:YES];
    
    
}

+(UIImage*)getBackImage
{
    NSString * imagePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)firstObject];
    
    imagePath = [imagePath stringByAppendingPathComponent:@"backImage"];
    NSData * data = [NSData dataWithContentsOfFile:imagePath];
    UIImage * image = [UIImage imageWithData:data];
    if (image==nil) {
        
        image = [UIImage imageNamed:@"bgDefault"];
        [PuzzleTools saveBackImage:image];
    }
    return image;
}

+(void)CtrlPuzzleMove:(PuzzleBlockItem *)thePuzzleBlock withDragDirection:(int *)Direct{
    PuzzleItemCtrlModel * puzzleModel = thePuzzleBlock.puzzleModel;
    if (puzzleGroup.count == 0) {
        return;
    
    }
    
    
    PuzzleBlockItem *blankItem;
    PuzzleItemCtrlModel *blankCtrlModel;
    for (id obj in puzzleGroup) {
        if (![obj isKindOfClass:[PuzzleBlockItem class]]) {
            return;
        }
        
        
        PuzzleBlockItem * puzzleBlcok = (PuzzleBlockItem *)obj;
        if (puzzleBlcok.puzzleModel.objIdx==puzzleGroup.count-1) {
            blankCtrlModel = puzzleBlcok.puzzleModel;
            blankItem = puzzleBlcok;
        }
        
    }
    
    int rowNum = (int)sqrt(puzzleGroup.count);
    int curX = puzzleModel.curIdx/rowNum;
    int curY = puzzleModel.curIdx%rowNum;
    int blankX = blankCtrlModel.curIdx/rowNum;
    int blankY = blankCtrlModel.curIdx%rowNum;
    
    if ((curX==blankX && abs(curY-blankY)==1) || (curY==blankY && abs(curX-blankX)==1)) {
        if (Direct == NULL) {
            //交换空格和图片位置
            int tmpIdx = blankCtrlModel.curIdx;
            blankCtrlModel.curIdx=puzzleModel.curIdx;
            puzzleModel.curIdx=tmpIdx;
            thePuzzleBlock.puzzleModel=puzzleModel;
            blankItem.puzzleModel = blankCtrlModel;
            
            [[NSNotificationCenter defaultCenter]postNotificationName:@"hasMove" object:nil];
        }else{
            int xOff,yOff =0;
            xOff=blankCtrlModel.itemRect.origin.x - puzzleModel.itemRect.origin.x;
            yOff=blankCtrlModel.itemRect.origin.y - puzzleModel.itemRect.origin.y;
            
            if (xOff>0) {
                *Direct = PuzzleItemCtrlDirectRight;
                
            }
            else if(xOff<0){
                *Direct = PuzzleItemCtrlDirectLeft;
            }
            else if (yOff>0) {
                *Direct = PuzzleItemCtrlDirectDown;
            }
            else
            {
                *Direct = PuzzleItemCtrlDirectUp;
            }

            
        }
    }
    
    [PuzzleTools check_pass];
    
}

+(void)setPuzzleGroup:(NSMutableArray *)groupArr
{
    puzzleGroup = groupArr;
}

+(void)exchangePuzzleWithBank:(PuzzleBlockItem *)thePuzzleBlock
{
    
    PuzzleBlockItem * bankItem;
    PuzzleItemCtrlModel * bankCtrlModel;
    for (id obj in puzzleGroup) {
        PuzzleBlockItem * puzzleBlock = (PuzzleBlockItem*)obj;
        if (puzzleBlock.puzzleModel.objIdx == puzzleGroup.count -1 ) {
            bankCtrlModel = puzzleBlock.puzzleModel;
            bankItem = puzzleBlock;
        }
    }
    
    PuzzleItemCtrlModel * thePuzzleModel = thePuzzleBlock.puzzleModel;
    int tmpIdx = bankCtrlModel.curIdx;
    bankCtrlModel.curIdx = thePuzzleModel.curIdx;
    thePuzzleModel.curIdx = tmpIdx;
    thePuzzleBlock.puzzleModel = thePuzzleModel;
    bankItem.puzzleModel = bankCtrlModel;
    [[NSNotificationCenter defaultCenter]postNotificationName:@"hasMove" object:nil];
    [PuzzleTools check_pass];
    
}


+(void)check_pass
{
    
    int t=0;
    
    PuzzleBlockItem * puzzle;
    for (int i=0; i<puzzleGroup.count; i++) {
        
        PuzzleBlockItem * block = puzzleGroup[i];
        if (block.puzzleModel.curIdx==block.puzzleModel.objIdx) {
            t++;
        }
        puzzle = block;
    }
    if (t == puzzleGroup.count) {
        [puzzle showRealImage];
        UIAlertView *GamePassAlert = [[UIAlertView alloc]initWithTitle:@"通关提示" message:@"恭喜通过" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [GamePassAlert show];
        //成功后按钮不在响应用户事件
        [puzzleGroup makeObjectsPerformSelector:@selector(setUserInteractionEnabled:) withObject:@(NO)];
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"success" object:nil];
    }
}


@end
