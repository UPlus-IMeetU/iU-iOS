//
//  XMViewVoicePowerIndicator.h
//  IMeetU
//
//  Created by zhanghao on 16/7/16.
//  Copyright © 2016年 zhanghao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, XMViewVoicePowerIndicatorLRDirection) {
    XMViewVoicePowerIndicatorLRDirectionLeft,
    XMViewVoicePowerIndicatorLRDirectionRight
};

typedef NS_ENUM(NSInteger, XMViewVoicePowerIndicatorUDDirection) {
    XMViewVoicePowerIndicatorUDDirectionUp,
    XMViewVoicePowerIndicatorUDDirectionDown,
    XMViewVoicePowerIndicatorUDDirectionUD
};

@interface XMViewVoicePowerIndicator : UIView
//视图frame
@property (nonatomic, assign) CGRect viewFrame;
//指示条距视图上下左右的边距
@property (nonatomic, assign) UIEdgeInsets indicatorEdgeInsets;
//指示条的个数
@property (nonatomic, assign) NSInteger countOfIndicator;
//指示条颜色
@property (nonatomic, strong) UIColor *indicatorColor;
//最大功率
@property (nonatomic, assign) CGFloat maxPower;
@property (nonatomic, assign) CGFloat minPower;
//指示条的宽度
@property (nonatomic, assign) CGFloat indicatorItemWidth;
//指示条之间的距离
@property (nonatomic, assign) CGFloat indicatorItemMargin;

@property (nonatomic, assign) XMViewVoicePowerIndicatorLRDirection indicatorLRDirection;
@property (nonatomic, assign) XMViewVoicePowerIndicatorUDDirection indicatorUDDirection;

- (void)addPowerItem:(CGFloat)power;

- (void)cleanPowerItem;
@end