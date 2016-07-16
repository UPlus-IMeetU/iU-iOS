//
//  AlertView.m
//  IMeetU
//
//  Created by Spring on 16/7/15.
//  Copyright © 2016年 zhanghao. All rights reserved.
//

#import "AlertView.h"

@interface AlertView()
@property (weak, nonatomic) IBOutlet UIView *careAboutMeView;
@property (weak, nonatomic) IBOutlet UIButton *careAboutMeBtn;
@property (weak, nonatomic) IBOutlet UIView *applyForView;

@end
@implementation AlertView


+(AlertView *)instanceAlertView
{
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"AlertView" owner:nil options:nil];
    return [nibView objectAtIndex:0];
    
}

- (void)setAlertType:(AlertType *)alertType{
    _alertType = alertType;
    if (alertType ==  AlertTypeCareAboutMe) {
        self.careAboutMeView.hidden = NO;
        self.applyForView.hidden = YES;
        self.careAboutMeView.layer.cornerRadius = 10;
        self.careAboutMeView.clipsToBounds = YES;
        self.careAboutMeBtn.layer.cornerRadius = 15;
        self.careAboutMeBtn.clipsToBounds = YES;
    }else {
        self.careAboutMeView.hidden = YES;
        self.applyForView.hidden = NO;
        self.applyForView.layer.cornerRadius = 10;
        self.applyForView.clipsToBounds = YES;
    }
}

- (void)awakeFromNib{
    self.layer.transform = CATransform3DMakeScale(1.1, 1.1, 1);
    [UIView animateWithDuration:0.5 animations:^{
        self.layer.transform = CATransform3DMakeScale(1, 1, 1);
    }];
}

- (IBAction)careAboutMeBtnClick:(id)sender {
    [self removeFromSuperview];
}
- (IBAction)cancelBtnClick:(id)sender {
    [self removeFromSuperview];
}

- (IBAction)submitBtnClick:(id)sender {
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
