//
//  ModelIMEmojis.h
//  BuHuiAi
//
//  Created by zhanghao on 16/7/5.
//  Copyright © 2016年 zhanghao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ModelIMEmojis : NSObject

+ (instancetype)shareInstance;

- (NSInteger)numberOfEmoji;
- (UIImage*)emojiImgPNGWithIndex:(NSInteger)index;
- (UIImage*)emojiImgPNGWithEmojiKey:(NSString*)key;
- (UIImage*)emojiImgGIFWithEmojiKey:(NSString*)key;

- (NSString*)emojiStrWithIndex:(NSInteger)index;
@end
