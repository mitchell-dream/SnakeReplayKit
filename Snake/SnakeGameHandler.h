//
//  SnakeGameHandler.h
//  Snake
//
//  Created by MENGCHEN on 2017/1/5.
//  Copyright © 2017年 MENGCHEN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Direction.h"

#define SnakeManager [SnakeGameHandler sharedHandle]

@protocol SnakeGameDelegate <NSObject>

- (void)walkCallBack:(CGPoint)currentPoint pointsArr:(NSArray*)points;

- (void)eatCallBack;

- (void)deadCallBack;

- (void)foodCallBack:(CGPoint)point;

@end



@interface SnakeGameHandler : NSObject

/** 代理 */
@property(nonatomic, weak)id<SnakeGameDelegate> delegate;
/** 速度等级 */
@property(nonatomic, assign)CGFloat level;
/** 当前方向 */
@property(nonatomic, assign)DirectionType  currentType;

+ (instancetype)sharedHandle;

//开始游戏
- (void)startGame;
//设置方向
- (void)setDirection:(DirectionType)type;
//重新启动
- (void)restart;
//加速
- (void)addSpeed;
//减速
- (void)minusSpeed;
@end
