//
//  InputViewIMVoice.m
//  IMTest
//
//  Created by zhanghao on 16/7/1.
//  Copyright © 2016年 zhanghao. All rights reserved.
//

#import "InputViewIMVoice.h"
#import "CATCurveProgressView.h"
#import "XMSoundRecorder.h"
#import "AppDelegate.h"

#import "XMViewVoicePowerIndicator.h"

@interface InputViewIMVoice()<XMSoundRecorderDelegate, XMSoundPlayerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *labelDuration;
@property (weak, nonatomic) IBOutlet UILabel *labelRecorderState;
@property (weak, nonatomic) IBOutlet UIView *viewRecoderState;
@property (weak, nonatomic) IBOutlet UIView *viewRecoderDuration;

@property (weak, nonatomic) IBOutlet UIButton *btnRecorder;
@property (weak, nonatomic) IBOutlet UIButton *btnRecorderReview;
@property (weak, nonatomic) IBOutlet CATCurveProgressView *progressRecorderReview;
@property (weak, nonatomic) IBOutlet UIView *viewReviewWrap;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *actyIndicatorPrepareRecorder;

@property (weak, nonatomic) IBOutlet UIButton *btnRecorderReviewSelected;
@property (weak, nonatomic) IBOutlet UIButton *btnRecorderDeleteSelected;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintBtnRecorderReviewSelectedWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintBtnRecorderDeleteSelectedWidth;


@property (weak, nonatomic) IBOutlet UIView *viewCancelSendWrap;
@property (weak, nonatomic) IBOutlet UIButton *btnCancel;
@property (weak, nonatomic) IBOutlet UIButton *btnSend;

//是否成功打开录音机
@property (nonatomic, assign) BOOL isSuccessOpenRecorder;
//当抬起手指时要完成的动作
@property (nonatomic, assign) IMRecorderOperation recorderOperation;

//录音时间
@property (nonatomic, assign) int recorderSeconds;
@property (nonatomic, strong) NSData *audio;
//录音是否超时
@property (nonatomic, assign) BOOL isRecorderOuttime;

@property (nonatomic, strong) NSTimer *timerPlayer;
@property (nonatomic, assign) int timerPlayerSeconds;

@property (nonatomic, strong) XMViewVoicePowerIndicator *viewVoicePowerIndicatorL;
@property (nonatomic, strong) XMViewVoicePowerIndicator *viewVoicePowerIndicatorR;
@end
@implementation InputViewIMVoice

+ (instancetype)inputViewWithHeight:(CGFloat)height{
    InputViewIMVoice *view = [InputViewIM viewWithNibName:@"InputViewIMVoice" viewClass:[InputViewIMVoice class]];
    
    return view;
}

