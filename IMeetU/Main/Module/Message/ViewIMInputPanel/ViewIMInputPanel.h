//
//  ViewIMInputPanel.h
//  IMTest
//
//  Created by zhanghao on 16/7/1.
//  Copyright © 2016年 zhanghao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewIMInputPanel : UIView

+ (instancetype)viewIMInputPanel;

- (void)initFrame;

- (CGFloat)viewHeight;
- (CGFloat)inputViewHeight;

- (void)closeKeyboard;

@end
