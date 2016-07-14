//
//  ModelSquareList.m
//  IMeetU
//
//  Created by Spring on 16/7/13.
//  Copyright © 2016年 zhanghao. All rights reserved.
//

#import "ModelSquareList.h"
#import "ModelSquare.h"
@implementation ModelSquareList
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"squares" : [ModelSquare class]
             };
}
@end
