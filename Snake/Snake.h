//
//  Snake.h
//  Snake
//
//  Created by MENGCHEN on 2017/1/5.
//  Copyright © 2017年 MENGCHEN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Direction.h"

typedef void (^eatCallBack)(CGPoint food);
typedef void (^walkCallback)(NSArray *points);
typedef void (^deadCallBack)();

@interface Snake : NSObject
/** 当前方向 */
@property(nonatomic, assign)DirectionType  currentDirection;
/** 当前数组 */
@property(nonatomic, strong)NSMutableArray * pointsArr;
/** 当前头部坐标 */
@property(nonatomic, assign)CGPoint  currentHeadPoint;
/** 总长度 */
@property(nonatomic, assign)CGFloat  width;
/** 当前尾部坐标 */
@property(nonatomic, assign)CGPoint  currentTailPoint;
/** 长度 */
@property(nonatomic, assign)CGFloat length;

/** 当前食物的位置 */
@property(nonatomic, assign)CGPoint foodPosition;

/** 吃掉回调 */
@property(nonatomic, copy)eatCallBack eatBack;

/** 死亡回调 */
@property(nonatomic, copy)deadCallBack deadCallBack;

/** 走路回调 */
@property(nonatomic, copy)walkCallback walkCallBack;


-(instancetype)initWithDirection:(DirectionType)type startPoint:(CGPoint)startPoint length:(CGFloat)length;

- (void)walk:(DirectionType)type foodPostion:(CGPoint)foodPosition completion:(void(^)(NSArray *))arr;








@end