- (void)awakeFromNib{
    self.btnRecorderReviewSelected.hidden = YES;
    self.btnRecorderDeleteSelected.hidden = YES;
    self.viewReviewWrap.hidden = YES;
    self.viewCancelSendWrap.hidden = YES;
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(testt:)];
    [self.btnRecorder addGestureRecognizer:panGestureRecognizer];
    
    self.viewRecoderDuration.hidden = YES;
    self.viewRecoderState.hidden = NO;
    
    //设置基本参数
    CGSize viewVoicePowerIndicatorSize = CGSizeMake(45, 15);
    CGFloat viewVoicePowerIndicatorItemWidth = 2;
    CGFloat viewVoicePowerIndicatorItemMargin = 2;
    NSInteger viewVoicePowerIndicatorItemCount = 10;
    UIEdgeInsets viewVoicePowerIndicatorEdgeInsets = UIEdgeInsetsMake(0, 2, 0, 2);
    UIColor *viewVoicePowerIndicatorColor = [UIColor redColor];
    CGFloat maxPower = 10;
    CGFloat minPower = 1;
    //创建声音视图
    self.viewVoicePowerIndicatorL = [[XMViewVoicePowerIndicator alloc] init];
    self.viewVoicePowerIndicatorR = [[XMViewVoicePowerIndicator alloc] init];
    //设置frame
    CGFloat marginX = 21;
    CGFloat y = (40-viewVoicePowerIndicatorSize.height)/2;
    self.viewVoicePowerIndicatorL.viewFrame = CGRectMake([UIScreen mainScreen].bounds.size.width/2-marginX-viewVoicePowerIndicatorSize.width, y, viewVoicePowerIndicatorSize.width, viewVoicePowerIndicatorSize.height);
    self.viewVoicePowerIndicatorR.viewFrame = CGRectMake([UIScreen mainScreen].bounds.size.width/2+marginX, y, viewVoicePowerIndicatorSize.width, viewVoicePowerIndicatorSize.height);
    //设置edgeInsets
    self.viewVoicePowerIndicatorL.indicatorEdgeInsets = viewVoicePowerIndicatorEdgeInsets;
    self.viewVoicePowerIndicatorR.indicatorEdgeInsets = viewVoicePowerIndicatorEdgeInsets;
    //设置指示条的个数
    self.viewVoicePowerIndicatorL.countOfIndicator = viewVoicePowerIndicatorItemCount;
    self.viewVoicePowerIndicatorR.countOfIndicator = viewVoicePowerIndicatorItemCount;
    //设置指示条颜色
    self.viewVoicePowerIndicatorL.indicatorColor = viewVoicePowerIndicatorColor;
    self.viewVoicePowerIndicatorR.indicatorColor = viewVoicePowerIndicatorColor;
    //设置指示条最大功率
    self.viewVoicePowerIndicatorL.maxPower = maxPower;
    self.viewVoicePowerIndicatorR.maxPower = maxPower;
    //设置指示条最小功率
    self.viewVoicePowerIndicatorL.minPower = minPower;
    self.viewVoicePowerIndicatorR.minPower = minPower;
    //设置指示条宽度
    self.viewVoicePowerIndicatorL.indicatorItemWidth = viewVoicePowerIndicatorItemWidth;
    self.viewVoicePowerIndicatorR.indicatorItemWidth = viewVoicePowerIndicatorItemWidth;
    //设置指示条之间的间距
    self.viewVoicePowerIndicatorL.indicatorItemMargin = viewVoicePowerIndicatorItemMargin;
    self.viewVoicePowerIndicatorR.indicatorItemMargin = viewVoicePowerIndicatorItemMargin;
    //设置指示器左右方向
    self.viewVoicePowerIndicatorL.indicatorLRDirection = XMViewVoicePowerIndicatorLRDirectionLeft;
    self.viewVoicePowerIndicatorR.indicatorLRDirection = XMViewVoicePowerIndicatorLRDirectionRight;
    //设置指示器上下方向
    self.viewVoicePowerIndicatorL.indicatorUDDirection = XMViewVoicePowerIndicatorUDDirectionUD;
    self.viewVoicePowerIndicatorR.indicatorUDDirection = XMViewVoicePowerIndicatorUDDirectionUD;
    //添加到视图
    [self.viewRecoderDuration addSubview:self.viewVoicePowerIndicatorL];
    [self.viewRecoderDuration addSubview:self.viewVoicePowerIndicatorR];
    self.viewVoicePowerIndicatorL.backgroundColor = [UIColor clearColor];
    self.viewVoicePowerIndicatorR.backgroundColor = [UIColor clearColor];
}

- (IBAction)onTouchDownBtnRecoder:(id)sender {
    //初始化UI
    self.constraintBtnRecorderReviewSelectedWidth.constant = 40;
    self.constraintBtnRecorderDeleteSelectedWidth.constant = 40;
    
    [self.btnRecorderReviewSelected setBackgroundImage:[UIImage imageNamed:@"input_view_panel_voice_recorder_operation_circle"] forState:UIControlStateNormal];
    [self.btnRecorderReviewSelected setImage:[UIImage imageNamed:@"input_view_panel_voice_recorder_review_808080"] forState:UIControlStateNormal];
    [self.btnRecorderDeleteSelected setBackgroundImage:[UIImage imageNamed:@"input_view_panel_voice_recorder_operation_circle"] forState:UIControlStateNormal];
    [self.btnRecorderDeleteSelected setImage:[UIImage imageNamed:@"input_view_panel_voice_recorder_delete_808080"] forState:UIControlStateNormal];
    //初始化数据
    self.isSuccessOpenRecorder = NO;
    self.isRecorderOuttime = NO;
    self.recorderOperation = IMRecorderOperationSend;
    
    self.recorderSeconds = 0;
    self.audio = nil;
    
    self.labelRecorderState.text = @"正在准备...";
    self.actyIndicatorPrepareRecorder.hidden = NO;
    [self.actyIndicatorPrepareRecorder startAnimating];
    
    //开始录音
    XMSoundRecorder *recorder = [XMSoundRecorder sharedInstance];
    recorder.delegateRecorder = self;
    [recorder startRecord];
}
- (IBAction)onTouchUpInsiderBtnRecorder:(id)sender {
    self.recorderOperation = IMRecorderOperationSend;
    [self stopRecorder];
}

