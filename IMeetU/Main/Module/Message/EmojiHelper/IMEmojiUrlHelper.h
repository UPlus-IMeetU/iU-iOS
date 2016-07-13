//
//  IMEmojiUrlHelper.h
//  BuHuiAi
//
//  Created by zhanghao on 16/7/5.
//  Copyright © 2016年 zhanghao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IMEmojiUrlHelper : NSObject

+ (NSString *)urlEmojiMarketBtnWithId:(int)Id;

+ (NSString *)urlEmojiCustomWithFileName:(NSString *)fileName format:(NSString*)format;

@end
