//
//  SnakeGameHandler.m
//  Snake
//
//  Created by MENGCHEN on 2017/1/5.
//  Copyright © 2017年 MENGCHEN. All rights reserved.
//

#import "SnakeGameHandler.h"
#import "Snake.h"
#import "SnakeFactory.h"
#import "Map.h"
#import "Food.h"
#import "Food+Position.h"
#import "FoodFactory.h"



@interface SnakeGameHandler()
/** 蛇*/
@property(nonatomic, strong)Snake * snake;
/** 定时器*/
@property(nonatomic, strong)NSTimer * timer;
/** 地图*/
@property(nonatomic, strong)Map * map;
/** 当前食物 */
@property(nonatomic, strong)Food * food;
@end


@implementation SnakeGameHandler

#pragma 单例初始化
+(instancetype)sharedHandle{
    return [[self alloc]init];
}

+(instancetype)allocWithZone:(struct _NSZone *)zone{
    static SnakeGameHandler * handle = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        handle = [super allocWithZone:zone];
    });
    return handle;
}


-(void)startGame{
    //创建随机蛇
    self.snake = [SnakeFactory createRandomInstance];
    //蛇吃东西的回调，设置地图点，重新创建食物
    __weak typeof(self) weakSelf = self;
    self.snake.eatBack = ^(CGPoint foodPosition){
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf.map.mapDict setValue:@1 forKey:NSStringFromCGPoint(foodPosition)];
        strongSelf.food = [FoodFactory createInstanceWithUseArray:[strongSelf.map.mapDict copy] completion:^(CGPoint point) {
            if (strongSelf.delegate&&[strongSelf.delegate respondsToSelector:@selector(foodCallBack:)]) {
                [strongSelf.delegate foodCallBack:point];
            }
        }];
        if (strongSelf.delegate&&[strongSelf respondsToSelector:@selector(eatCallBack)]) {
            [strongSelf.delegate performSelector:@selector(eatCallBack) withObject:nil];
        }
    };
    //死亡回调
    self.snake.deadCallBack = ^(){
        __strong typeof(self) strongSelf = weakSelf;
        //停止定时器
        [strongSelf.timer invalidate];
        if (strongSelf.delegate && [strongSelf.delegate respondsToSelector:@selector(deadCallBack)]) {
            [strongSelf.delegate performSelector:@selector(deadCallBack) withObject:nil];
        }
        
    };
    //走路回调
    self.snake.walkCallBack = ^(NSArray * arr){
        __strong typeof(self) strongSelf = weakSelf;
        if (strongSelf.delegate&&[strongSelf.delegate respondsToSelector:@selector(walkCallBack:pointsArr:)]) {
            [strongSelf.delegate walkCallBack:strongSelf.food.currentPoint pointsArr:strongSelf.snake.pointsArr];
        }
    };
    //初始化地图
    self.map = [[Map alloc]init];
    //初始化食物
    self.food = [FoodFactory createInstanceWithUseArray:[self.map.mapDict copy] completion:^(CGPoint point) {
        __strong typeof(self) strongSelf = weakSelf;
        if (strongSelf.delegate&&[strongSelf.delegate respondsToSelector:@selector(foodCallBack:)]) {
            [strongSelf.delegate foodCallBack:point];
        }
    }];
    //蛇开始走道
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
    
}

- (void)restart{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    if (self.map) {
        self.map = nil;

    }
    if (self.food) {
        self.food = nil;
    }
    if (self.snake) {
        self.snake = nil;
    }
    [self startGame];    
}



#pragma 定时器
-(NSTimer *)timer{
    if (!_timer) {
        if (!(_level>0.0)) {
            _level = 0.5;
        }
        NSTimer * timer = [NSTimer timerWithTimeInterval:_level target:self selector:@selector(calculate) userInfo:nil repeats:YES];
        _timer = timer;
    }
    return _timer;
}

-(void)setLevel:(CGFloat)level{
    if (_level == 0) {
        _level = 0;
    }else{
        _level = level;
    }
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
        [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
}

-(void)addSpeed{
    
    self.level-=0.1;
}
-(void)minusSpeed{
    self.level+=0.1;
    
}


-(DirectionType)currentType{
    return self.snake.currentDirection;
}


-(void)setDirection:(DirectionType)type{
    if (self.snake) {
        self.snake.currentDirection = type;
    }

}

#pragma 计算
- (void)calculate{
    __weak typeof(self) weakSelf = self;
    [self.snake walk:self.snake.currentDirection foodPostion:self.food.currentPoint completion:^(NSArray *points) {
        __strong typeof(self) strongSelf = weakSelf;
        if (strongSelf.delegate&&[strongSelf.delegate respondsToSelector:@selector(walkCallBack:pointsArr:)]) {
            [strongSelf.delegate walkCallBack:strongSelf.food.currentPoint pointsArr:strongSelf.snake.pointsArr];
        }
    }];
}



@end
