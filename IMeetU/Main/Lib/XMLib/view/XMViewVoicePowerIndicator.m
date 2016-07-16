//
//  XMViewVoicePowerIndicator.m
//  IMeetU
//
//  Created by zhanghao on 16/7/16.
//  Copyright © 2016年 zhanghao. All rights reserved.
//

#import "XMViewVoicePowerIndicator.h"

@interface XMViewVoicePowerIndicator()

@property (nonatomic, strong) NSMutableArray *powers;

@end
@implementation XMViewVoicePowerIndicator

- (void)drawRect:(CGRect)rect {
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    //设置线的颜色
    [self.indicatorColor setStroke];
    //设置线的宽度
    CGContextSetLineWidth(ctx, self.indicatorItemWidth);
    
    //单位功率高度（在计算指示器高度时，仅需将功率乘以单位功率高度即可）
    CGFloat heightOfPower = (self.viewFrame.size.height-(self.indicatorEdgeInsets.bottom+self.indicatorEdgeInsets.top))/1.0/self.maxPower;
    for (int i=0; i<self.countOfIndicator; i++) {
        CGFloat power = [self.powers[i] floatValue];
        //计算线的起始点
        CGPoint pointStart;
        CGPoint pointEnd;
        if (self.indicatorLRDirection == XMViewVoicePowerIndicatorLRDirectionLeft) {
            pointStart.x = self.viewFrame.size.width-self.indicatorEdgeInsets.left-(self.indicatorItemMargin+self.indicatorItemWidth)*i;
            pointEnd.x = pointStart.x;
        }else if(self.indicatorLRDirection == XMViewVoicePowerIndicatorLRDirectionRight){
            pointStart.x = self.indicatorEdgeInsets.right+(self.indicatorItemMargin+self.indicatorItemWidth)*i;
            pointEnd.x = pointStart.x;
        }
        
        if (self.indicatorUDDirection == XMViewVoicePowerIndicatorUDDirectionUp) {
            pointStart.y = self.viewFrame.size.height-self.indicatorEdgeInsets.bottom;
            pointEnd.y = pointStart.y - power*heightOfPower;
        }else if (self.indicatorUDDirection == XMViewVoicePowerIndicatorUDDirectionDown){
            pointStart.y = self.indicatorEdgeInsets.top;
            pointEnd.y = pointStart.y + power*heightOfPower;
        }else if (self.indicatorUDDirection == XMViewVoicePowerIndicatorUDDirectionUD){
            pointStart.y = (self.viewFrame.size.height - (self.indicatorEdgeInsets.top+self.indicatorEdgeInsets.bottom) - power*heightOfPower)/2;
            pointEnd.y = pointStart.y + power*heightOfPower;
        }
        
        CGContextMoveToPoint(ctx, pointStart.x, pointStart.y);
        CGContextAddLineToPoint(ctx, pointEnd.x, pointEnd.y);
        CGContextStrokePath(ctx);
    }
    
    NSLog(@"======drawrect");
}

- (void)addPowerItem:(CGFloat)power{
    power = power<self.minPower? self.minPower:power;
    power = power>self.maxPower? self.maxPower:power;
    
    [self.powers insertObject:[NSNumber numberWithFloat:power] atIndex:0];
    [self.powers removeObjectAtIndex:self.countOfIndicator];
    
    [self setNeedsDisplay];
}

- (void)cleanPowerItem{
    [self.powers removeAllObjects];
    for (int i=0; i<self.countOfIndicator; i++) {
        [self.powers addObject:[NSNumber numberWithFloat:self.minPower]];
    }
    
    [self setNeedsDisplay];
}

- (NSMutableArray *)powers{
    if (!_powers) {
        _powers = [NSMutableArray array];
        for (int i=0; i<self.countOfIndicator; i++) {
            [_powers addObject:[NSNumber numberWithFloat:self.minPower]];
        }
    }
    return _powers;
}

- (void)setMinPower:(CGFloat)minPower{
    _minPower = minPower<0? 0:minPower;
}

- (void)setViewFrame:(CGRect)viewFrame{
    _viewFrame = viewFrame;
    self.frame = viewFrame;
}

@end
