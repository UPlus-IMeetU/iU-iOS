//
//  ModelIMEmojiMarket.h
//  BuHuiAi
//
//  Created by zhanghao on 16/7/3.
//  Copyright © 2016年 zhanghao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModelIMEmojiMarket : NSObject

@property (nonatomic, assign) int Id;
@property (nonatomic, assign) int type;
@property (nonatomic, assign) int format;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *desc;

@property (nonatomic, strong) NSArray *items;

- (NSString*)btnImgUrl;

@end
