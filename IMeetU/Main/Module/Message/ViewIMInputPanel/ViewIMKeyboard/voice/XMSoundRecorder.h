//
//  ChatSoundRecorder.h
//  TIMChat
//
//  Created by AlexiChen on 16/3/17.
//  Copyright © 2016年 AlexiChen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
typedef void(^ChatSoundPlayCompletion)();

typedef void(^CommonVoidBlock)();

typedef NS_ENUM(NSInteger, XMSoundRecorderState)
{
    XMSoundRecorder_Stoped,
    XMSoundRecorder_Recoring,
    XMSoundRecorder_RelaseCancel,
    XMSoundRecorder_Countdown,
    XMSoundRecorder_MaxRecord,
    XMSoundRecorder_TooShort,
};

@protocol XMSoundRecorderDelegate;
@protocol XMSoundPlayerDelegate;

@interface XMSoundRecorder : NSObject
{
@protected
    // 录音相关
    XMSoundRecorderState           _recordState;
    CGFloat                     _recordPeak;
    NSInteger                   _recordDuration;
    
    // 用于音频退出直播时还原现场
    NSString                        *_audioSesstionCategory;    // 进入房间时的音频类别
    NSString                        *_audioSesstionMode;        // 进入房间时的音频模式
    AVAudioSessionCategoryOptions   _audioSesstionCategoryOptions;       // 进入房间时的音频类别选项
}

@property (nonatomic, weak) id<XMSoundRecorderDelegate> delegateRecorder;
@property (nonatomic, assign) CGFloat           recordPeak;
@property (nonatomic, assign) NSInteger         recordDuration;


+ (instancetype)sharedInstance;

+ (void)destory;

- (void)startRecord;
- (NSData*)stopRecord;

@end
@protocol XMSoundRecorderDelegate <NSObject>
@optional
//是否成功开始录音
- (void)xmSoundRecorder:(XMSoundRecorder*)recorder start:(BOOL)start;
//录音每秒回调
- (void)xmSoundRecorder:(XMSoundRecorder*)recorder duration:(int)duration;
//录音功率回调
- (void)xmSoundRecorder:(XMSoundRecorder*)recorder power:(float)power;
//录音超时回调
- (void)xmSoundRecorder:(XMSoundRecorder*)recorder outtimeWithDuration:(int)duration audio:(NSData*)audio;
@end

@interface XMSoundPlayer : NSObject

@property (nonatomic, weak) id<XMSoundPlayerDelegate> delegatePlayer;

+ (instancetype)sharedInstance;
+ (void)destory;

- (void)playWith:(NSData *)data;
- (void)stopPlay;

@end
@protocol XMSoundPlayerDelegate <NSObject>

- (void)xmSoundPlayer:(XMSoundPlayer*)player start:(BOOL)start;
- (void)xmSoundPlayer:(XMSoundPlayer*)player power:(float)power;
- (void)xmSoundPlayer:(XMSoundPlayer*)player completion:(BOOL)completion;

@end