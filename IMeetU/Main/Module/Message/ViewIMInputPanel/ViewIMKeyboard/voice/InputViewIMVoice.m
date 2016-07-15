//
//  InputViewIMVoice.m
//  IMTest
//
//  Created by zhanghao on 16/7/1.
//  Copyright © 2016年 zhanghao. All rights reserved.
//

#import "InputViewIMVoice.h"
#import "CATCurveProgressView.h"

@interface InputViewIMVoice()

@property (weak, nonatomic) IBOutlet UILabel *labelContent;
@property (weak, nonatomic) IBOutlet UIButton *btnRecorder;
@property (weak, nonatomic) IBOutlet UIButton *btnRecorderReview;
@property (weak, nonatomic) IBOutlet CATCurveProgressView *progressRecorderReview;
@property (weak, nonatomic) IBOutlet UIView *viewReviewWrap;

@property (weak, nonatomic) IBOutlet UIButton *btnRecorderReviewSelected;
@property (weak, nonatomic) IBOutlet UIButton *btnRecorderDeleteSelected;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintBtnRecorderReviewSelectedWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintBtnRecorderDeleteSelectedWidth;


@property (weak, nonatomic) IBOutlet UIView *viewCancelSendWrap;
@property (weak, nonatomic) IBOutlet UIButton *btnCancel;
@property (weak, nonatomic) IBOutlet UIButton *btnSend;

@property (nonatomic, assign) BOOL isSelectedRecorderReview;
@property (nonatomic, assign) BOOL isSelectedRecorderDelete;
@property (nonatomic, assign) BOOL isRecognizerDraw;
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
    self.isSelectedRecorderReview = NO;
    self.isSelectedRecorderDelete = NO;
    self.labelContent.text = @"0:00";
    
    //显示选项
    self.btnRecorderReviewSelected.hidden = NO;
    self.btnRecorderDeleteSelected.hidden = NO;
    
    //开始录音
    
}
- (IBAction)onTouchUpInsiderBtnRecorder:(id)sender {
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
                    self.isSelectedRecorderReview = YES;
                    [self.btnRecorderReviewSelected setBackgroundImage:[UIImage imageNamed:@"input_view_panel_voice_recorder_operation_circle_selected"] forState:UIControlStateNormal];
                    [self.btnRecorderReviewSelected setImage:[UIImage imageNamed:@"input_view_panel_voice_recorder_review_ffffff"] forState:UIControlStateNormal];
                }else{
                    self.isSelectedRecorderReview = NO;
                    [self.btnRecorderReviewSelected setBackgroundImage:[UIImage imageNamed:@"input_view_panel_voice_recorder_operation_circle"] forState:UIControlStateNormal];
                    [self.btnRecorderReviewSelected setImage:[UIImage imageNamed:@"input_view_panel_voice_recorder_review_808080"] forState:UIControlStateNormal];
                }
            }else{
                self.constraintBtnRecorderReviewSelectedWidth.constant = 40;
                self.constraintBtnRecorderDeleteSelectedWidth.constant = width;
                if (width == 70) {
                    self.isSelectedRecorderDelete = YES;
                    [self.btnRecorderDeleteSelected setBackgroundImage:[UIImage imageNamed:@"input_view_panel_voice_recorder_operation_circle_selected"] forState:UIControlStateNormal];
                    [self.btnRecorderDeleteSelected setImage:[UIImage imageNamed:@"input_view_panel_voice_recorder_delete_ffffff"] forState:UIControlStateNormal];
                }else{
                    self.isSelectedRecorderDelete = NO;
                    [self.btnRecorderDeleteSelected setBackgroundImage:[UIImage imageNamed:@"input_view_panel_voice_recorder_operation_circle"] forState:UIControlStateNormal];
                    [self.btnRecorderDeleteSelected setImage:[UIImage imageNamed:@"input_view_panel_voice_recorder_delete_808080"] forState:UIControlStateNormal];
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
    self.btnRecorderReviewSelected.hidden = YES;
    self.btnRecorderDeleteSelected.hidden = YES;
    
    if (self.isSelectedRecorderReview) {
        self.viewCancelSendWrap.hidden = NO;
        self.viewReviewWrap.hidden = NO;
        self.btnRecorder.hidden = YES;
    }
    
    if (self.isSelectedRecorderDelete) {
        
    }
}
- (IBAction)onClickBtnRecorderReview:(UIButton*)sender {
    sender.selected = !sender.selected;
    if (!sender.selected){
        
    }else{
        
    }
}

- (IBAction)onClickBtnCancel:(id)sender {
    self.viewCancelSendWrap.hidden = YES;
    self.viewReviewWrap.hidden = YES;
    self.btnRecorder.hidden = NO;
}

- (IBAction)onClickBtnSend:(UIButton*)sender {
    self.viewCancelSendWrap.hidden = YES;
    self.viewReviewWrap.hidden = YES;
    self.btnRecorder.hidden = NO;

}


@end
