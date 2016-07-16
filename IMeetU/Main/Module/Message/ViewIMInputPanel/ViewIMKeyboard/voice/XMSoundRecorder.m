//
//  ChatSoundRecorder.m
//  TIMChat
//
//  Created by AlexiChen on 16/3/17.
//  Copyright © 2016年 AlexiChen. All rights reserved.
//

#import "XMSoundRecorder.h"


#define kChatRecordMaxDuration 120


@interface XMSoundRecorder()

@property (nonatomic, strong) AVAudioSession    *session;
@property (nonatomic, strong) AVAudioRecorder   *recorder;

@property (nonatomic, copy) NSString            *recordSavePath;
@property (nonatomic, strong) NSTimer           *recorderTimer;
@property (nonatomic, strong) NSTimer           *recorderPeakerTimer;

@property (nonatomic, assign) XMSoundRecorderState recordState;
@end

@implementation XMSoundRecorder

static XMSoundRecorder *_sharedInstance = nil;

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc ] init];
        
    });
    
    return _sharedInstance;
}

+ (void)destory
{
    [_sharedInstance stopRecord];
    _sharedInstance.recorder = nil;
}

- (instancetype)init
{
    if (self = [super init])
    {
        _recordPeak = 1;
        _recordDuration = 0;
        [self activeAudioSession];
    }
    return self;
}

- (void)dealloc
{
    AVAudioSession *aSession = [AVAudioSession sharedInstance];
    [aSession setCategory:_audioSesstionCategory withOptions:_audioSesstionCategoryOptions error:nil];
    [aSession setMode:_audioSesstionMode error:nil];
}

// 开启始终以扬声器模式播放声音
- (void)activeAudioSession
{
    self.session = [AVAudioSession sharedInstance];
    NSError *sessionError = nil;
    [self.session setCategory:AVAudioSessionCategoryPlayAndRecord error:&sessionError];
    
    _audioSesstionCategory = [self.session category];
    _audioSesstionMode = [self.session mode];
    _audioSesstionCategoryOptions = [self.session categoryOptions];
    
    
    UInt32 audioRouteOverride = kAudioSessionOverrideAudioRoute_Speaker;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"    
    AudioSessionSetProperty (kAudioSessionProperty_OverrideAudioRoute, sizeof(audioRouteOverride),  &audioRouteOverride);
    #pragma clang diagnostic pop
    if(!self.session)
    {
        
    }
    else
    {
        [self.session setActive:YES error:nil];
    }
}

- (BOOL)initRecord
{
    //录音设置
    NSMutableDictionary *recordSetting = [[NSMutableDictionary alloc]init];
    //设置录音格式  AVFormatIDKey==kAudioFormatLinearPCM
    [recordSetting setValue:[NSNumber numberWithInt:kAudioFormatMPEG4AAC] forKey:AVFormatIDKey];
    //设置录音采样率(Hz) 如：AVSampleRateKey==8000/44100/96000（影响音频的质量）
    [recordSetting setValue:[NSNumber numberWithFloat:44100] forKey:AVSampleRateKey];
    //录音通道数  1 或 2
    [recordSetting setValue:[NSNumber numberWithInt:1] forKey:AVNumberOfChannelsKey];
    //线性采样位数  8、16、24、32
    [recordSetting setValue:[NSNumber numberWithInt:16] forKey:AVLinearPCMBitDepthKey];
    //录音的质量
    [recordSetting setValue:[NSNumber numberWithInt:AVAudioQualityHigh] forKey:AVEncoderAudioQualityKey];
    
    
    NSString *strUrl = [NSString stringWithFormat:@"%@/%@.mp4", [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject], @"test"];
    NSURL *url = [NSURL fileURLWithPath:strUrl];
    
    self.recordSavePath = strUrl;
    //    self.audioRecord.filePath = strUrl;
    
    NSError *error = nil;
    //初始化
    _recorder = [[AVAudioRecorder alloc] initWithURL:url settings:recordSetting error:&error];
    //开启音量检测
    self.recorder.meteringEnabled = YES;
    
    if ([self.recorder prepareToRecord])
    {
        return YES;
    }
    
    return NO;
}

- (void)startRecord
{
    // 获取麦克风权限
    AVAudioSession *avSession = [AVAudioSession sharedInstance];
    if ([avSession respondsToSelector:@selector(requestRecordPermission:)])
    {
        [avSession requestRecordPermission:^(BOOL available) {
            dispatch_async(dispatch_get_main_queue(), ^{
                BOOL start = NO;
                
                if (available){
                    [self startRecording];
                    start = YES;
                }
                
                if (self.delegateRecorder) {
                    if ([self.delegateRecorder respondsToSelector:@selector(xmSoundRecorder:start:)]) {
                        [self.delegateRecorder xmSoundRecorder:self start:start];
                    }
                }
            });
        }];
    }
}

- (BOOL)startRecording
{
    
    [self.recorder stop];
    if (![self initRecord])
    {
        return NO;
    }
    
    [self.recorder record];
    
    
    self.recordPeak = 1;
    self.recordDuration = 0;
    self.recordState = XMSoundRecorder_Recoring;
    
    _recorderTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(onRecording) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_recorderTimer forMode:NSRunLoopCommonModes];
    
    _recorderPeakerTimer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(onRecordPeak) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_recorderPeakerTimer forMode:NSRunLoopCommonModes];
    
    return YES;
}

