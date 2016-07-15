//
//  IMEmojiUrlHelper.m
//  BuHuiAi
//
//  Created by zhanghao on 16/7/5.
//  Copyright © 2016年 zhanghao. All rights reserved.
//

#import "IMEmojiUrlHelper.h"

@implementation IMEmojiUrlHelper

+ (NSString *)urlEmojiMarketBtnWithId:(int)Id{
    return [NSString stringWithFormat:@"http://app-weiyu-protect.oss-cn-shanghai.aliyuncs.com/img/emoji/market/%i/btn.png", Id];
}

+ (NSString *)urlEmojiCustomWithFileName:(NSString *)fileName format:(NSString*)format{
    return [NSString stringWithFormat:@"http://app-weiyu-protect.oss-cn-shanghai.aliyuncs.com/img/emoji/custom/%@.%@", fileName, format];
}
@end
