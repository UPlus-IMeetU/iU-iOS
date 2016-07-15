//
//  ModelUser.h
//  IMeetU
//
//  Created by Spring on 16/7/13.
//  Copyright © 2016年 zhanghao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModelCouple : NSObject
@property (nonatomic,copy) NSString *icon_thumbnailUrl;
@property (nonatomic,assign) NSInteger user_code;
@property (nonatomic,copy) NSString *nickname;
/**
 *  性别 1 男 2 女
 */
@property (nonatomic,copy) NSString *sex;
@property (nonatomic,copy) NSString *school;
@property (nonatomic,assign) NSInteger distance;
@property (nonatomic,assign) long long actytime;
@property (nonatomic,copy) NSString *sign;
@end
