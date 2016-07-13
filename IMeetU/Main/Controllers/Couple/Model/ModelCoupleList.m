//
//  ModelCoupleList.m
//  IMeetU
//
//  Created by Spring on 16/7/13.
//  Copyright © 2016年 zhanghao. All rights reserved.
//

#import "ModelCoupleList.h"
#import "ModelCouple.h"
@implementation ModelCoupleList
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"users" : [ModelCouple class]
             };
}

@end
