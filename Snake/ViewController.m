//
//  ViewController.m
//  Snake
//
//  Created by MENGCHEN on 2017/1/5.
//  Copyright © 2017年 MENGCHEN. All rights reserved.
//

#import "ViewController.h"
#import "SnakeGameHandler.h"

#import <ReplayKit/ReplayKit.h>

@interface ViewController ()<SnakeGameDelegate,RPBroadcastActivityViewControllerDelegate>
/** 重置按钮 */
@property (weak, nonatomic) IBOutlet UIButton *resetBtn;
/** 当前点 */
@property(nonatomic, assign)CGPoint  currentPoint;
/** 贪吃蛇身体  */
@property(nonatomic, weak)CAShapeLayer * layer;
/** 身体点 */
@property(nonatomic, strong)NSMutableArray * pointsArr;
/** 食物 */
@property(nonatomic, weak)CAShapeLayer * foodLayer;
/** 地图 */
@property(nonatomic, assign)UIView * backView;
/** 录屏广播视图 */
@property(nonatomic, strong)RPBroadcastController * broadcastViewController;
/** 相机视图 */
@property(nonatomic, strong)UIView * cameraPreviewView;
/** 上按钮 */
@property (weak, nonatomic) IBOutlet UIButton *topBtn;
/** 左按钮 */
@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
/** 右按钮 */
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
/** 下按钮 */
@property (weak, nonatomic) IBOutlet UIButton *bottomBtn;
/** 加速按钮 */
@property (weak, nonatomic) IBOutlet UIButton *addSpeed;
/** 减速按钮 */
@property (weak, nonatomic) IBOutlet UIButton *lowSpeed;


@end

@implementation ViewController

#pragma mark ------------------ LifeCycle ------------------

#pragma mark viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    SnakeManager.delegate = self;
    [SnakeManager startGame];
    self.view.backgroundColor = [UIColor redColor];
    //背景视图
    self.backView.hidden = false;
    //食物
    CAShapeLayer * layer = [CAShapeLayer layer];
    self.layer.frame = CGRectMake(0, 0, SnakeWidth, SnakeWidth);
    self.layer.backgroundColor = [UIColor blackColor].CGColor;
    self.layer = layer;
    [self.backView.layer addSublayer:self.layer];
    //重置按钮
    [self.resetBtn setTitle:@"重新开始" forState:UIControlStateNormal];
    self.resetBtn.backgroundColor = [UIColor colorWithRed:100/255.0 green:220/255.0 blue:100/255.0 alpha:0.2];
    //初始化按钮
    [self.topBtn setTitle:@"上" forState:UIControlStateNormal];
    [self.leftBtn setTitle:@"左" forState:UIControlStateNormal];
    [self.rightBtn setTitle:@"右" forState:UIControlStateNormal];
    [self.bottomBtn setTitle:@"下" forState:UIControlStateNormal];
    [self.addSpeed setBackgroundColor:[UIColor clearColor]];
    [self.addSpeed setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.lowSpeed setBackgroundColor:[UIColor clearColor]];
    [self.lowSpeed setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

#pragma mark ------------------ LazyLoad ------------------
#pragma mark create 创建食物层
-(CAShapeLayer *)foodLayer{
    if (!_foodLayer) {
        CAShapeLayer * la = [CAShapeLayer layer];
        _foodLayer = la;
        [self.backView.layer addSublayer:_foodLayer];
    }
    return _foodLayer;
    
}

#pragma mark create 创建背景层
-(UIView *)backView{
    if (!_backView) {
        int kSnakeWidthRange = (int)(KeyWidth/100)*100;
        int kSnakeHeightRange = (int)(KeyHeight/100)*100;
        UIView * vi = [[UIView alloc]initWithFrame:CGRectMake((KeyWidth - kSnakeWidthRange)*0.5, (KeyHeight - kSnakeHeightRange)*0.5, kSnakeWidthRange, kSnakeHeightRange)];
        _backView = vi;
        _backView.center = CGPointMake(KeyWidth*0.5, KeyHeight*0.5);
        _backView.backgroundColor = [UIColor whiteColor];
        [self.view insertSubview:_backView atIndex:0];
        _backView = vi;
    }
    return _backView;
}
#pragma mark create 创建点数组
- (NSMutableArray *)pointsArr{
    if (!_pointsArr) {
        NSMutableArray * arr = [NSMutableArray arrayWithCapacity:0];
        _pointsArr = arr;
    }
    return _pointsArr;
}

#pragma mark ------------------ Action ------------------
#pragma mark action 录制点击
- (IBAction)replayLiveClick:(id)sender {
    //调用支持
    [RPBroadcastActivityViewController loadBroadcastActivityViewControllerWithHandler:^(RPBroadcastActivityViewController * _Nullable broadcastActivityViewController, NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"%@",error);
            return;
        }
        broadcastActivityViewController.delegate = self;
        [self presentViewController:broadcastActivityViewController animated:true completion:^{
        }];
    }];
}


