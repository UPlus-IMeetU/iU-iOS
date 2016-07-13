//
//  ModelEmojiStores.m
//  BuHuiAi
//
//  Created by zhanghao on 16/7/5.
//  Copyright © 2016年 zhanghao. All rights reserved.
//

#import "ModelEmojiStores.h"

#import "ModelEmojiStore.h"
#import "DBEmojiStore.h"

@interface ModelEmojiStores()

@property (nonatomic, strong) NSArray *models;

@end
@implementation ModelEmojiStores

+ (instancetype)getInstance{
    ModelEmojiStores *models = [[ModelEmojiStores alloc] init];
    
    return models;
}

- (NSArray *)models{
    if (!_models) {
        _models = [[DBEmojiStore shareDAO] selectAllEmojiWithCallback:^(NSArray *models) {
            _models = models;
        }];
    }
    return _models;
}

- (NSInteger)numberOfEmoji{
    return self.models.count;
}

- (ModelEmojiStore *)emojiModelForItemAtIndex:(NSInteger)index{
    if (index < self.models.count) {
        return self.models[index];
    }
    return nil;
}
@end
