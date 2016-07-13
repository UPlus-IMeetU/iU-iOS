//
//  ModelIMEmojiMarkets.h
//  BuHuiAi
//
//  Created by zhanghao on 16/7/3.
//  Copyright © 2016年 zhanghao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ModelIMEmojiMarkets : NSObject

+ (instancetype)getInstance;
/**
 * 可选择的表情种类数量
 */
- (NSInteger)numberOfEmojiSwitch;

- (NSString*)btnImgUrlForItemAtIndexPath:(NSIndexPath *)indexPath;

@end
