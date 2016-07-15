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

@property (nonatomic, weak) id<ViewIMInputPanelDelegate> delegateInputPanel;

@property (weak, nonatomic) UIButton *btnVoice;
@property (weak, nonatomic) UIButton *btnEmoji;
@property (weak, nonatomic) UIButton *btnMore;

@property (weak, nonatomic) UIView *viewKeyboardWrap;

@property (nonatomic, weak) UIView *textViewContentWrap;
@property (weak, nonatomic) YYTextView *yyTextViewContent;

@property (weak, nonatomic) NSLayoutConstraint *constraintViewInputViewHeight;
@property (weak, nonatomic) NSLayoutConstraint *constarintViewIMInputPanelMarginBottom;

+ (instancetype)viewIMInputPanel;

- (void)initFrame;
- (void)initial;

- (CGFloat)viewHeight;
- (CGFloat)inputViewHeight;

- (void)closeKeyboard;

@end
@protocol ViewIMInputPanelDelegate <NSObject>
@optional
- (void)viewIMInputPanel:(ViewIMInputPanel*)view sendTxt:(NSString*)txt;

@end
