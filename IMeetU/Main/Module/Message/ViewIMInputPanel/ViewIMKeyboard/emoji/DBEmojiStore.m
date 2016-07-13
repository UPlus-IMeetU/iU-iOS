//
//  DBEmojiStore.m
//  BuHuiAi
//
//  Created by zhanghao on 16/7/5.
//  Copyright © 2016年 zhanghao. All rights reserved.
//

#import "DBEmojiStore.h"
#import "ModelEmojiStore.h"

@implementation DBEmojiStore

+ (instancetype)shareDAO{
    static DBEmojiStore *dao;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dao = [[DBEmojiStore alloc] init];
    });
    return dao;
}

- (instancetype)init{
    if (self = [super init]) {
        [self createTable];
    }
    return self;
}

- (void)createTable{
    if ([self.db open]) {
        NSString *sql = [NSString stringWithFormat:@"create table if not exists %@(id int primary key, file_name TEXT, title TEXT, format TEXT)", DB_EMOJI_STORE];
        [self.db executeUpdate:sql];
        [self.db close];
    }
}

- (void)insertOrReplaceWithModel:(ModelEmojiStore*)model{
    if ([self.db open]) {
        NSString *sql = [NSString stringWithFormat:@"insert or replace %@(id, file_name, title, format)values(?, ?, ?, ?)", DB_EMOJI_STORE];
        [self.db executeUpdate:sql, [model objId], model.fileName, model.title, model.format];
        [self.db close];
    }
}

- (void)deleteWithId:(NSInteger)Id{
    if ([self.db open]) {
        NSString *sql = [NSString stringWithFormat:@"delete form %@ where id=?", DB_EMOJI_STORE];
        [self.db executeUpdate:sql, [NSNumber numberWithInteger:Id]];
        [self.db close];
    }
}

- (NSArray*)selectAllEmojiWithCallback:(void (^)(NSArray *))callback{
    NSMutableArray *arr = nil;
    if ([self.db open]) {
        NSString *sql = [NSString stringWithFormat:@"select *from %@", DB_EMOJI_STORE];
        FMResultSet *set = [self.db executeQuery:sql];
        if (set.columnCount > 0) {
            arr = [NSMutableArray array];
            while (set.next) {
                ModelEmojiStore *model = [[ModelEmojiStore alloc] init];
                model.Id = [set longLongIntForColumn:@"id"];
                model.fileName = [set stringForColumn:@"file_name"];
                model.title = [set stringForColumn:@"title"];
                model.format = [set stringForColumn:@"format"];
                
                [arr addObject:model];
            }
        }
        [self.db close];
    }
    
    if (callback && arr.count==0) {
        //去后台同步
    }
    
    return arr;
}

@end
