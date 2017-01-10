//
//  Snake.m
//  Snake
//
//  Created by MENGCHEN on 2017/1/5.
//  Copyright © 2017年 MENGCHEN. All rights reserved.
//

#import "Snake.h"

@implementation Snake
-(instancetype)initWithDirection:(DirectionType)type startPoint:(CGPoint)startPoint length:(CGFloat)length{
    if (self = [super init]) {
        //设置开始点
        self.currentHeadPoint = startPoint;
        //设置初始化方向和数据
        self.currentDirection = type;
        self.length = length;
        [self initialData:type];
    }
    return self;
}


#pragma 创建点数组
-(NSMutableArray *)pointsArr{
    if (!_pointsArr) {
        NSMutableArray * arr = [NSMutableArray array];
        _pointsArr = arr;
    }
    return _pointsArr;
}



#pragma 创建数据
-(void)initialData:(DirectionType)type{
    switch (type) {
            //向左
        case DirectionTypeLeft:
        {
            CGPoint point = self.currentHeadPoint;
            for (NSInteger i = 0; i<self.length; i++) {
                CGPoint p = CGPointMake(point.x+i*SnakeWidth, point.y);
                [self.pointsArr addObject:[NSValue valueWithCGPoint:p]];
            }
        }
            break;
            //向右
        case DirectionTypeRight:
        {
            CGPoint point = self.currentHeadPoint;
            for (NSInteger i = 0; i<self.length; i++) {
                CGPoint p = CGPointMake(point.x-i*SnakeWidth, point.y);
                [self.pointsArr addObject:[NSValue valueWithCGPoint:p]];
            }
        }
            break;
            //向下
        case DirectionTypeBottom:
        {
            CGPoint point = self.currentHeadPoint;
            for (NSInteger i = 0; i<self.length; i++) {
                CGPoint p = CGPointMake(point.x, point.y-i*SnakeWidth);
                [self.pointsArr addObject:[NSValue valueWithCGPoint:p]];
            }
        }
            break;
            //向上
        case DirectionTypeTop:
        {
            CGPoint point = self.currentHeadPoint;
            for (NSInteger i = 0; i<self.length; i++) {
                CGPoint p = CGPointMake(point.x, point.y+i*SnakeWidth);
                [self.pointsArr addObject:[NSValue valueWithCGPoint:p]];
            }
        }
            break;
        default:
            break;
    }
    if (self.walkCallBack) {
        self.walkCallBack(self.pointsArr);
    }
    
        
    
    
}

#pragma 死
- (void)dead{
    NSLog(@"蛇死了");
    if (self.deadCallBack) {
        self.deadCallBack();
    }
}

#pragma 吃
- (void)eat{
    self.length++;
    if (self.eatBack) {
        self.eatBack(self.foodPosition);
    }
    
}

#pragma 走
-(void)walk:(DirectionType)type foodPostion:(CGPoint)foodPosition completion:(void (^)(NSArray *))completionBack{
    //食物位置
    self.foodPosition = foodPosition;
    //查看食物是否可以到达
    if (![self canArriveFoodPosition]) {
        NSLog(@"无法到达%@",NSStringFromCGPoint(self.foodPosition));
        return;
    }
    NSLog(@"食物位置%@",NSStringFromCGPoint(self.foodPosition));
    switch (type) {
        case DirectionTypeLeft:
        {
            [self toLeft];
        }
            break;
        case DirectionTypeRight:
        {
            [self toRight];
        }
            break;
        case DirectionTypeTop:
        {
            [self toTop];
        }
            break;
        case DirectionTypeBottom:
        {
            [self toBottom];
        }
            break;
    }
    if (completionBack) {
        completionBack(self.pointsArr);
    }
    NSLog(@"%@",self.pointsArr);
}


#pragma 食物是否可到达
- (BOOL)canArriveFoodPosition{
    //查看食物是否在蛇的身体坐标上
    CGPoint point = CGPointZero;
    for (id p in self.pointsArr) {
        point = [p CGPointValue];
        if (CGPointEqualToPoint(point, self.foodPosition)) {
            return false;
        }
    }
    //查看食物是否在区域之内
    if([self inBoundary:self.foodPosition]){
        return true;
    }
    return false;
}

#pragma 是否在区域之内
- (BOOL)inBoundary:(CGPoint)point{
    int kSnakeWidthRange = (int)KeyWidth/100*100;
    int kSnakeHeightRange = (int)KeyHeight/100*100;
    NSLog(@"x范围 =%d y范围 = %d ",kSnakeWidthRange,kSnakeHeightRange);
    if (point.x>=0&&point.x<=kSnakeWidthRange&&point.y>=0&&point.y<kSnakeHeightRange) {
        return true;
    } else {
        return false;
    }
}




#pragma 插入点
- (void)insertPoint:(CGPoint)point{
    if ([self inBoundary:point]) {
        self.currentHeadPoint = point;
        [self.pointsArr insertObject:[NSValue valueWithCGPoint:point] atIndex:0];
        if (!CGPointEqualToPoint(self.foodPosition, [[self.pointsArr firstObject] CGPointValue])) {
            [self.pointsArr removeLastObject];
        }else{
            //吃到食物
            [self eat];

        }
    } else {
        [self dead];
    }
}

-(void)toLeft{
    NSLog(@"向左");
    self.currentDirection = DirectionTypeLeft;
    //创建点，加入数组
    CGPoint p = CGPointMake(self.currentHeadPoint.x-SnakeWidth, self.currentHeadPoint.y);
    [self insertPoint:p];
}

- (void)toRight{
    NSLog(@"向右");
    self.currentDirection = DirectionTypeRight;
    //创建点，加入数组
    CGPoint p = CGPointMake(self.currentHeadPoint.x+SnakeWidth, self.currentHeadPoint.y);
    [self insertPoint:p];

}
- (void)toTop{
    NSLog(@"向上");
    self.currentDirection = DirectionTypeTop;
    //创建点，加入数组
    CGPoint p = CGPointMake(self.currentHeadPoint.x, self.currentHeadPoint.y-SnakeWidth);
    [self insertPoint:p];

}
- (void)toBottom{
    NSLog(@"向下");
    self.currentDirection = DirectionTypeBottom;
    //创建点，加入数组
    CGPoint p = CGPointMake(self.currentHeadPoint.x, self.currentHeadPoint.y+SnakeWidth);
    [self insertPoint:p];
}



@end
