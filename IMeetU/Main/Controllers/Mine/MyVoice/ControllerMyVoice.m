//
//  ControllerMyVoice.m
//  IMeetU
//
//  Created by Spring on 16/7/13.
//  Copyright © 2016年 zhanghao. All rights reserved.
//

#import "ControllerMyVoice.h"
#import <AVFoundation/AVFoundation.h>
@interface ControllerMyVoice ()<AVAudioPlayerDelegate>
{
    //录音器
    AVAudioRecorder *recorder;
    //播放器
    AVAudioPlayer *player;
    NSDictionary *recorderSettingsDict;
    
    //定时器
    NSTimer *timer;
    double lowPassResults;
    
    //录音名字
    NSString *playName;
    NSInteger recordTime;
    NSInteger playTime;
    
}

@property (weak, nonatomic) IBOutlet UILabel *playTimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UIButton *recordButton;
@property (weak, nonatomic) IBOutlet UILabel *recordTimeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *voiceBg;
@end

@implementation ControllerMyVoice

- (void)viewDidLoad {
    [super viewDidLoad];
    [super viewDidLoad];
    
    if ([[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending)
    {
        //7.0第一次运行会提示，是否允许使用麦克风
        AVAudioSession *session = [AVAudioSession sharedInstance];
        NSError *sessionError;
        //AVAudioSessionCategoryPlayAndRecord用于录音和播放
        [session setCategory:AVAudioSessionCategoryPlayAndRecord error:&sessionError];
        if(session == nil)
            NSLog(@"Error creating session: %@", [sessionError description]);
        else
            [session setActive:YES error:nil];
    }
    
    [_recordButton setImage:[UIImage imageNamed:@"mine_me_down_sound_record_btn_clk"] forState:UIControlStateHighlighted];
    _voiceBg.hidden = YES;
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    playName = [NSString stringWithFormat:@"%@/play.aac",docDir];
    //录音设置
    recorderSettingsDict =[[NSDictionary alloc] initWithObjectsAndKeys:
                           [NSNumber numberWithInt:kAudioFormatMPEG4AAC],AVFormatIDKey,
                           [NSNumber numberWithInt:1000.0],AVSampleRateKey,
                           [NSNumber numberWithInt:2],AVNumberOfChannelsKey,
                           [NSNumber numberWithInt:8],AVLinearPCMBitDepthKey,
                           [NSNumber numberWithBool:NO],AVLinearPCMIsBigEndianKey,
                           [NSNumber numberWithBool:NO],AVLinearPCMIsFloatKey,
                           nil];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)playMyVoice:(id)sender {
    NSError *playerError;
   
    playTime = recordTime;
    if (playTime <= 0) {
        return;
    }
    [self.playButton setImage:[UIImage imageNamed:@"mine_me_up_stop_btn"] forState:UIControlStateNormal];
    self.playButton.userInteractionEnabled = NO;
    //启动定时器
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(playTime:) userInfo:nil repeats:YES];
    //播放
    player = nil;
    player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL URLWithString:playName] error:&playerError];
    player.delegate = self;
    if (player == nil)
    {
        NSLog(@"ERror creating player: %@", [playerError description]);
    }else{
        [player play];
    }
    
}

- (void)playTime:(id)sender{
    playTime--;
    _playTimeLabel.text = [NSString stringWithFormat:@"%ldS",playTime];
    if (playTime == 0) {
        [timer invalidate];
        timer = nil;
    }
}

#pragma mark AVPlayerDelegate
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    if (flag) {
        [self.playButton setImage:[UIImage imageNamed:@"mine_me_up_play_btn"] forState:UIControlStateNormal];
        self.playButton.userInteractionEnabled = YES;
         _playTimeLabel.text = [NSString stringWithFormat:@"%ldS",recordTime];
    }
}

- (IBAction)recordMyVoiceBegin:(id)sender {
    recordTime = 0;
    _voiceBg.hidden = NO;
    _recordTimeLabel.text = @"00:00";
    //如果正在播放音乐暂停音乐并且归零
    if (player.isPlaying) {
        [timer invalidate];
        timer = nil;
        [player stop];
        [self.playButton setImage:[UIImage imageNamed:@"mine_me_up_play_btn"] forState:UIControlStateNormal];
        self.playButton.userInteractionEnabled = YES;
        _playTimeLabel.text = @"0S";
    }
    
    
  
    if ([self canRecord]) {
        
        NSError *error = nil;
        //必须真机上测试,模拟器上可能会崩溃
        recorder = [[AVAudioRecorder alloc] initWithURL:[NSURL URLWithString:playName] settings:recorderSettingsDict error:&error];
        
        if (recorder) {
            recorder.meteringEnabled = YES;
            [recorder prepareToRecord];
            [recorder record];
            
            //启动定时器
            timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(recordTime:) userInfo:nil repeats:YES];
            
        } else
        {
            int errorCode = CFSwapInt32HostToBig ([error code]);
            NSLog(@"Error: %@ [%4.4s])" , [error localizedDescription], (char*)&errorCode);
            
        }
        
    }
}

- (void)recordTime:(id)sender{
    recordTime++;
    if (recordTime < 10) {
        _recordTimeLabel.text = [NSString stringWithFormat:@"00:0%ld",(long)recordTime];
    }else if(recordTime >= 10 && recordTime < 60){
        _recordTimeLabel.text = [NSString stringWithFormat:@"00:%ld",(long)recordTime];
    }else if(recordTime >= 60 && recordTime< 70){
        _recordTimeLabel.text = [NSString stringWithFormat:@"01:0%ld",(long)(recordTime - 60)];
    }else if(recordTime >= 70 && recordTime <= 90){
        _recordTimeLabel.text = [NSString stringWithFormat:@"01:%ld",(long)(recordTime - 60)];
    }else{
        [self recordEnd];
    }
    if (recordTime % 2 == 1) {
        [UIView animateWithDuration:1 animations:^{
            self.voiceBg.alpha = 0.5;
        }];
    }else{
        [UIView animateWithDuration:1 animations:^{
            self.voiceBg.alpha = 1;
        }];
    }
}

- (IBAction)recordMyVoiceEnd:(id)sender {
    [self recordEnd];
}


- (void)recordEnd{
    _playTimeLabel.text = [NSString stringWithFormat:@"%ldS",recordTime];
    _recordTimeLabel.text = @"录音最长90S";
    _voiceBg.hidden = YES;
    [recorder stop];
    recorder = nil;
    //结束定时器
    [timer invalidate];
    timer = nil;
}


//判断是否允许使用麦克风7.0新增的方法requestRecordPermission
-(BOOL)canRecord
{
    __block BOOL bCanRecord = YES;
    if ([[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending)
    {
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        if ([audioSession respondsToSelector:@selector(requestRecordPermission:)]) {
            [audioSession performSelector:@selector(requestRecordPermission:) withObject:^(BOOL granted) {
                if (granted) {
                    bCanRecord = YES;
                }
                else {
                    bCanRecord = NO;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [[[UIAlertView alloc] initWithTitle:nil
                                                    message:@"app需要访问您的麦克风。\n请启用麦克风-设置/隐私/麦克风"
                                                   delegate:nil
                                          cancelButtonTitle:@"关闭"
                                          otherButtonTitles:nil] show];
                    });
                }
            }];
        }
    }
    
    return bCanRecord;
}



/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
