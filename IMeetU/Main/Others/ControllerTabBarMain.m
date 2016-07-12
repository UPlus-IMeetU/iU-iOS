//
//  ControllerTabBarMain.m
//  IMeetU
//
//  Created by zhanghao on 16/5/11.
//  Copyright © 2016年 zhanghao. All rights reserved.
//

#import "ControllerTabBarMain.h"
#import "UserDefultAccount.h"

#import "ControllerNavi.h"

#import "ControllerUserLoginOrRegister.h"
#import "ControllerMineMain.h"
#import "ControllerCommunity.h"
#import "MLToast.h"
#import "Reachability.h"
#import "ControllerCouple.h"

#import "UITabBar+badge.h"

@interface ControllerTabBarMain ()

@property (nonatomic,strong) ControllerNavi *controllerNaviCouple;
@property (nonatomic,strong) ControllerCouple *controllerCouple;

@property (nonatomic, strong) ControllerNavi *controllerNaviMine;
@property (nonatomic, strong) ControllerMineMain *controllerMine;

@property (nonatomic, strong) ControllerNavi *controllerNaviCommunity;
@property (nonatomic, strong) ControllerCommunity * controllerCommunity;



@end

@implementation ControllerTabBarMain

+ (instancetype)shareController{
    static ControllerTabBarMain *controller;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        controller = [[ControllerTabBarMain alloc] init];
        [controller initial];
    });
    return controller;
}

+ (void)setBadgeMsgWithCount:(NSInteger)badge{
    ControllerTabBarMain *controller = [ControllerTabBarMain shareController];
    
//    UITabBarItem *tabBarItem = controller.controllerNaviMsg.tabBarItem;
//    if (badge == 0) {
//        tabBarItem.badgeValue = nil;
//    }else if (badge > 0 && badge < 100){
//        tabBarItem.badgeValue = [NSString stringWithFormat:@"%lu", (long)badge];
//    }else if (badge > 99 && badge < NSIntegerMax){
//        tabBarItem.badgeValue = @"99+";
//    }else{
//        tabBarItem.badgeValue = @"";
//    }
}

+ (void)setBadgeCommunityWithIsShow:(BOOL)isShow{
    ControllerTabBarMain *controller = [ControllerTabBarMain shareController];
    UITabBarItem *tabBarItem = controller.controllerNaviCommunity.tabBarItem;
    
    tabBarItem.badgeValue = isShow? @" ":@"";
}

- (void)loginOrRegister{
    UIAlertController *c = [UIAlertController alertControllerWithTitle:@"请登录" message:@"如果要继续操作需要登录" preferredStyle:UIAlertControllerStyleAlert];
    [c addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        ControllerUserLoginOrRegister *userLoginOrRegister = [ControllerUserLoginOrRegister shareController];
        UINavigationController *controller = [[UINavigationController alloc] initWithRootViewController:userLoginOrRegister];
        controller.navigationBar.hidden = YES;
        
        [self presentViewController:controller animated:NO completion:nil];
    }]];
    
    [self presentViewController:c animated:YES completion:^{}];
    
}

- (void)initial{
    
    UIView *bgView = [[UIView alloc] initWithFrame:self.tabBar.bounds];
    bgView.backgroundColor = [UIColor  colorWithRed:50/255.0 green:64/255.0 blue:71/255.0 alpha:1];
    [self.tabBar insertSubview:bgView atIndex:0];
    self.tabBar.opaque = YES;
    //一半
    self.controllerCouple = [ControllerCouple shareControllerCouple];
    self.controllerNaviCouple = [[ControllerNavi alloc] initWithRootViewController:self.controllerCouple];
    self.controllerNaviCouple.tabBarItem.image = [[UIImage imageNamed:@"tab_btn_cp_nor"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.controllerNaviCouple.tabBarItem.selectedImage = [[UIImage imageNamed:@"tab_btn_cp_light"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.controllerNaviCouple.title = @"一半";
    //社区
    self.controllerCommunity = [ControllerCommunity shareControllerCommunity];
    self.controllerNaviCommunity = [[ControllerNavi alloc] initWithRootViewController:self.controllerCommunity];
    self.controllerNaviCommunity.tabBarItem.image = [[UIImage imageNamed:@"tab_icon_found_nor"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.controllerNaviCommunity.tabBarItem.selectedImage = [[UIImage imageNamed:@"tab_icon_found_light"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.controllerNaviCommunity.title = @"发现";
    
    
    self.controllerMine = [ControllerMineMain  controllerWithUserCode:nil getUserCodeFrom:MineMainGetUserCodeFromUserDefult];
    self.controllerNaviMine = [[ControllerNavi alloc] initWithRootViewController:self.controllerMine];
    self.controllerNaviMine.tabBarItem.title = @"我的";
    self.controllerNaviMine.tabBarItem.image = [[UIImage imageNamed:@"main_tab_icon_mine_nor"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.controllerNaviMine.tabBarItem.selectedImage = [[UIImage imageNamed:@"main_tab_icon_mine_light"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    self.viewControllers = @[self.controllerNaviCouple,self.controllerNaviCommunity,self.controllerNaviMine];
    //默认显示发送biubiu的页面
    self.selectedIndex = 0;
    
    Reachability* reach = [Reachability reachabilityWithHostname:@"www.baidu.com"];
    reach.reachableBlock = ^(Reachability*reach)
    {
    };
    reach.unreachableBlock = ^(Reachability*reach)
    {
        [[MLToast toastInView:self.view content:@"网络连接失败"] show];
    };
    [reach startNotifier];
}

- (void)showBadgeWithIndex:(NSInteger)index{
    [self.tabBar showBadgeOnItemIndex:index];
}
- (void)hideBadgeWithIndex:(NSInteger)index{
    [self.tabBar hideBadgeOnItemIndex:index];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

@end
