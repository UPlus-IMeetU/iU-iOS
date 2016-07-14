//
//  ViewIMInputPanel.m
//  IMTest
//
//  Created by zhanghao on 16/7/1.
//  Copyright © 2016年 zhanghao. All rights reserved.
//

#import "ViewIMInputPanel.h"

#import "UINib+Plug.h"
#import "UIScreen+Plug.h"

#import "InputViewIMVoice.h"
#import "InputViewIMEmoji.h"
#import "InputViewIMMore.h"

#import <YYKit/YYKit.h>

#import "IMEmojiHelper.h"
#import "TextParserIMInputPanel.h"

@interface ViewIMInputPanel()<InputViewIMEmojiDelegate, YYTextViewDelegate>

@property (nonatomic, assign) CGFloat viewHeight;
@property (nonatomic, assign) CGFloat viewFrameHeight;
@property (nonatomic, assign) CGFloat inputViewHeight;
@property (nonatomic, assign) CGFloat keyBoardViewHeight;
@property (nonatomic, assign) CGFloat keyBoardViewHeightSys;

@property (nonatomic, strong) InputViewIMVoice *inputViewIMVoice;
@property (nonatomic, strong) InputViewIMEmoji *inputViewIMEmoji;
@property (nonatomic, strong) InputViewIMMore *inputViewIMMore;

//值为YES时，当键盘关闭时，不关闭输入面板
@property (nonatomic, assign) BOOL isNotCloseWhenKeyboardClose;
@end
@implementation ViewIMInputPanel

+ (instancetype)viewIMInputPanel{
    ViewIMInputPanel *view = [UINib xmViewWithName:@"ViewIMInputPanel" class:[ViewIMInputPanel class]];
    
    return view;
}

- (void)initial{
    self.inputViewHeight = 75;
    
    [self.viewKeyboardWrap addSubview:self.inputViewIMVoice];
    
    self.inputViewIMEmoji.delegateInputView = self;
    [self.viewKeyboardWrap addSubview:self.inputViewIMEmoji];
    self.inputViewIMEmoji.frame = CGRectMake(0, 0, [UIScreen screenWidth], 220);
    
    //[self.viewKeyboardWrap addSubview:self.inputViewIMMore];
    
    self.inputViewIMVoice.hidden = YES;
    self.inputViewIMEmoji.hidden = YES;
    self.inputViewIMMore.hidden = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    self.textViewContentWrap.layer.borderWidth = 0.5;
    self.textViewContentWrap.layer.borderColor = [UIColor colorWithHexString:@"CCCCCC"].CGColor;
    self.textViewContentWrap.layer.cornerRadius = 5;
    self.textViewContentWrap.layer.masksToBounds = YES;
    
    self.yyTextViewContent.textParser = [[TextParserIMInputPanel alloc] init];
    self.yyTextViewContent.returnKeyType = UIReturnKeySend;
    self.yyTextViewContent.delegate = self;
    
    [self.btnEmoji addTarget:self action:@selector(onTouchUpInsideBtnEmoji:) forControlEvents:UIControlEventTouchUpInside];
    [self.btnVoice addTarget:self action:@selector(onTouchUpInsideBtnVoice:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)onTouchUpInsideBtnVoice:(UIButton*)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        self.inputViewIMVoice.hidden = NO;
        self.inputViewIMEmoji.hidden = YES;
        self.inputViewIMMore.hidden = YES;
        
        if ([self.yyTextViewContent isFirstResponder]) {
            self.isNotCloseWhenKeyboardClose = YES;
            [self.yyTextViewContent resignFirstResponder];
        }else{
            [UIView animateWithDuration:0.25 animations:^{
                self.constarintViewIMInputPanelMarginBottom.constant = 0;
                [self layoutIfNeeded];
            }];
        }
    }else{
        [self.yyTextViewContent becomeFirstResponder];
    }
    
    self.btnEmoji.selected = NO;
    self.btnMore.selected = NO;
}

- (void)onTouchUpInsideBtnEmoji:(UIButton*)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        self.inputViewIMVoice.hidden = YES;
        self.inputViewIMEmoji.hidden = NO;
        self.inputViewIMMore.hidden = YES;
        
        if ([self.yyTextViewContent isFirstResponder]) {
            self.isNotCloseWhenKeyboardClose = YES;
            [self.yyTextViewContent resignFirstResponder];
        }else{
            [UIView animateWithDuration:0.25 animations:^{
                self.constarintViewIMInputPanelMarginBottom.constant = 0;
                [self layoutIfNeeded];
            }];
        }
    }else{
        [self.yyTextViewContent becomeFirstResponder];
    }
    
    self.btnVoice.selected = NO;
    self.btnMore.selected = NO;
}

- (void)onTouchUpInsideBtnMore:(UIButton*)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        self.inputViewIMVoice.hidden = YES;
        self.inputViewIMEmoji.hidden = YES;
        self.inputViewIMMore.hidden = NO;
        
        if ([self.yyTextViewContent isFirstResponder]) {
            self.isNotCloseWhenKeyboardClose = YES;
            [self.yyTextViewContent resignFirstResponder];
        }else{
            [UIView animateWithDuration:0.25 animations:^{
                self.frame = CGRectMake(0, [UIScreen screenHeight]-self.inputViewHeight-self.keyBoardViewHeight, [UIScreen screenWidth], self.viewFrameHeight);
            }];
        }
        
        [self refreshFrame];
    }else{
        [self.yyTextViewContent becomeFirstResponder];
    }
    
    self.btnVoice.selected = NO;
    self.btnEmoji.selected = NO;
}

