//
//  Food+Position.m
//  Snake
//
//  Created by MENGCHEN on 2017/1/6.
//  Copyright © 2017年 MENGCHEN. All rights reserved.
//

#import "Food+Position.h"
#import <objc/runtime.h>




@implementation Food (Position)

-(void)setCurrentPoint:(CGPoint)currentPoint{
    objc_setAssociatedObject(self, @selector(currentPoint), [NSValue valueWithCGPoint:currentPoint], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(CGPoint)currentPoint{
    id objc =  objc_getAssociatedObject(self, _cmd);
    return [objc CGPointValue];
}


#pragma 创建随机点
+ (CGPoint)createRandomPointWithMap:(NSDictionary *)map{
    CGPoint p = CGPointZero;
    int kSnakeWidthRange = (int)KeyWidth/100*100;
    int kSnakeHeightRange = (int)KeyHeight/100*100;
    int x = arc4random()%(int)(kSnakeWidthRange/SnakeWidth);
    int y = arc4random()%(int)(kSnakeHeightRange/SnakeWidth);
    p = CGPointMake(x*SnakeWidth, y*SnakeWidth);
    
    NSInteger num = [[map valueForKey:NSStringFromCGPoint(CGPointMake(x*SnakeWidth, y*SnakeWidth))] integerValue];
    if (num == 0) {
        //未被占用,返回该点
        return p;
    }else{
        //如果占用，那么重新创建该点
        return [Food createRandomPointWithMap:map];
    }
}




@end
