//
//  FoodFactory.m
//  Snake
//
//  Created by MENGCHEN on 2017/1/6.
//  Copyright © 2017年 MENGCHEN. All rights reserved.
//

#import "FoodFactory.h"
#import "Food+Position.h"

@implementation FoodFactory



+(Food*)createInstanceWithUseArray:(NSDictionary *)dict completion:(void (^)(CGPoint))foodP{
    Food * food = [[Food alloc]init];
    food.currentPoint = [Food createRandomPointWithMap:dict];
    if (foodP) {
        foodP(food.currentPoint);
    }    
    return food;
}
@end
