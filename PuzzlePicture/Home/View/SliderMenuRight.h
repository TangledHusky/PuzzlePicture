//
//  SliderMenuRight.h
//  PuzzlePicture
//
//  Created by 李亚军 on 16/6/16.
//  Copyright © 2016年 zyyj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SliderMenuRight : UIView


@property (nonatomic,assign) BOOL  isOpen;

-(void)initWithPuzzleData:(NSMutableArray *)data;

-(void)closeSliderMenu;

@end
