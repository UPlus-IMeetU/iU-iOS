//
//  ViewIMInputPanel.h
//  IMTest
//
//  Created by zhanghao on 16/7/1.
//  Copyright © 2016年 zhanghao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <YYKit/YYKit.h>

@protocol ViewIMInputPanelDelegate;

@interface ViewIMInputPanel : UIView

+ (instancetype)viewIMInputPanelWithSuperController:(UIViewController*)controller delegate:(id<ViewIMInputPanelDelegate>)delegate;

- (void)initFrame;
- (void)initial;

- (CGFloat)viewHeight;
- (CGFloat)inputViewHeight;

- (void)closeKeyboard;

@end
@protocol ViewIMInputPanelDelegate <NSObject>
@optional
- (void)viewIMInputPanel:(ViewIMInputPanel*)view sendTxt:(NSString*)txt;

- (void)viewIMInputPanel:(ViewIMInputPanel*)view sendVoice:(NSData*)voice;

- (void)viewIMInputPanel:(ViewIMInputPanel*)view sendImg:(UIImage*)img;
@end
