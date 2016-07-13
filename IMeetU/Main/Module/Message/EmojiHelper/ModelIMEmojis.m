//
//  ModelIMEmojis.m
//  BuHuiAi
//
//  Created by zhanghao on 16/7/5.
//  Copyright © 2016年 zhanghao. All rights reserved.
//

#import "ModelIMEmojis.h"

@interface ModelIMEmojis()

@property (nonatomic, copy) NSString *rootPath;
@property (nonatomic, strong) NSArray *emojiDicArr;
@property (nonatomic, strong) NSDictionary *emojiKV;

@end
@implementation ModelIMEmojis

+ (instancetype)shareInstance{
    static ModelIMEmojis *models;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        models = [[ModelIMEmojis alloc] init];
    });
    
    return models;
}

- (NSInteger)numberOfEmoji{
    return self.emojiDicArr.count;
}

- (UIImage *)emojiImgPNGWithIndex:(NSInteger)index{
    if (index < [self numberOfEmoji]){
        NSString *imgPath = [NSString stringWithFormat:@"%@/%li@2x.png", self.rootPath, index];
        return [UIImage imageWithContentsOfFile:imgPath];
    }
    return nil;
}

- (UIImage*)emojiImgPNGWithEmojiKey:(NSString*)key{
    NSString *index = self.emojiKV[key];
    NSString *imgPath = [NSString stringWithFormat:@"%@/%@@2x.png", self.rootPath, index];
    
    return [UIImage imageWithContentsOfFile:imgPath];
}

- (UIImage*)emojiImgGIFWithEmojiKey:(NSString*)key{
    NSString *index = self.emojiKV[key];
    NSString *imgPath = [NSString stringWithFormat:@"%@/%@@2x.gif", self.rootPath, index];
    
    return [UIImage imageWithContentsOfFile:imgPath];
}

- (NSString *)emojiStrWithIndex:(NSInteger)index{
    if (index < self.emojiDicArr.count) {
        return self.emojiDicArr[index][@"d"];
    }
    return @"";
}

- (NSArray *)emojiDicArr{
    if (!_emojiDicArr) {
        NSData *jsonData = [NSData dataWithContentsOfFile:[self.rootPath stringByAppendingPathComponent:@"EmojiList.json"]];
        
        _emojiDicArr = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:NULL];
    }
    return _emojiDicArr;
}

- (NSDictionary *)emojiKV{
    if (!_emojiKV) {
        NSData *jsonData = [NSData dataWithContentsOfFile:[self.rootPath stringByAppendingPathComponent:@"EmojiMap.json"]];
        _emojiKV = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:NULL];
    }
    return _emojiKV;
}

- (NSString *)rootPath{
    if (!_rootPath) {
        _rootPath = [[NSBundle mainBundle] pathForResource:@"IMEmoji" ofType:@"bundle"];
    }
    return _rootPath;
}
@end
