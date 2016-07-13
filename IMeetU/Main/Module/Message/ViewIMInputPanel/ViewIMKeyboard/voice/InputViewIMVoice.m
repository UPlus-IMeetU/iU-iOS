//
//  InputViewIMVoice.m
//  IMTest
//
//  Created by zhanghao on 16/7/1.
//  Copyright © 2016年 zhanghao. All rights reserved.
//

#import "InputViewIMVoice.h"

@implementation InputViewIMVoice

+ (instancetype)inputViewWithHeight:(CGFloat)height{
    InputViewIMVoice *view = [InputViewIM viewWithNibName:@"InputViewIMVoice" viewClass:[InputViewIMVoice class]];
    
    return view;
}

@end
