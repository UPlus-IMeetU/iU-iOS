//
//  TextParserIMInputPanel.h
//  BuHuiAi
//
//  Created by zhanghao on 16/7/2.
//  Copyright © 2016年 zhanghao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YYKit/YYKit.h>

@interface TextParserIMInputPanel : NSObject <YYTextParser>

@property (nonatomic, strong) UIFont *font;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIColor *highlightTextColor;

@end
