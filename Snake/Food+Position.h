//
//  Food+Position.h
//  Snake
//
//  Created by MENGCHEN on 2017/1/6.
//  Copyright © 2017年 MENGCHEN. All rights reserved.
//

#import "Food.h"
#import <UIKit/UIKit.h>
@interface Food (Position)

/** 当前位置 */
@property(nonatomic, assign)CGPoint currentPoint;
+ (CGPoint)createRandomPointWithMap:(NSDictionary*)map;
@end
