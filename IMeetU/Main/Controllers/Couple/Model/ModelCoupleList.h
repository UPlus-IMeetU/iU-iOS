//
//  ModelCoupleList.h
//  IMeetU
//
//  Created by Spring on 16/7/13.
//  Copyright © 2016年 zhanghao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ModelCouple.h"
@interface ModelCoupleList : NSObject
@property (nonatomic,copy) NSString *token;
@property (nonatomic,copy) NSString *has_next;
@property (nonatomic,strong) NSArray *users;
@end
