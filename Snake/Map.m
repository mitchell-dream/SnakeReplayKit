//
//  Map.m
//  Snake
//
//  Created by MENGCHEN on 2017/1/5.
//  Copyright © 2017年 MENGCHEN. All rights reserved.
//

#import "Map.h"
#import <UIKit/UIKit.h>







@interface Map()






@end
@implementation Map
-(instancetype)init{
    if (self = [super init]) {
        int kSnakeWidthRange = (int)KeyWidth/100*100;
        int kSnakeHeightRange = (int)KeyHeight/100*100;
//        self.mapData = [NSMutableSet set];
        self.mapDict = [NSMutableDictionary dictionaryWithCapacity:0];
        @autoreleasepool {
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                for (int i = 0; i<kSnakeWidthRange/SnakeWidth; i= i+SnakeWidth) {
                    for (int j = 0; j<kSnakeHeightRange/SnakeWidth; j= j+SnakeWidth) {
                        //                        mapNote * a = (mapNote*)malloc(sizeof(mapNote));
//                        a->value = 0;
//                        a->key = (char *)[NSStringFromCGPoint(CGPointMake(i, j)) UTF8String];
//                        NSValue * ss = [NSValue valueWithBytes:&a objCType:@encode(mapNote)];
//                        [self.mapData addObject:ss];
                        [self.mapDict setValue:@0 forKey:NSStringFromCGPoint(CGPointMake(i*SnakeWidth, j*SnakeWidth))];
                        
                    }
                }
            });
        }
    }
    return self;
}


@end
