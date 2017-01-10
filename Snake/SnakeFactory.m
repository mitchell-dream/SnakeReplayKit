//
//  SnakeFactory.m
//  Snake
//
//  Created by MENGCHEN on 2017/1/5.
//  Copyright © 2017年 MENGCHEN. All rights reserved.
//

#import "SnakeFactory.h"
#import "Snake.h"
#import "Direction.h"







@implementation SnakeFactory





//创建贪吃蛇
+(Snake *)createRandomInstance{
    //创建随机类型
    DirectionType type = [Direction getRandomDirection];
    //创建随机起始点
    int kSnakeWidthRange = (int)KeyWidth/100*100;
    int kSnakeHeightRange = (int)KeyHeight/100*100;
    
    CGFloat randomX = arc4random()%(int)kSnakeWidthRange/SnakeWidth;
    CGFloat randomY = arc4random()%(int)kSnakeHeightRange/SnakeWidth;
    CGPoint point = CGPointMake(randomX*SnakeWidth, randomY*SnakeWidth);
    //创建蛇
    Snake * snake = [[Snake alloc]initWithDirection:type startPoint:point length:kSnakeDefaultLength];
    return snake;
}

@end