#pragma mark - 键盘相关操作
#pragma mark 关闭键盘
- (void)closeKeyboard{
    if ([self.yyTextViewContent isFirstResponder]) {
        [self.yyTextViewContent resignFirstResponder];
        self.isNotCloseWhenKeyboardClose = NO;
    }else{
        [UIView animateWithDuration:0.5 animations:^{
            self.constarintViewIMInputPanelMarginBottom.constant = -self.keyBoardViewHeight;
        }];
    }
}

#pragma mark 键盘弹出
- (void)keyboardWillShow:(NSNotification*)notification{
    float duration = [[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    self.keyBoardViewHeightSys = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    [UIView animateWithDuration:duration animations:^{
        self.constarintViewIMInputPanelMarginBottom.constant = self.keyBoardViewHeightSys - self.keyBoardViewHeight;
        [self layoutIfNeeded];
    }];
    
    self.btnVoice.selected = NO;
    self.btnEmoji.selected = NO;
    self.btnMore.selected = NO;
}

#pragma mark 键盘关闭
- (void)keyboardWillHide:(NSNotification*)notification{
    float duration = [[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    [UIView animateWithDuration:duration animations:^{
        if (self.isNotCloseWhenKeyboardClose) {
            self.constarintViewIMInputPanelMarginBottom.constant = 0;
        }else{
            self.constarintViewIMInputPanelMarginBottom.constant = -self.keyBoardViewHeight;
        }
        [self layoutIfNeeded];
        self.isNotCloseWhenKeyboardClose = NO;
    }];
}

#pragma mark 移除键盘通知
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma make - 视图尺寸相关属性
- (void)initFrame{
    self.inputViewIMEmoji.frame = CGRectMake(0, 0, [UIScreen screenWidth], 220);
    self.inputViewIMVoice.frame = CGRectMake(0, 0, [UIScreen screenWidth], 220);
}

- (CGFloat)viewHeight{
    return self.inputViewHeight + self.keyBoardViewHeight;
}

- (CGFloat)viewFrameHeight{
    return self.viewHeight + 200;
}

- (CGFloat)keyBoardViewHeight{
    return 220;
}

#pragma mark - 表情键盘回调
//选中表情字符
- (void)inputViewIMEmoji:(InputViewIMEmoji *)view emojiStr:(NSString *)emojiStr{
    [self.yyTextViewContent replaceRange:self.yyTextViewContent.selectedTextRange withText:emojiStr];
}
//删除表情字符
- (void)inputViewIMEmojiDeleteEmoji:(InputViewIMEmoji *)view{
    [self.yyTextViewContent deleteBackward];
}
//点击发送按钮
- (void)inputViewIMEmojiSendEmoji:(InputViewIMEmoji *)view{
    if (self.delegateInputPanel) {
        if ([self.delegateInputPanel respondsToSelector:@selector(viewIMInputPanel:sendTxt:)]) {
            [self.delegateInputPanel viewIMInputPanel:self sendTxt:self.yyTextViewContent.text];
        }
    }
}

#pragma mark - YYTextView代理
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        if ([[self.yyTextViewContent.text stringByTrim] isEqualToString:@""] || !self.yyTextViewContent.text) {
            return NO;
        }
        //点击确定按钮了
        if (self.delegateInputPanel) {
            if ([self.delegateInputPanel respondsToSelector:@selector(viewIMInputPanel:sendTxt:)]) {
                [self.delegateInputPanel viewIMInputPanel:self sendTxt:self.yyTextViewContent.text];
            }
        }
        
        return NO;
    }
    
    //刷新输入板frame
    [self refreshFrame];
    
    return YES;
}

- (void)refreshFrame{
    
    CGFloat height = [self.yyTextViewContent sizeThatFits:CGSizeMake([UIScreen screenWidth]-20, CGFLOAT_MAX)].height;
    height = height < 24?24:height;
    height = height > 90?90:height;
    
    self.constraintViewInputViewHeight.constant = 220+height+51;
    [self layoutIfNeeded];
}

#pragma mark - 懒加载键盘视图
- (InputViewIMVoice *)inputViewIMVoice{
    if (!_inputViewIMVoice) {
        _inputViewIMVoice = [InputViewIMVoice inputViewWithHeight:self.keyBoardViewHeight];
    }
    return _inputViewIMVoice;
}

- (InputViewIMEmoji *)inputViewIMEmoji{
    if (!_inputViewIMEmoji) {
        _inputViewIMEmoji = [InputViewIMEmoji inputViewWithHeight:self.keyBoardViewHeight];
    }
    return _inputViewIMEmoji;
}

- (InputViewIMMore *)inputViewIMMore{
    if (!_inputViewIMMore) {
        _inputViewIMMore = [InputViewIMMore inputViewWithHeight:self.keyBoardViewHeight];
    }
    return _inputViewIMMore;
}

@end
