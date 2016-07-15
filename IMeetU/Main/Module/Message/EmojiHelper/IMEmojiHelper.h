//
//  IMEmojiHelper.h
//  BuHuiAi
//
//  Created by zhanghao on 16/7/2.
//  Copyright © 2016年 zhanghao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface IMEmojiHelper : NSObject

+ (NSRegularExpression *)regexEmoticon;

+ (NSArray*)emojiDicArray;

+ (UIImage*)emojiImgPNGWithEmojiKey:(NSString*)key;

+ (UIImage*)emojiImgGIFWithEmojiKey:(NSString*)key;
@end
