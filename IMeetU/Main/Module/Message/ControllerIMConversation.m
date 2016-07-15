//
//  ControllerIMConversation.m
//  IMeetU
//
//  Created by zhanghao on 16/7/13.
//  Copyright © 2016年 zhanghao. All rights reserved.
//

#import "ControllerIMConversation.h"
#import "UIStoryboard+Plug.h"

#import "ControllerIMChatMsg.h"

@interface ControllerIMConversation ()

@end

@implementation ControllerIMConversation

+ (instancetype)controller{
    ControllerIMConversation *controller = [UIStoryboard xmControllerWithName:xmStoryboardNameMessage indentity:@"ControllerIMConversation"];
    
    return controller;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)onClickTest:(id)sender {
    ControllerIMChatMsg *controller = [ControllerIMChatMsg controller];
    
    [self.navigationController pushViewController:controller animated:YES];
}


@end
