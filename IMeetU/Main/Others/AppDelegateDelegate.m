//
//  AppDelegateDelegate.m
//  IMeetU
//
//  Created by zhanghao on 16/3/19.
//  Copyright © 2016年 zhanghao. All rights reserved.
//

#import "AppDelegateDelegate.h"
#import <YYKit/YYKit.h>

#import "ModelRemoteNotification.h"

#import "XMUrlHttp.h"
#import "AFNetworking.h"
#import "UserDefultAccount.h"
#import "FactotyLocalNotification.h"
#import "UserDefultMsg.h"
#import "UserDefultSetting.h"
#import "ControllerTabBarMain.h"

@interface AppDelegateDelegate()

@end
@implementation AppDelegateDelegate

+ (instancetype)shareAppDelegateDelegate{
    static AppDelegateDelegate *obj;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        obj = [[AppDelegateDelegate alloc] init];
    });
    
    return obj;
}

- (void)appDelegate:(AppDelegate *)appDelegate isEnterFromRemoteNotification:(BOOL)isEnterFromRemoteNotification remoteNotificationUserInfo:(ModelRemoteNotification*)userInfo{
    if (self.delegateAppDelegate) {
        if ([self.delegateAppDelegate respondsToSelector:@selector(appDelegate:isEnterFromRemoteNotification:remoteNotificationUserInfo:)]) {
            [self.delegateAppDelegate appDelegate:appDelegate isEnterFromRemoteNotification:isEnterFromRemoteNotification remoteNotificationUserInfo:userInfo];
        }
    }
}

- (void)applicationWillEnterForeground:(UIApplication *)application{
    if (self.delegateAppDelegate) {
        if ([self.delegateAppDelegate respondsToSelector:@selector(applicationWillEnterForeground:)]) {
            [self.delegateAppDelegate applicationWillEnterForeground:application];
        }
    }
}

- (void)didRemovedFromServer{
    [UserDefultAccount cleanAccountCache];
    
//    AFHTTPSessionManager *httpManager = [AFHTTPSessionManager manager];
//    httpManager.requestSerializer = [AFHTTPRequestSerializer serializer];
//    httpManager.responseSerializer = [AFJSONResponseSerializer serializer];
//    
//    NSDictionary *parameters = @{@"token":[UserDefultAccount token], @"user_code":[UserDefultAccount userCode], @"device_code":[[UIDevice currentDevice].identifierForVendor UUIDString]};
//    [httpManager POST:[XMUrlHttp xmLogout] parameters:@{@"data":[parameters modelToJSONString]} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        
//    }];
}



@end
