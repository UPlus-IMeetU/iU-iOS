//
//  ModelResponse.m
//  IMeetU
//
//  Created by zhanghao on 16/3/13.
//  Copyright © 2016年 zhanghao. All rights reserved.
//

#import "ModelResponse.h"
#import <YYKit/YYKit.h>
#import "UserDefultAccount.h"

@implementation ModelResponse

+ (instancetype)responselWithObject:(id)responseObject{
    ModelResponse *model = [ModelResponse modelWithDictionary:responseObject];
    model.data = responseObject[@"data"];
    return model;
}

- (NSInteger)state{
    if (_state == 303) {
        [UserDefultAccount cleanAccountCache];
    }
    return _state;
}

@end
