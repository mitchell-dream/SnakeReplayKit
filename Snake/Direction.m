//
//  Direction.m
//  Snake
//
//  Created by MENGCHEN on 2017/1/5.
//  Copyright © 2017年 MENGCHEN. All rights reserved.
//

#import "Direction.h"

@implementation Direction


+(DirectionType)getRandomDirection{
    //创建随机数
    DirectionType type = DirectionTypeRight;
    int value = arc4random() % 4;
    if (value == 0) {
        type = DirectionTypeTop;
    }else if (value == 1){
        type = DirectionTypeBottom;
    }else if (value == 2){
        type = DirectionTypeLeft;
    }else{
        type = DirectionTypeRight;
    }
    return type;
}

@end