- (void)onRecordPeak
{
    [_recorder updateMeters];
    
    float peakPower = 0;
    peakPower = [_recorder peakPowerForChannel:0];
    
    //校准功率值 0~160
    peakPower = pow(10, (0.05 * peakPower));
    
    float power = (NSInteger)((peakPower * 100)/10 + 1);
    power = power<1? 1:power;
    power = power>10? 10:power;
    
    if (self.delegateRecorder) {
        if ([self.delegateRecorder respondsToSelector:@selector(xmSoundRecorder:power:)]) {
            [self.delegateRecorder xmSoundRecorder:self power:power];
        }
    }
}

- (void)onRecording
{
    _recordDuration++;
    
    //回调
    if (self.delegateRecorder) {
        if ([self.delegateRecorder respondsToSelector:@selector(xmSoundRecorder:duration:)]) {
            [self.delegateRecorder xmSoundRecorder:self duration:(int)_recordDuration];
        }
    }
    
    //录音超时
    if (_recordDuration == kChatRecordMaxDuration)
    {
        [_recorderTimer invalidate];
        _recorderTimer = nil;
        
        [_recorderPeakerTimer invalidate];
        _recorderPeakerTimer = nil;
        
        NSTimeInterval duration = self.recorder.currentTime;
        
        [self.recorder stop];
        NSData *audioData = [NSData dataWithContentsOfFile:self.recordSavePath];
        int dur = (int)(duration + 0.5);
        
        if (self.delegateRecorder) {
            if ([self.delegateRecorder respondsToSelector:@selector(xmSoundRecorder:outtimeWithDuration:audio:)]) {
                [self.delegateRecorder xmSoundRecorder:self outtimeWithDuration:dur audio:audioData];
            }
        }
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:self.recorder.url.path]){
            if (!self.recorder.recording){
                [self.recorder deleteRecording];
            }
        }
    }
}

- (NSData*)stopRecord
{
    
    [_recorderTimer invalidate];
    _recorderTimer = nil;
    
    [_recorderPeakerTimer invalidate];
    _recorderPeakerTimer = nil;
    
    [self.recorder stop];
    NSData *audioData = [NSData dataWithContentsOfFile:self.recordSavePath];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:self.recorder.url.path]){
        if (!self.recorder.recording){
            [self.recorder deleteRecording];
        }
    }
    
    return audioData;
}


//==========================================
@end


@interface XMSoundPlayer ()<AVAudioPlayerDelegate>

@property (nonatomic, strong) AVAudioPlayer *soundPlayer;
@property (nonatomic, strong) NSTimer *timerPlaying;

@end

@implementation XMSoundPlayer

static XMSoundPlayer *_sharedPlayer = nil;

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedPlayer = [[XMSoundPlayer alloc ] init];
        
    });
    
    return _sharedPlayer;
}

+ (void)destory
{
    [_sharedPlayer stopPlay];
    _sharedPlayer.soundPlayer = nil;
}


- (void)playWith:(NSData *)data{
    
    NSError *playerError = nil;
    _soundPlayer = [[AVAudioPlayer alloc] initWithData:data error:&playerError];
    _soundPlayer.meteringEnabled = YES;
    
    if (_soundPlayer)
    {
        _soundPlayer.delegate = self;
        BOOL resPrepare = [_soundPlayer prepareToPlay];
        if (resPrepare) {
            BOOL resPlay = [_soundPlayer play];
            if (self.delegatePlayer) {
                if ([self.delegatePlayer respondsToSelector:@selector(xmSoundPlayer:start:)]) {
                    [self.delegatePlayer xmSoundPlayer:self start:resPlay];
                }
            }
            
            if (resPlay){
                self.timerPlaying = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(playing:) userInfo:nil repeats:YES];
            }
        }else{
            //播放声音失败
            if (self.delegatePlayer) {
                if ([self.delegatePlayer respondsToSelector:@selector(xmSoundPlayer:start:)]) {
                    [self.delegatePlayer xmSoundPlayer:self start:resPrepare];
                }
            }
        }
    }
    else
    {
        [self playCompletion:NO];
    }
    
}

- (void)playing:(id)sender{
    if (self.delegatePlayer) {
        if ([self.delegatePlayer respondsToSelector:@selector(xmSoundPlayer:power:)]) {
            
            [self.soundPlayer updateMeters];
            
            float peakPower = 0;
            peakPower = [self.soundPlayer peakPowerForChannel:0];
            
            //校准功率值 0~160
            peakPower = pow(10, (0.05 * peakPower));
            
            float power = (NSInteger)((peakPower * 100)/10 + 1);
            power = power<1? 1:power;
            power = power>10? 10:power;
            
            [self.delegatePlayer xmSoundPlayer:self power:power];
        }
    }
}

- (void)playCompletion:(BOOL)completion{
    [self.timerPlaying invalidate];
    self.timerPlaying = nil;
    if (self.delegatePlayer) {
        if ([self.delegatePlayer respondsToSelector:@selector(xmSoundPlayer:completion:)]) {
            [self.delegatePlayer xmSoundPlayer:self completion:completion];
        }
    }
    
    self.delegatePlayer = nil;
}

- (void)stopPlay
{
    [self playCompletion:YES];
    
    
    if (_soundPlayer)
    {
        if (_soundPlayer.isPlaying)
        {
            [_soundPlayer stop];
        }
        
        _soundPlayer.delegate = nil;
        _soundPlayer = nil;
    }
    
}

#pragma mark - AVAudioPlayerDelegate
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    [self playCompletion:flag];
}

- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError * __nullable)error
{
    [self playCompletion:NO];
}


@end
