//
//  LeftSliderView.m
//  LeAi
//
//  Created by MACBOOK on 16/1/30.
//  Copyright © 2016年 yajun.li. All rights reserved.
//  侧边栏，里面包含菜单项

#import "LeftSliderView.h"
#import "PuzzleInstance.h"


#define menuHeight 50           //菜单高度
#define menuMarginTop 100       //第一个距离顶部距离



@interface LeftSliderView()


@end

@implementation LeftSliderView{
    UIImageView *bgImage;
    UIButton *lastBtnSelected;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        
        [self setupMenu];
        
        
    }
    
    return self;
}


-(void)setupMenu{
    //背景图
    bgImage=[[UIImageView alloc] initWithFrame:self.bounds];
    bgImage.backgroundColor = [PublicMethod colorWithHexString:@"272636"];
    [self addSubview:bgImage];
    
    CGFloat menuX=0;
    
    //练习模式
    UIButton *btnPractice=[[UIButton alloc] init];
    btnPractice.contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter;
    [btnPractice setTitle:@"练习模式" forState:UIControlStateNormal];
    [btnPractice setBackgroundImage:[UIButton buttonImageFromColor:[UIColor redColor] withSize:CGSizeMake(kLeftViewSlideDepth, 50)] forState:UIControlStateSelected];
    btnPractice.tag=10;
    btnPractice.frame=CGRectMake(menuX, menuMarginTop, kLeftViewSlideDepth, menuHeight);
    [self addSubview:btnPractice];
    btnPractice.selected = YES;
    lastBtnSelected=btnPractice;
    [btnPractice addTarget:self action:@selector(clickToPage:) forControlEvents:UIControlEventTouchUpInside];

    
    //简易模式
    UIButton *btnHistory=[[UIButton alloc] init];
    btnHistory.contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter;
    [btnHistory setTitle:@"简易模式" forState:UIControlStateNormal];
    [btnHistory setBackgroundImage:[UIButton buttonImageFromColor:[UIColor redColor] withSize:CGSizeMake(kLeftViewSlideDepth, 50)] forState:UIControlStateSelected];
    btnHistory.tag=20;
    btnHistory.frame=CGRectMake(menuX, CGRectGetMaxY(btnPractice.frame), kLeftViewSlideDepth, menuHeight);
    [self addSubview:btnHistory];
    [btnHistory addTarget:self action:@selector(clickToPage:) forControlEvents:UIControlEventTouchUpInside];
 
    //困难模式
    UIButton *btnHorner=[[UIButton alloc] init];
    btnHorner.contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter;
    [btnHorner setTitle:@"困难模式" forState:UIControlStateNormal];
    btnHorner.tag=30;
    [btnHorner setBackgroundImage:[UIButton buttonImageFromColor:[UIColor redColor] withSize:CGSizeMake(kLeftViewSlideDepth, 50)] forState:UIControlStateSelected];

    btnHorner.frame=CGRectMake(menuX, CGRectGetMaxY(btnHistory.frame), kLeftViewSlideDepth, menuHeight);
    [self addSubview:btnHorner];
    [btnHorner addTarget:self action:@selector(clickToPage:) forControlEvents:UIControlEventTouchUpInside];
   
    //暴走模式
    UIButton *btnSetting=[[UIButton alloc] init];
    btnSetting.contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter;
    [btnSetting setTitle:@"暴走模式" forState:UIControlStateNormal];
    btnSetting.tag=40;
    [btnSetting setBackgroundImage:[UIButton buttonImageFromColor:[UIColor redColor] withSize:CGSizeMake(kLeftViewSlideDepth, 50)] forState:UIControlStateSelected];

    btnSetting.frame=CGRectMake(menuX, CGRectGetMaxY(btnHorner.frame), kLeftViewSlideDepth, menuHeight);
    [self addSubview:btnSetting];
    [btnSetting addTarget:self action:@selector(clickToPage:) forControlEvents:UIControlEventTouchUpInside];
  

    
    //设置
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight-50, kLeftViewSlideDepth+10, 1)];
    line.backgroundColor = ColorWith(242, 242, 242);
    [self addSubview: line];
    
    UIImage *img = [UIImage imageNamed:@"设置"];
    UIButton *btnLogout=[[UIButton alloc] init];
    [btnLogout setTitle:@"设置" forState:UIControlStateNormal];
    [btnLogout setImage:[img scaleToSize:CGSizeMake(20,20)] forState:UIControlStateNormal];
    [btnLogout setImageEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
    btnLogout.contentMode =  UIViewContentModeScaleAspectFit;
    btnLogout.frame=CGRectMake(0, ScreenHeight-50, kLeftViewSlideDepth, menuHeight);
    [self addSubview:btnLogout];
    [btnLogout addTarget:self action:@selector(clickToSetting) forControlEvents:UIControlEventTouchUpInside];
    
    //排行榜
    UIView *lineRank = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight-100, kLeftViewSlideDepth+10, 1)];
    lineRank.backgroundColor = ColorWith(242, 242, 242);
    [self addSubview: lineRank];
    
    UIImage *imgRank = [UIImage imageNamed:@"排行"];
    UIButton *btnRank=[[UIButton alloc] init];
    [btnRank setTitle:@"排名" forState:UIControlStateNormal];
    [btnRank setImage:[imgRank scaleToSize:CGSizeMake(20,20)] forState:UIControlStateNormal];
    [btnRank setImageEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
    btnRank.contentMode =  UIViewContentModeScaleAspectFit;
    btnRank.frame=CGRectMake(0, ScreenHeight-100, kLeftViewSlideDepth, menuHeight);
    [self addSubview:btnRank];
    [btnRank addTarget:self action:@selector(clickToRanking) forControlEvents:UIControlEventTouchUpInside];
    
    //分享
    UIView *lineShare = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight-150, kLeftViewSlideDepth+10, 1)];
    lineShare.backgroundColor = ColorWith(242, 242, 242);
    [self addSubview: lineShare];
    
    UIImage *imgShare = [UIImage imageNamed:@"分享"];
    UIButton *btnShare=[[UIButton alloc] init];
    [btnShare setTitle:@"分享" forState:UIControlStateNormal];
    [btnShare setImage:[imgShare scaleToSize:CGSizeMake(20,20)] forState:UIControlStateNormal];
    [btnShare setImageEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
    btnShare.contentMode =  UIViewContentModeScaleAspectFit;
    btnShare.frame=CGRectMake(0, ScreenHeight-150, kLeftViewSlideDepth, menuHeight);
    [self addSubview:btnShare];
    [btnShare addTarget:self action:@selector(clickToSharing) forControlEvents:UIControlEventTouchUpInside];

}



-(void)clickToPage:(UIButton *)btn{
    switch (btn.tag) {
        case 10:
            [PuzzleInstance shareInstance].puzzleNum = 4;
            break;
        case 20:
            [PuzzleInstance shareInstance].puzzleNum = 9;
            break;
        case 30:
            [PuzzleInstance shareInstance].puzzleNum = 16;
            break;
        case 40:
            [PuzzleInstance shareInstance].puzzleNum = 25;
            break;
            
        default:
            break;
    }
    //清空选中
    lastBtnSelected.selected = NO;
    
    btn.selected=YES;
    lastBtnSelected=btn;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeNum" object:nil];
    
}

-(void)clickToSetting{
    NSLog(@"设置");
}

-(void)clickToRanking{
    NSLog(@"排行");
}

-(void)clickToSharing{
    NSLog(@"分享");
}


@end
