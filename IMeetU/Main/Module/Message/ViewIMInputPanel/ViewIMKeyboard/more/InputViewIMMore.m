//
//  InputViewIMMore.m
//  IMTest
//
//  Created by zhanghao on 16/7/1.
//  Copyright © 2016年 zhanghao. All rights reserved.
//

#import "InputViewIMMore.h"

@implementation InputViewIMMore

+ (instancetype)inputViewWithHeight:(CGFloat)height{
    InputViewIMMore *view = [InputViewIM viewWithNibName:@"InputViewIMMore" viewClass:[InputViewIMMore class]];
    
    return view;
}

@end
