//
//  HomeViewController.m
//  PuzzlePicture
//
//  Created by 李亚军 on 16/6/13.
//  Copyright © 2016年 zyyj. All rights reserved.
//

#import "HomeViewController.h"
#import "AppDelegate.h"
#import "PuzzleBlockItem.h"
#import "MJExtension.h"
#import "PuzzleTools.h"
#import "SliderMenuRight.h"

@interface HomeViewController () <UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *bgImage;

@property (weak, nonatomic) IBOutlet UIImageView *originalImage;
@property (weak, nonatomic) IBOutlet UILabel *lblTime;
@property (weak, nonatomic) IBOutlet UILabel *lblStep;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bgImageH;

@property (strong, nonatomic) IBOutlet UIView *lblLine;

@property (weak, nonatomic) IBOutlet UIButton *btnPre;
@property (weak, nonatomic) IBOutlet UIButton *btnNext;
@property (weak, nonatomic) IBOutlet UILabel *lblIndex;

@property (nonatomic,strong) NSTimer  *timer;
@property (nonatomic,assign) int step;
@property (nonatomic,assign) int gradeTime;
//保存拼图块的编号
@property (strong,nonatomic)NSMutableArray *PuzzleItemArr;
//拼图系列数组
@property (nonatomic,strong) NSMutableArray  *PuzzleTypeArr;

@end

@implementation HomeViewController{
    SliderMenuRight *slider;
}

#pragma mark - 懒加载
-(NSMutableArray *)PuzzleItemArr{
    if(_PuzzleItemArr==nil){
        _PuzzleItemArr=[NSMutableArray array];
    }
    return  _PuzzleItemArr;
}

-(NSMutableArray *)PuzzleTypeArr{
    if(_PuzzleTypeArr==nil){
        _PuzzleTypeArr=[NSMutableArray arrayWithObjects:@"汪星人",@"喵星人",@"美女", nil];
    }
    return  _PuzzleTypeArr;
}


#pragma mark - 系统初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    //view初始化
    self.view.backgroundColor = [PublicMethod colorWithHexString:@"ecf0f1"];
    
    //单例初始化
    [self initInstanceContent];
   
    //首次加载，初始化图片
    [self showSplitPic:[self getImageByInstance]];
    
    //设置导航
    [self setupNav];
    
    //更改难度通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeNum) name:@"changeNum" object:nil];
    //步数改变通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updateStep) name:@"hasMove" object:nil];
    //关闭右侧侧边栏
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closeSliderMenu) name:@"closeSliderMenu" object:nil];
    //更改图片系列
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changePuzzleType) name:@"changePuzzleType" object:nil];
    
    
    //预览图圆角
    self.originalImage.layer.cornerRadius = 8;
    self.originalImage.clipsToBounds = YES;
    
}

-(UIImage *)getImageByInstance{
    UIImage *currentImg = [UIImage imageNamed:[NSString stringWithFormat:@"%@%d",[self getImagePrifix],[PuzzleInstance shareInstance].puzzleIndex]];
    return currentImg;
}

-(void)initInstanceContent{
    if ([PuzzleInstance shareInstance].puzzleNum == 0 || ![PuzzleInstance shareInstance].puzzleNum) {
        [PuzzleInstance shareInstance].puzzleNum = 4;
    }
    
    [PuzzleInstance shareInstance].puzzleType = 0;
    [PuzzleInstance shareInstance].puzzleIndex = 0;
    _btnPre.enabled=NO;
    
}

-(void)setupNav{
    self.title = self.PuzzleTypeArr[[PuzzleInstance shareInstance].puzzleType];
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor, nil];
    
    UIButton *btnLeft = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 22, 25)];
    [btnLeft setBackgroundImage:[UIImage imageNamed:@"菜单"] forState:UIControlStateNormal];
    [btnLeft addTarget:self action:@selector(openMenu) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnLeft];
    
    UIButton *btnRight = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    [btnRight setBackgroundImage:[UIImage imageNamed:@"主题"] forState:UIControlStateNormal];
    [btnRight addTarget:self action:@selector(changePicType) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnRight];

    self.navigationController.navigationBar.barTintColor = ColorWith(223, 34, 74);
}

-(NSString *)getImagePrifix{
    int index = [PuzzleInstance shareInstance].puzzleType;
    if (!index) {
        index = 0;
    }
    NSString *titleName = @"";
    
    switch (index) {
        case 0:
            titleName= @"dog";
            break;
        case 1:
            titleName= @"cat";
            break;

        case 2:
            titleName= @"girl";
            break;

        case 3:
            titleName= @"汪星人";
            break;

        case 4:
            titleName= @"汪星人";
            break;

        case 5:
            titleName= @"汪星人";
            break;

        case 6:
            titleName= @"汪星人";
            break;

            
        default:
            break;
    }
    
    return titleName;
    
}




- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [tempAppDelegate.LeftSlideVC setPanEnabled:YES];

}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - 导航栏按钮事件
-(void)openMenu{
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (tempAppDelegate.LeftSlideVC.closed)
    {
        [tempAppDelegate.LeftSlideVC openLeftView];
    }
    else
    {
        [tempAppDelegate.LeftSlideVC closeLeftView];
    }
}


-(void)changePicType{
    if (slider) {
        [slider closeSliderMenu];
        slider = nil;
        return;
    }
    
    slider= [[SliderMenuRight alloc] init];
    [slider initWithPuzzleData:self.PuzzleTypeArr];
    [self.view addSubview:slider];
    
    
}

-(void)closeSliderMenu{
     slider = nil;
}


- (IBAction)btnTip:(id)sender {
    [self.PuzzleItemArr makeObjectsPerformSelector:@selector(showTipsWithTimeSec:)];
}

- (IBAction)btnReStart:(id)sender {
    [UIView animateWithDuration:1.0 animations:^{
        _lblTime.text = [NSString stringWithFormat:@"时间：0"];
        _lblStep.text = [NSString stringWithFormat:@"步数：0"];
        self.originalImage.transform = CGAffineTransformMakeScale(1.1, 1.1);
        
    } completion:^(BOOL finished) {
        _lblTime.transform=CGAffineTransformIdentity;
        _lblStep.transform=CGAffineTransformIdentity;
        self.originalImage.transform = CGAffineTransformIdentity;

    }];
   
    
    //关闭定时器
    [self.timer invalidate];
    self.timer=nil;
    self.gradeTime=0;
    
    
    //重新分割图片
    [self splitPicture];
    
}


- (IBAction)btnStop:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];
    
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *img = nil;
    if (picker.sourceType == UIImagePickerControllerSourceTypePhotoLibrary) {
        NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
        if ([type isEqualToString:@"public.image"]) {
            img = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        }
    }else if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        img = [info objectForKey:@"UIImagePickerControllerEditedImage"];

    }
    
    [self showSplitPic:img];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    
}

-(void)showSplitPic:(UIImage *)img{
     _lblIndex.text = [NSString stringWithFormat:@"%d/10",[PuzzleInstance shareInstance].puzzleIndex+1];
    
    if (!img) {
        img = [PuzzleTools getBackImage];
        self.bgImage.image=img;
        
       
    }
    
    img = [self LoadImage:img];
    
    _originalImage.image = img;
    self.bgImage.image=img;
    [PuzzleTools saveBackImage:img];
    
    [self setupBgImageSize];
    
    //切割图片
    [self splitPicture];
    
}

-(void)setupBgImageSize{
    CGFloat imgW = ScreenWidth-40;
    CGFloat imgMaxH=self.lblLine.origin.y - 80;
    if (imgMaxH>=imgW) {
        self.bgImageH.constant = imgW;
    }else{
        self.bgImageH.constant = imgMaxH;
    }

}

-(void)initSetup{
    self.step = 0;
    if (self.timer == nil) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTimeAndStep) userInfo:nil repeats:YES];
    }
    
    //清除之前视图，不然内存一直增加
    for (PuzzleBlockItem * blockItem in self.PuzzleItemArr) {
        [blockItem removeFromSuperview];
    }
    [self.PuzzleItemArr removeAllObjects];
    self.bgImage.image=[PuzzleTools getBackImage];
    
}


-(void)updateTimeAndStep{
    
    self.gradeTime++;
    _lblTime.text = [NSString stringWithFormat:@"时间：%d",self.gradeTime];
}

-(void)updateStep
{
    _step++;
    _lblStep.text = [NSString stringWithFormat:@"步数：%d",self.step];

}

-(void)changeNum{
    //关闭侧边栏
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (!tempAppDelegate.LeftSlideVC.closed)
    {
        [tempAppDelegate.LeftSlideVC closeLeftView];
    }
   
    
    //关闭定时器
    [self.timer invalidate];
    self.timer=nil;
    self.gradeTime=0;
   
    
    //重新分割图片
    [self splitPicture];
}

-(void)changePuzzleType{
    self.title = self.PuzzleTypeArr[[PuzzleInstance shareInstance].puzzleType];
    
    //重新加载系列图片
    [self showSplitPic:[self getImageByInstance]];
    
}

