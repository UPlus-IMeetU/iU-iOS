//
//  ModelEmojiStore.h
//  BuHuiAi
//
//  Created by zhanghao on 16/7/5.
//  Copyright © 2016年 zhanghao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModelEmojiStore : NSObject

@property (nonatomic, assign) NSInteger Id;
@property (nonatomic, copy) NSString *fileName;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *format;

- (NSNumber*)objId;

@end
