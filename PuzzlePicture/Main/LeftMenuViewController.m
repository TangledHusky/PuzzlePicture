//
//  LeftSliderViewController.m
//  LeAi
//
//  Created by MACBOOK on 16/1/29.
//  Copyright © 2016年 yajun.li. All rights reserved.
//

#import "LeftMenuViewController.h"

#import "LeftSliderView.h"
#import "AppDelegate.h"




@interface LeftMenuViewController ()

@end

@implementation LeftMenuViewController
#pragma mark ----------------懒加载--------------------


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加菜单项
    LeftSliderView *left=[[LeftSliderView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:left];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    

}


/**
 *  隐藏状态栏
 *
 *  @return <#return value description#>
 */
-(BOOL)prefersStatusBarHidden{
    return YES;
    
}


@end
