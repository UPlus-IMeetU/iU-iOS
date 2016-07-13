//
//  ModelIMEmojiMarket.m
//  BuHuiAi
//
//  Created by zhanghao on 16/7/3.
//  Copyright © 2016年 zhanghao. All rights reserved.
//

#import "ModelIMEmojiMarket.h"
#import "IMEmojiUrlHelper.h"

@interface ModelIMEmojiMarket()

@end
@implementation ModelIMEmojiMarket

- (NSString *)btnImgUrl{
    return [IMEmojiUrlHelper urlEmojiMarketBtnWithId:self.Id];
}

@end
