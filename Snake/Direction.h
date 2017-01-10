//
//  Direction.h
//  Snake
//
//  Created by MENGCHEN on 2017/1/5.
//  Copyright © 2017年 MENGCHEN. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, DirectionType) {
    DirectionTypeLeft,
    DirectionTypeRight,
    DirectionTypeTop,
    DirectionTypeBottom,
};


@interface Direction : NSObject
/**  当前的方向 */
@property(nonatomic, assign)DirectionType * currentDirection;

+ (DirectionType)getRandomDirection;

@end
