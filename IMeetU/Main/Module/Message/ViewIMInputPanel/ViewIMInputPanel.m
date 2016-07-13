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

@interface ViewIMInputPanel()

@property (weak, nonatomic) IBOutlet UIButton *btnVoice;
@property (weak, nonatomic) IBOutlet UIButton *btnEmoji;
@property (weak, nonatomic) IBOutlet UIButton *btnMore;

@property (weak, nonatomic) IBOutlet YYTextView *yyTextViewContent;

@property (nonatomic, assign) CGFloat viewHeight;
@property (nonatomic, assign) CGFloat viewFrameHeight;
@property (nonatomic, assign) CGFloat inputViewHeight;
@property (nonatomic, assign) CGFloat keyBoardViewHeight;

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

- (void)awakeFromNib{
    self.inputViewHeight = 80;
    
    [self addSubview:self.inputViewIMVoice];
    [self addSubview:self.inputViewIMEmoji];
    [self addSubview:self.inputViewIMMore];
    self.inputViewIMVoice.hidden = YES;
    self.inputViewIMEmoji.hidden = YES;
    self.inputViewIMMore.hidden = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    self.yyTextViewContent.layer.borderWidth = 0.5;
    self.yyTextViewContent.layer.borderColor = [UIColor colorWithHexString:@"CCCCCC"].CGColor;
    self.yyTextViewContent.layer.cornerRadius = 5;
    self.yyTextViewContent.layer.masksToBounds = YES;
    
    //self.yyTextViewContent.textParser
    [IMEmojiHelper emojiDicArray];
    [IMEmojiHelper emojiImgGIFWithEmojiKey:@"[打呼噜]"];
}

- (IBAction)onTouchUpInsideBtnVoice:(UIButton*)sender {
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
                self.frame = CGRectMake(0, [UIScreen screenHeight]-self.inputViewHeight-self.keyBoardViewHeight, [UIScreen screenWidth], self.viewFrameHeight);
            }];
        }
    }else{
        [self.yyTextViewContent becomeFirstResponder];
    }
    
    self.btnEmoji.selected = NO;
    self.btnMore.selected = NO;
}

- (IBAction)onTouchUpInsideBtnEmoji:(UIButton*)sender {
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
                self.frame = CGRectMake(0, [UIScreen screenHeight]-self.inputViewHeight-self.keyBoardViewHeight, [UIScreen screenWidth], self.viewFrameHeight);
            }];
        }
    }else{
        [self.yyTextViewContent becomeFirstResponder];
    }
    
    self.btnVoice.selected = NO;
    self.btnMore.selected = NO;
    
}

- (IBAction)onTouchUpInsideBtnMore:(UIButton*)sender {
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
    }else{
        [UIView animateWithDuration:0.25 animations:^{
            self.frame = CGRectMake(0, [UIScreen screenHeight]-self.inputViewHeight, [UIScreen screenWidth], self.viewFrameHeight);
        }];
    }
}

#pragma mark 键盘弹出
- (void)keyboardWillShow:(NSNotification*)notification{
    float duration = [[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    float keyboardHeight = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    [UIView animateWithDuration:duration animations:^{
        self.frame = CGRectMake(0, [UIScreen screenHeight]-keyboardHeight-self.inputViewHeight, [UIScreen screenWidth], self.viewFrameHeight);
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
            self.frame = CGRectMake(0, [UIScreen screenHeight]-self.inputViewHeight-self.keyBoardViewHeight, [UIScreen screenWidth], self.viewFrameHeight);
        }else{
            self.frame = CGRectMake(0, [UIScreen screenHeight]-self.inputViewHeight, [UIScreen screenWidth], self.viewFrameHeight);
        }
        self.isNotCloseWhenKeyboardClose = NO;
    }];
}

#pragma mark 移除键盘通知
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma make - 视图尺寸相关属性
- (void)initFrame{
    self.frame = CGRectMake(0, [UIScreen screenHeight]-self.inputViewHeight, [UIScreen screenWidth], self.viewFrameHeight);
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