- (void)testt:(UIPanGestureRecognizer*)sender{
    CGPoint centerRecorder = CGPointMake([UIScreen mainScreen].bounds.size.width/2, 110);
    CGPoint centerRecorderReviewSelected = CGPointMake(55, 110);
    CGPoint centerRecorderDeleteSelected = CGPointMake([UIScreen mainScreen].bounds.size.width-55, 110);
    
    CGPoint p = [sender locationInView:self];
    
    if (sender.state == UIGestureRecognizerStateBegan || sender.state == UIGestureRecognizerStateChanged){
        //水平距离
        CGFloat distanceToRecorder = ABS(p.x - centerRecorder.x);
        CGFloat distanceToReview = ABS(p.x - centerRecorderReviewSelected.x);
        CGFloat distanceToDelete = ABS(p.x - centerRecorderDeleteSelected.x);
        
        if (distanceToRecorder > 45) {
            CGFloat width = 40 + (distanceToRecorder-45);
            width = width>70? 70:width;
            if (distanceToReview < distanceToDelete) {
                self.constraintBtnRecorderReviewSelectedWidth.constant = width;
                self.constraintBtnRecorderDeleteSelectedWidth.constant = 40;
                if (width == 70) {
                    self.recorderOperation = IMRecorderOperationReview;
                    
                    [self.btnRecorderReviewSelected setBackgroundImage:[UIImage imageNamed:@"input_view_panel_voice_recorder_operation_circle_selected"] forState:UIControlStateNormal];
                    [self.btnRecorderReviewSelected setImage:[UIImage imageNamed:@"input_view_panel_voice_recorder_review_ffffff"] forState:UIControlStateNormal];
                    
                    self.labelRecorderState.text = @"松手试听";
                    self.viewRecoderState.hidden = NO;
                    self.viewRecoderDuration.hidden = YES;
                }else{
                    self.recorderOperation = IMRecorderOperationSend;
                    
                    [self.btnRecorderReviewSelected setBackgroundImage:[UIImage imageNamed:@"input_view_panel_voice_recorder_operation_circle"] forState:UIControlStateNormal];
                    [self.btnRecorderReviewSelected setImage:[UIImage imageNamed:@"input_view_panel_voice_recorder_review_808080"] forState:UIControlStateNormal];
                    
                    self.viewRecoderState.hidden = YES;
                    self.viewRecoderDuration.hidden = NO;
                }
            }else{
                self.constraintBtnRecorderReviewSelectedWidth.constant = 40;
                self.constraintBtnRecorderDeleteSelectedWidth.constant = width;
                if (width == 70) {
                    self.recorderOperation = IMRecorderOperationDelete;
                    
                    [self.btnRecorderDeleteSelected setBackgroundImage:[UIImage imageNamed:@"input_view_panel_voice_recorder_operation_circle_selected"] forState:UIControlStateNormal];
                    [self.btnRecorderDeleteSelected setImage:[UIImage imageNamed:@"input_view_panel_voice_recorder_delete_ffffff"] forState:UIControlStateNormal];
                    
                    self.labelRecorderState.text = @"松手取消发送";
                    self.viewRecoderState.hidden = NO;
                    self.viewRecoderDuration.hidden = YES;
                }else{
                    self.recorderOperation = IMRecorderOperationSend;
                    
                    [self.btnRecorderDeleteSelected setBackgroundImage:[UIImage imageNamed:@"input_view_panel_voice_recorder_operation_circle"] forState:UIControlStateNormal];
                    [self.btnRecorderDeleteSelected setImage:[UIImage imageNamed:@"input_view_panel_voice_recorder_delete_808080"] forState:UIControlStateNormal];
                    
                    self.viewRecoderState.hidden = YES;
                    self.viewRecoderDuration.hidden = NO;
                }
            }
        }else{
            self.constraintBtnRecorderReviewSelectedWidth.constant = 40;
            self.constraintBtnRecorderDeleteSelectedWidth.constant = 40;
        }
    }else if (sender.state == UIGestureRecognizerStateEnded){
        [self stopRecorder];
    }
}

