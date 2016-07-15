//
//  ModelIMEmojiMarkets.m
//  BuHuiAi
//
//  Created by zhanghao on 16/7/3.
//  Copyright © 2016年 zhanghao. All rights reserved.
//

#import "ModelIMEmojiMarkets.h"
#import "ModelIMEmojiMarket.h"


@interface ModelIMEmojiMarkets()

@property (nonatomic, strong) NSMutableArray *models;

@end
@implementation ModelIMEmojiMarkets

+ (instancetype)getInstance{
    ModelIMEmojiMarkets *model = [[ModelIMEmojiMarkets alloc] init];
    
    return model;
}

- (NSInteger)numberOfEmojiSwitch{
    return self.models.count + 2;
}

- (NSString *)btnImgUrlForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row > 1 && indexPath.row < self.models.count) {
        ModelIMEmojiMarket *model = self.models[0];
        return [model btnImgUrl];
    }
    return nil;
}

@end
