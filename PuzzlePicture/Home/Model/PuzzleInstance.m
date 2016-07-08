//
//  PuzzleInstance.m
//  PuzzlePicture
//
//  Created by 李亚军 on 16/6/15.
//  Copyright © 2016年 zyyj. All rights reserved.
//

#import "PuzzleInstance.h"

@implementation PuzzleInstance

+(PuzzleInstance *)shareInstance{
    static PuzzleInstance * instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[PuzzleInstance alloc] init];
    });
    
    return instance;    
    
}

@end
