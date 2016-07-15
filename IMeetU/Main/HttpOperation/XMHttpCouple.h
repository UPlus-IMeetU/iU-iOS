//
//  XMHttpCouple.h
//  IMeetU
//
//  Created by Spring on 16/7/14.
//  Copyright © 2016年 zhanghao. All rights reserved.
//

#import "XMHttp.h"

@interface XMHttpCouple : XMHttp
/**
 *  获取一半的接口
 *
 *  @param lastTime 时间 0的话为刷新，其他的话为loading
 *  @param block
 */
- (void)xmGetHalfListWithLastTime:(long long)lastTime block:(XMHttpBlockStandard)block;
/**
 *  获取广场的信息
 *
 */
- (void)xmGetSquareInfoWithBlock:(XMHttpBlockStandard)block;
@end
