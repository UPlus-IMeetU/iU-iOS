//
//  InputViewIMVoice.h
//  IMTest
//
//  Created by zhanghao on 16/7/1.
//  Copyright © 2016年 zhanghao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InputViewIM.h"

typedef NS_ENUM(NSInteger ,IMRecorderOperation) {
    IMRecorderOperationSend,
    IMRecorderOperationReview,
    IMRecorderOperationDelete
};

@protocol InputViewIMVoiceDelegate;

@interface InputViewIMVoice : InputViewIM

@property (nonatomic, weak) id<InputViewIMVoiceDelegate> delegateKeyboard;

@end
@protocol InputViewIMVoiceDelegate <NSObject>
- (void)inputViewIMVoice:(InputViewIMVoice*)view voice:(NSData*)voice;

@end