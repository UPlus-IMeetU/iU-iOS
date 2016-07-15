//
//  DBEmojiStore.h
//  BuHuiAi
//
//  Created by zhanghao on 16/7/5.
//  Copyright © 2016年 zhanghao. All rights reserved.
//

#import "DBCache.h"

@class ModelEmojiStore;

@interface DBEmojiStore : DBCache

+ (instancetype)shareDAO;

- (void)insertOrReplaceWithModel:(ModelEmojiStore*)model;

- (void)deleteWithId:(NSInteger)Id;

- (NSArray*)selectAllEmojiWithCallback:(void(^)(NSArray* models))callback;

@end