- (void)stopRecorder{
    if (self.isRecorderOuttime) {
        return;
    }
    
    self.btnRecorderReviewSelected.hidden = YES;
    self.btnRecorderDeleteSelected.hidden = YES;
    
    if (self.isSuccessOpenRecorder) {
        if (self.recorderOperation == IMRecorderOperationReview) {
            self.viewCancelSendWrap.hidden = NO;
            self.viewReviewWrap.hidden = NO;
            self.btnRecorder.hidden = YES;
            
            self.viewRecoderState.hidden = YES;
            self.viewRecoderDuration.hidden = NO;
            self.labelDuration.text = [self recorderSecondsToStr:self.recorderSeconds];
        }
        
        if (self.recorderOperation == IMRecorderOperationDelete) {
            self.labelRecorderState.text = @"按住说话";
            self.viewRecoderState.hidden = NO;
            self.viewRecoderDuration.hidden = YES;
        }
        
        if (self.recorderOperation == IMRecorderOperationSend) {
            self.labelRecorderState.text = @"按住说话";
            self.viewRecoderState.hidden = NO;
            self.viewRecoderDuration.hidden = YES;
            
            [self sendVoice];
        }
        
        self.audio = [[XMSoundRecorder sharedInstance] stopRecord];
    }else{
        self.labelRecorderState.text = @"请按住说话";
        self.viewRecoderState.hidden = NO;
        self.viewRecoderDuration.hidden = YES;
        
        self.viewCancelSendWrap.hidden = YES;
        self.viewReviewWrap.hidden = YES;
        self.btnRecorder.hidden = NO;
    }
    
    [self.viewVoicePowerIndicatorL cleanPowerItem];
    [self.viewVoicePowerIndicatorR cleanPowerItem];
}

- (void)sendVoice{
    if (self.recorderSeconds > 1){
        if (self.delegateKeyboard) {
            if ([self.delegateKeyboard respondsToSelector:@selector(inputViewIMVoice:voice:)]) {
                [self.delegateKeyboard inputViewIMVoice:self voice:self.audio];
            }
        }
    }else{
        //录音时间太短
        UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"录音太短" message:@"你最少需要录制1秒的语音" preferredStyle:UIAlertControllerStyleAlert];
        [controller addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
        [[AppDelegate shareAppDelegate].window.rootViewController presentViewController:controller animated:YES completion:nil];
    }
}

- (IBAction)onClickBtnRecorderReview:(UIButton*)sender {
    sender.selected = !sender.selected;
    if (sender.selected){
        if (self.audio) {
            self.viewCancelSendWrap.hidden = YES;
            self.timerPlayerSeconds = 0;
            self.timerPlayer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(recorderReviewPlaying) userInfo:nil repeats:YES];
            
            self.labelDuration.text = @"0:00";
            [XMSoundPlayer sharedInstance].delegatePlayer = self;
            [[XMSoundPlayer sharedInstance] playWith:self.audio];
        }
    }else{
        [[XMSoundPlayer sharedInstance] stopPlay];
        self.viewCancelSendWrap.hidden = NO;
        self.btnRecorderReview.selected = NO;
        [self.timerPlayer invalidate];
        self.timerPlayer = nil;
        self.labelDuration.text = [self recorderSecondsToStr:self.recorderSeconds];
        self.progressRecorderReview.progress = 0;
    }
}

