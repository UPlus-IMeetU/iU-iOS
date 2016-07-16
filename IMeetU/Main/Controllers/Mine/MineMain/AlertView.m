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

@end
@implementation AlertView


+(AlertView *)instanceAlertView
{
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"AlertView" owner:nil options:nil];
    return [nibView objectAtIndex:0];
}

- (void)awakeFromNib{
    self.careAboutMeView.layer.cornerRadius = 10;
    self.careAboutMeView.clipsToBounds = YES;
    self.careAboutMeBtn.layer.cornerRadius = 15;
    self.careAboutMeBtn.clipsToBounds = YES;
    
    self.layer.transform = CATransform3DMakeScale(1.1, 1.1, 1);
    [UIView animateWithDuration:0.5 animations:^{
        self.layer.transform = CATransform3DMakeScale(1, 1, 1);
    }];
}

- (IBAction)careAboutMeBtnClick:(id)sender {
    [self removeFromSuperview];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
