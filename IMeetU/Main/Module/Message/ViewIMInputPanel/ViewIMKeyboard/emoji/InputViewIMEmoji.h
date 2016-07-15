//
//  InputViewIMEmoji.h
//  IMTest
//
//  Created by zhanghao on 16/7/1.
//  Copyright © 2016年 zhanghao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InputViewIM.h"

@protocol InputViewIMEmojiDelegate;

@interface InputViewIMEmoji : InputViewIM

@property (nonatomic, weak) id<InputViewIMEmojiDelegate> delegateInputView;

@end
@protocol InputViewIMEmojiDelegate <NSObject>
@optional
/**
 * 选中表情字符
 */
- (void)inputViewIMEmoji:(InputViewIMEmoji*)view emojiStr:(NSString*)emojiStr;
/**
 * 删除表情字符
 */
- (void)inputViewIMEmojiDeleteEmoji:(InputViewIMEmoji*)view;
/**
 * 点击发送按钮
 */
- (void)inputViewIMEmojiSendEmoji:(InputViewIMEmoji*)view;

@end