- (IBAction)onClickBtnCancel:(id)sender {
    self.btnRecorderReview.selected = NO;
    self.viewCancelSendWrap.hidden = YES;
    self.viewReviewWrap.hidden = YES;
    self.btnRecorder.hidden = NO;
    
    self.labelRecorderState.text = @"按住说话";
    self.viewRecoderState.hidden = NO;
    self.viewRecoderDuration.hidden = YES;
}

- (IBAction)onClickBtnSend:(UIButton*)sender {
    self.btnRecorderReview.selected = NO;
    self.viewCancelSendWrap.hidden = YES;
    self.viewReviewWrap.hidden = YES;
    self.btnRecorder.hidden = NO;
    
    self.labelRecorderState.text = @"按住说话";
    self.viewRecoderState.hidden = NO;
    self.viewRecoderDuration.hidden = YES;
    
    [self sendVoice];
}

- (NSString*)recorderSecondsToStr:(int)seconds{
    int min = seconds/60;
    int sec = seconds%60;
    
    return [NSString stringWithFormat:@"%i:%02i", min, sec];
}

- (void)recorderReviewPlaying{
    self.timerPlayerSeconds ++;
    self.timerPlayerSeconds = self.timerPlayerSeconds<self.recorderSeconds? self.timerPlayerSeconds:self.recorderSeconds;
    self.labelDuration.text = [self recorderSecondsToStr:self.timerPlayerSeconds];
    self.progressRecorderReview.progress = (self.timerPlayerSeconds+1)/1.0/self.recorderSeconds;
}

//================录音机回调
- (void)xmSoundRecorder:(XMSoundRecorder *)recorder start:(BOOL)start{
    self.actyIndicatorPrepareRecorder.hidden = YES;

    if (start) {
        self.labelDuration.text = @"0:00";
        self.viewRecoderDuration.hidden = NO;
        self.viewRecoderState.hidden = YES;
        
        self.isSuccessOpenRecorder = YES;
        
        self.btnRecorderReviewSelected.hidden = NO;
        self.btnRecorderDeleteSelected.hidden = NO;
    }else{
        self.labelRecorderState.text = @"录音失败";
        
        UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"无法录音" message:@"请在“设置-隐私-麦克风”中允许访问麦克风。" preferredStyle:UIAlertControllerStyleAlert];
        
        [controller addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [controller addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        
        [[AppDelegate shareAppDelegate].window.rootViewController presentViewController:controller animated:YES completion:nil];
    }
}

- (void)xmSoundRecorder:(XMSoundRecorder *)recorder duration:(int)duration{
    self.recorderSeconds = duration;
    self.labelDuration.text = [self recorderSecondsToStr:duration];
}

- (void)xmSoundRecorder:(XMSoundRecorder *)recorder power:(float)power{
    [self.viewVoicePowerIndicatorL addPowerItem:power];
    [self.viewVoicePowerIndicatorR addPowerItem:power];
}

- (void)xmSoundRecorder:(XMSoundRecorder *)recorder outtimeWithDuration:(int)duration audio:(NSData *)audio{
    [self stopRecorder];
    self.isRecorderOuttime = YES;
    
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"录音超时" message:@"你最长只能录制120秒的语音" preferredStyle:UIAlertControllerStyleAlert];
    [controller addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    [[AppDelegate shareAppDelegate].window.rootViewController presentViewController:controller animated:YES completion:nil];
}

- (void)xmSoundPlayer:(XMSoundPlayer *)player start:(BOOL)start{

}

- (void)xmSoundPlayer:(XMSoundPlayer *)player power:(float)power{
    [self.viewVoicePowerIndicatorL addPowerItem:power];
    [self.viewVoicePowerIndicatorR addPowerItem:power];
}

- (void)xmSoundPlayer:(XMSoundPlayer *)player completion:(BOOL)completion{
    self.viewCancelSendWrap.hidden = NO;
    self.btnRecorderReview.selected = NO;
    [self.timerPlayer invalidate];
    self.timerPlayer = nil;
    self.labelDuration.text = [self recorderSecondsToStr:self.recorderSeconds];
    self.progressRecorderReview.progress = 0;
    
    [self.viewVoicePowerIndicatorL cleanPowerItem];
    [self.viewVoicePowerIndicatorR cleanPowerItem];
}

@end
