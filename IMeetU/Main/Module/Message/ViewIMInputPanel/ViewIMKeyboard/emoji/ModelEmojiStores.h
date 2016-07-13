//
//  ModelEmojiStores.h
//  BuHuiAi
//
//  Created by zhanghao on 16/7/5.
//  Copyright © 2016年 zhanghao. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ModelEmojiStore;

@interface ModelEmojiStores : NSObject

+ (instancetype)getInstance;

- (NSInteger)numberOfEmoji;

- (ModelEmojiStore*)emojiModelForItemAtIndex:(NSInteger)index;
@end
