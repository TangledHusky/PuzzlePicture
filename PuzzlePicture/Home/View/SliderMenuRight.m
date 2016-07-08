//
//  SliderMenuRight.m
//  PuzzlePicture
//
//  Created by 李亚军 on 16/6/16.
//  Copyright © 2016年 zyyj. All rights reserved.
//

#import "SliderMenuRight.h"

#define KRightWidth 110

@interface SliderMenuRight()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSMutableArray  *data;

@end

@implementation SliderMenuRight{
    UITableView *tableview;
}

-(instancetype)init{
   self= [super init];
    if (self) {
        [self initView];
        
    }
    
    return  self;
}


-(instancetype)initWithFrame:(CGRect)frame{
    self=  [super initWithFrame:frame];
    if (self) {
          [self initView];
    }
    
    return  self;
}

-(void)initView{
    self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    self.backgroundColor=[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.3];
    
    
    [self addSliderMenu];
    self.isOpen = YES;

}


-(void)addSliderMenu{
    tableview = [[UITableView alloc] initWithFrame:CGRectMake(ScreenWidth-KRightWidth, 0, KRightWidth,ScreenHeight) style:UITableViewStylePlain];
    tableview.backgroundColor= ColorWith(72, 82, 94);
    tableview.delegate=self;
    tableview.dataSource=self;
    [tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellMenu"];
    
    [self addSubview:tableview];
    
    
}



-(void)initWithPuzzleData:(NSMutableArray *)data{
     self.data = data;
     [tableview reloadData];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self  closeSliderMenu];
    
}


-(void)closeSliderMenu{
    [UIView animateWithDuration:0.6 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
         [self removeFromSuperview];
    }];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"closeSliderMenu" object:nil];

}


#pragma mark - tableview代理

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellMenu"];
    cell.textLabel.text = self.data[indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.backgroundColor = ColorWith(72, 82, 94);
    if (indexPath.row == [PuzzleInstance shareInstance].puzzleType) {
        [self addSelectedColor:cell];
    }
    return  cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [PuzzleInstance shareInstance].puzzleType=(int)indexPath.row;
    [PuzzleInstance shareInstance].puzzleIndex = 0;
    
    UITableViewCell *cell = [tableview cellForRowAtIndexPath:indexPath];
    [self addSelectedColor:cell];
    [self closeSliderMenu];
    
     [[NSNotificationCenter defaultCenter] postNotificationName:@"changePuzzleType" object:nil];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 64;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

-(void)addSelectedColor:(UITableViewCell *)cell{

    cell.backgroundColor = ColorWith(254, 208, 55);
}



@end
