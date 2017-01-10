//
//  Map.h
//  Snake
//
//  Created by MENGCHEN on 2017/1/5.
//  Copyright © 2017年 MENGCHEN. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef struct {
    int value;
    char * key;
}mapNote;
@interface Map : NSObject
//地图数据
//@property(nonatomic, strong)NSMutableSet  * mapData;
/** 地图字典 */
@property(nonatomic, strong)NSMutableDictionary *  mapDict;



@end
