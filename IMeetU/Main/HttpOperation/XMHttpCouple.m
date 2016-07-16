//
//  XMHttpCouple.m
//  IMeetU
//
//  Created by Spring on 16/7/14.
//  Copyright © 2016年 zhanghao. All rights reserved.
//

#import "XMHttpCouple.h"

@implementation XMHttpCouple
+ (instancetype)http{
    return [[XMHttpCouple alloc] init];
}

- (void)xmGetHalfListWithLastTime:(long long)lastTime block:(XMHttpBlockStandard)block{
    NSString *url = [XMUrlHttp xmGetOtherHalf];
    NSDictionary *param = [self parametersFactoryAppendTokenDeviceCode:@{@"time":[NSNumber numberWithLongLong:lastTime]}];
    [self.httpManager POST:url parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ModelResponse *response = [ModelResponse responselWithObject:responseObject];
        block (response.state, response.data, task, nil);    } failure:
     ^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         block (RESPONSE_CODE_ERR, nil, task, error);
     }];
}

- (void)xmGetSquareInfoWithBlock:(XMHttpBlockStandard)block{
    NSString *url = [XMUrlHttp  xmGetSqureInfo];
    NSDictionary *param = [self parametersFactoryAppendTokenDeviceCode:@{}];
    [self.httpManager POST:url parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ModelResponse *response = [ModelResponse responselWithObject:responseObject];
        block (response.state, response.data, task, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block (RESPONSE_CODE_ERR, nil, task, error);
    }];
}


- (void)xmGetMyCareAboutPeopleWithBlock:(XMHttpBlockStandard)block{
    NSString *url = [XMUrlHttp xmGetCarePeopleList];
    NSDictionary *param = [self parametersFactoryAppendTokenDeviceCode:@{}];
    [self.httpManager POST:url parameters:param success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ModelResponse *response = [ModelResponse responselWithObject:responseObject];
        block (response.state, response.data, task, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block (RESPONSE_CODE_ERR, nil, task, error);
    }];
}
@end
