//
//  IMEmojiHelper.m
//  BuHuiAi
//
//  Created by zhanghao on 16/7/2.
//  Copyright © 2016年 zhanghao. All rights reserved.
//

#import "IMEmojiHelper.h"
#import <YYKit/YYKit.h>
#import "ModelIMEmoji.h"

@implementation IMEmojiHelper

+ (NSRegularExpression *)regexEmoticon {
    static NSRegularExpression *regex;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        regex = [NSRegularExpression regularExpressionWithPattern:@"\\[[^ \\[\\]]+?\\]" options:kNilOptions error:NULL];
    });
    return regex;
}

+ (NSArray *)emojiDicArray{
    static NSArray *dicArr = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"IMEmoji" ofType:@"bundle"];
        NSData *jsonData = [NSData dataWithContentsOfFile:[bundlePath stringByAppendingPathComponent:@"EmojiList.json"]];
        
        dicArr = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:NULL];
    });
    
    return dicArr;
}

+ (UIImage*)emojiImgPNGWithEmojiKey:(NSString*)key{
    NSString *imgPath = [[self emojiImgPathWithEmojiKey:key] stringByAppendingString:@".png"];
    
    return [UIImage imageWithContentsOfFile:imgPath];
}

+ (UIImage*)emojiImgGIFWithEmojiKey:(NSString*)key{
    NSString *imgPath = [[self emojiImgPathWithEmojiKey:key] stringByAppendingString:@".gif"];
    
    return [UIImage imageWithContentsOfFile:imgPath];
}

+ (NSString *)emojiImgPathWithEmojiKey:(NSString *)key{
    static NSDictionary *emoji;
    static NSString *bundlePath;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        bundlePath = [[NSBundle mainBundle] pathForResource:@"IMEmoji" ofType:@"bundle"];
        NSData *jsonData = [NSData dataWithContentsOfFile:[bundlePath stringByAppendingPathComponent:@"EmojiMap.json"]];
        emoji = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:NULL];
    });
    
    NSString *index = emoji[key];
    
    return [NSString stringWithFormat:@"%@/%@@2x", bundlePath, index];
}

@end
