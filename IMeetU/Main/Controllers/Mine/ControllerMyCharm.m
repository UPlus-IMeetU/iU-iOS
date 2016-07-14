//
//  ControllerMyCharm.m
//  IMeetU
//
//  Created by Spring on 16/7/14.
//  Copyright © 2016年 zhanghao. All rights reserved.
//

#import "ControllerMyCharm.h"
#import "UIColor+Plug.h"
@interface ControllerMyCharm ()
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *charmLabel;
@property (weak, nonatomic) IBOutlet UIView *fullCharmView;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@end

@implementation ControllerMyCharm

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.fullCharmView.layer.cornerRadius = 3.5;
    self.fullCharmView.clipsToBounds = YES;
    self.fullCharmView.layer.borderWidth = 0.5;
    self.fullCharmView.layer.borderColor = [UIColor xmColorWithHexStrRGB:@"FEFC9B"].CGColor;
    
    
    self.bgView.layer.cornerRadius = 10;
    self.bgView.clipsToBounds = YES;
}

- (void)viewDidAppear:(BOOL)animated{
    [UIView animateWithDuration:4 animations:^{
           }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