#pragma mark action 暂停直播
- (IBAction)pauseClick:(id)sender {
    [self.broadcastViewController pauseBroadcast];
    NSLog(@"pause");
}
#pragma mark action 继续直播
- (IBAction)resumeClick:(id)sender {
    [self.broadcastViewController resumeBroadcast];
    NSLog(@"resume");
}


#pragma mark action 完成直播
- (IBAction)finishClick:(id)sender {
    [self.broadcastViewController finishBroadcastWithHandler:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@",error);
        }
        NSLog(@"finish");
    }];
}



#pragma mark action 加速
- (IBAction)addSpeed:(id)sender {
    [SnakeManager addSpeed];
    
}
#pragma mark action 减速
- (IBAction)lowSpeed:(id)sender {
    [SnakeManager minusSpeed];
}
#pragma mark action 上按钮点击
- (IBAction)topClick:(id)sender {
    NSLog(@"上按钮点击");
    if (SnakeManager.currentType == DirectionTypeBottom) {
        return;
    }
    [SnakeManager setDirection:DirectionTypeTop];
}

#pragma mark action 左按钮点击
- (IBAction)leftClick:(id)sender {
    NSLog(@"左按钮点击");
    if (SnakeManager.currentType == DirectionTypeRight) {
        return;
    }
    [SnakeManager setDirection:DirectionTypeLeft];
    
}

#pragma mark action 右按钮点击
- (IBAction)rightClick:(id)sender {
    NSLog(@"右按钮点击");
    if (SnakeManager.currentType == DirectionTypeLeft) {
        return;
    }
    [SnakeManager setDirection:DirectionTypeRight];
    
}

#pragma mark action 下按钮点击
- (IBAction)bottomClick:(id)sender {
    if (SnakeManager.currentType == DirectionTypeTop) {
        return;
    }
    NSLog(@"下按钮点击");
    [SnakeManager setDirection:DirectionTypeBottom];
}
#pragma mark action 重置按钮点击
- (IBAction)resetBtnClick:(id)sender {
    NSLog(@"重置按钮点击");
    [SnakeManager restart];
    self.resetBtn.hidden = true;
}

#pragma mark ------------------ broad代理方法 ------------------
-(void)broadcastActivityViewController:(RPBroadcastActivityViewController *)broadcastActivityViewController didFinishWithBroadcastController:(RPBroadcastController *)broadcastController error:(NSError *)error{
    NSLog(@"%s",__func__);
    if (error) {
        NSLog(@"%@",error);
    }
    [self dismissViewControllerAnimated:true completion:nil];
    
    [RPScreenRecorder sharedRecorder].cameraEnabled = true;
    [RPScreenRecorder sharedRecorder].microphoneEnabled = true;
    self.broadcastViewController = broadcastController;
    [broadcastController startBroadcastWithHandler:^(NSError * _Nullable error) {
        NSLog(@"开始录");
        if (error) {
            NSLog(@"%@",error);
        }
        [[RPScreenRecorder sharedRecorder].cameraPreviewView setFrame:CGRectMake(0, KeyHeight - 100, 100, 100)];
        [self.view addSubview:[RPScreenRecorder sharedRecorder].cameraPreviewView];
    }];
}

#pragma mark ------------------ 蛇代理方法 ------------------
//走路回调
-(void)walkCallBack:(CGPoint)currentPoint pointsArr:(NSArray *)points{
    self.currentPoint = currentPoint;
    self.pointsArr = [points mutableCopy];
    UIBezierPath * path = [UIBezierPath bezierPath];
    for (int i = 0; i<points.count; i++) {
        CGPoint point = [points[i] CGPointValue];
        UIBezierPath * p = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(point.x, point.y, SnakeWidth, SnakeWidth) cornerRadius:SnakeWidth*0.5];
        [path appendPath:p];
    }
    self.layer.path = path.CGPath;
    self.layer.fillColor = [UIColor yellowColor].CGColor;
    self.layer.strokeEnd = 1;
}
//吃回调
-(void)eatCallBack{
    NSLog(@"吃回调");
}
//死回调
-(void)deadCallBack{
    self.resetBtn.hidden = false;
}
//食物创建回调
-(void)foodCallBack:(CGPoint)point{
    UIBezierPath * path = [UIBezierPath bezierPathWithRect:CGRectMake(point.x, point.y, SnakeWidth, SnakeWidth)];
    self.foodLayer.path = path.CGPath;
    self.foodLayer.fillColor = [UIColor blackColor].CGColor;
    self.foodLayer.strokeEnd = 1;
}



@end