-(void)splitPicture{
    
    
    [self initSetup];
    
    int num = [[PuzzleInstance shareInstance] puzzleNum];
    
    if (num<1) {
        return;
    }
    
    for (int i = 0; i<num; i++) {
        CGRect itemRect = [self FrameForIndex:i num:num];
        NSDictionary *dict = @{@"itemRect":[NSValue valueWithCGRect:itemRect],
                               @"maxIdx":@(num),
                               @"objIdx":@(i),
                               @"curIdx":@(i),
                               
                               };
        
        PuzzleItemCtrlModel *puzzleModel = [PuzzleItemCtrlModel mj_objectWithKeyValues:dict];
        PuzzleBlockItem *puzzleItem=[PuzzleBlockItem puzzleBlcokWithModel:puzzleModel];
        [self.bgImage addSubview:puzzleItem];
        [self.PuzzleItemArr addObject:puzzleItem];
       
        
    }
    [PuzzleTools setPuzzleGroup:self.PuzzleItemArr];
    [self ChoticBlocks];
    
    
}

/**
 *  计算每个小图片的位置的位置
 */
-(void)ChoticBlocks{
    self.bgImage.image = nil;
    
    NSMutableArray *randArr=[self randNum:[PuzzleInstance shareInstance].puzzleNum-1];
    [randArr addObject:[NSString stringWithFormat:@"%d",[PuzzleInstance shareInstance].puzzleNum-1]];
    for (int i=0; i<self.PuzzleItemArr.count; i++) {
        PuzzleBlockItem *puzzleItem=self.PuzzleItemArr[i];
        PuzzleItemCtrlModel *ctrlModel=puzzleItem.puzzleModel;
        ctrlModel.curIdx=[randArr[i] intValue];
        puzzleItem.puzzleModel=ctrlModel;
    }
    
    
    
}


-(CGRect)FrameForIndex:(int) i num:(int) num{
    CGFloat x,y,height,width;
    int rowNum = (int)sqrt(num);
    CGFloat WH = ScreenWidth-40;
    x = i % rowNum * WH/sqrt(num);
    y = i/rowNum *WH/sqrt(num);
    width =WH/sqrt(num);
    height = WH/sqrt(num);
    return  CGRectMake(x, y, width, height);

    
    
    
}

//2 把一个图片按照尺寸进行放大或缩小,这个例子是按照40*40
-(UIImage *)LoadImage:(UIImage *)aImage{
    CGFloat wh = ScreenWidth-40;
    CGRect rect=CGRectMake(0, 0, wh, wh);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    CGContextClipToRect(currentContext, rect);
    [aImage drawInRect:rect];
    UIImage *cropped=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return  cropped;
    
}

/**
 *生成0到sum-1的随机数
 */
-(NSMutableArray *)randNum:(int )sum
{
    NSMutableArray *arr=[NSMutableArray array];
    srand((unsigned)time(NULL));
    int n;
    while ([arr count]!=sum)
    {
        int i=0;
        n=rand()%sum;
        for (i=0; i<[arr count]; i++)
        {
            if (n==[[arr objectAtIndex:i]intValue]) {
                break;
            }
        }
        if ([arr count]==i)
        {
            [arr addObject:[NSString stringWithFormat:@"%d",n]];
        }
    }
    //逆序数必须是偶数才可以拼出来
    int count = 0;
    for (int i = 1; i < arr.count; i++)
    {
        for (int j = 0; j < i; j++)
        {
            if ([arr[j]integerValue] > [arr[i]integerValue])
            {
                count++;
            }
        }
    }
//    //交换两个数的顺序逆序数奇偶性改变
//    if (count%2!=0) {
//        
//        NSInteger idx1=[arr indexOfObject:@"6"];
//        NSInteger idx2=[arr indexOfObject:@"7"];
//        [arr replaceObjectAtIndex:idx1 withObject:@"7"];
//        [arr replaceObjectAtIndex:idx2 withObject:@"6"];
//    }
    return  arr;
}

#pragma mark - 切换前后关卡

- (IBAction)btnPreClick:(id)sender {
    if ([PuzzleInstance shareInstance].puzzleIndex>0){
        [PuzzleInstance shareInstance].puzzleIndex--;
        _btnPre.enabled = YES;
    }
    
    if ([PuzzleInstance shareInstance].puzzleIndex==0) {
        _btnPre.enabled = NO;
    }
    _btnNext.enabled = YES;
    
    [self showSplitPic:[self getImageByInstance]];
   
    
    [self btnReStart:nil];
}

- (IBAction)btnNextClick:(id)sender {
    if ([PuzzleInstance shareInstance].puzzleIndex<9) {
        [PuzzleInstance shareInstance].puzzleIndex++;
         _btnNext.enabled = YES;
    }
    
    
    if ([PuzzleInstance shareInstance].puzzleIndex==9) {
        _btnNext.enabled = NO;
    }
    _btnPre.enabled = YES;
    [self showSplitPic:[self getImageByInstance]];
   
    [self btnReStart:nil];
}

- (IBAction)btnReviewClick:(id)sender {
    
}

@end
