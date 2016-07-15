//
//  AlertView.m
//  IMeetU
//
//  Created by Spring on 16/7/15.
//  Copyright © 2016年 zhanghao. All rights reserved.
//

#import "AlertView.h"

@interface AlertView()
@property (weak, nonatomic) IBOutlet UIButton *careAboutMeView;
@property (weak, nonatomic) IBOutlet UIButton *careAboutMeBtn;

@end
@implementation AlertView
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.careAboutMeView.layer.cornerRadius = 10;
        self.careAboutMeView.clipsToBounds = YES;
        self.careAboutMeBtn.layer.cornerRadius = 15;
        self.careAboutMeBtn.clipsToBounds = YES;
    }
    return self;
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
