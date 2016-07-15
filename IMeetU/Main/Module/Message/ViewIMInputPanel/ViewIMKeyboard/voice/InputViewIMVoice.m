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
@property (weak, nonatomic) IBOutlet CATCurveProgressView *viewReviewWrap;

@property (weak, nonatomic) IBOutlet UIButton *btnRecorderReviewSelected;
@property (weak, nonatomic) IBOutlet UIButton *btnRecorderDeleteSelected;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintBtnRecorderReviewSelectedWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintBtnRecorderDeleteSelectedWidth;


@property (weak, nonatomic) IBOutlet UIView *viewCancelSendWrap;
@property (weak, nonatomic) IBOutlet UIButton *btnCancel;
@property (weak, nonatomic) IBOutlet UIButton *btnSend;

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
    self.btnRecorderReviewSelected.hidden = NO;
    self.btnRecorderDeleteSelected.hidden = NO;
}

- (IBAction)onTouchUpInsideBtnRecoder:(id)sender {
    self.btnRecorderReviewSelected.hidden = YES;
    self.btnRecorderDeleteSelected.hidden = YES;
}

- (IBAction)onTouchUpOutsideBtnRecoder:(id)sender {
    self.btnRecorderReviewSelected.hidden = YES;
    self.btnRecorderDeleteSelected.hidden = YES;
}

- (IBAction)onTouchDrawOutsideBtnRecoder:(id)sender {
    
}

- (void)testt:(UIPanGestureRecognizer*)sender{
    CGPoint centerRecorder = CGPointMake([UIScreen mainScreen].bounds.size.width/2, 110);
    CGPoint centerRecorderReviewSelected = CGPointMake(55, 110);
    CGPoint centerRecorderDeleteSelected = CGPointMake([UIScreen mainScreen].bounds.size.width-55, 110);
    
    CGPoint p = [sender locationInView:self];
    
    if (sender.state == UIGestureRecognizerStateBegan || sender.state == UIGestureRecognizerStateChanged){
        CGFloat distanceToRecorder = [self distanceFromPoint:p toPoint:centerRecorder];
        CGFloat distanceToReview = [self distanceFromPoint:p toPoint:centerRecorderReviewSelected];
        CGFloat distanceToDelete = [self distanceFromPoint:p toPoint:centerRecorderDeleteSelected];
        
        if (distanceToRecorder > 45) {
            CGFloat reviewWidth = 30 + (distanceToRecorder-45);
            if (distanceToReview < distanceToDelete) {
                
            }else{
                
            }
        }else{
            self.constraintBtnRecorderReviewSelectedWidth.constant = 30;
            self.constraintBtnRecorderDeleteSelectedWidth.constant = 30;
        }
    }else if (sender.state == UIGestureRecognizerStateEnded){
        self.btnRecorderReviewSelected.hidden = YES;
        self.btnRecorderDeleteSelected.hidden = YES;
        self.constraintBtnRecorderReviewSelectedWidth.constant = 30;
        self.constraintBtnRecorderDeleteSelectedWidth.constant = 30;
    }
}

- (CGFloat)distanceFromPoint:(CGPoint)pointA toPoint:(CGPoint)pointB{
    CGFloat deltaX = ABS(pointB.x - pointA.x);
    CGFloat deltaY = ABS(pointB.y - pointA.y);
    return sqrt(deltaX*deltaX + deltaY*deltaY );
}

@end
