//
//  SnakeFactory.h
//  Snake
//
//  Created by MENGCHEN on 2017/1/5.
//  Copyright © 2017年 MENGCHEN. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Snake;
@interface SnakeFactory : NSObject

+(Snake*)createRandomInstance;


@end
