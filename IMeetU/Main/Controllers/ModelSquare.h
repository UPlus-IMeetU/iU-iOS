//
//  ModelSquare.h
//  IMeetU
//
//  Created by Spring on 16/7/13.
//  Copyright © 2016年 zhanghao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModelSquare : NSObject
/**
 *  任务类型
 */
@property (nonatomic,copy) NSString *squareId;
/**
 *  图标颜色
 */
@property (nonatomic,copy) NSString *icon_url;
/**
 *  标题
 */
@property (nonatomic,copy) NSString *content;
/**
 *  任务数量
 */
@property (nonatomic,assign) NSInteger number_duty;
/**
 *  回复数量
 */
@property (nonatomic,assign) NSInteger number_response;
/**
 *  颜色
 */
@property (nonatomic,copy) NSString *color;
@end
