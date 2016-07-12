//
//  CoupleViewCell.m
//  IMeetU
//
//  Created by Spring on 16/7/5.
//  Copyright © 2016年 zhanghao. All rights reserved.
//

#import "CoupleViewCell.h"
#import "UIViewAdditions.h"
@interface CoupleViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *portraitImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *collegeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *signLabel;
@property (weak, nonatomic) IBOutlet UIImageView *genderImageView;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIView *pointView;

@end
@implementation CoupleViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.bgView.layer.cornerRadius = 8.0;
    self.bgView.clipsToBounds = YES;
    self.pointView.layer.cornerRadius = self.pointView.width * 0.5;
    self.pointView.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
