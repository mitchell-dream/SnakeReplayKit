//
//  FoodFactory.h
//  Snake
//
//  Created by MENGCHEN on 2017/1/6.
//  Copyright © 2017年 MENGCHEN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Food.h"

@interface FoodFactory : NSObject
+ (Food*)createInstanceWithUseArray:(NSDictionary *)arr completion:(void(^)(CGPoint))food;
@end
