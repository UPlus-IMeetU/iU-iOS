//
//  CoupleViewCell.m
//  IMeetU
//
//  Created by Spring on 16/7/5.
//  Copyright © 2016年 zhanghao. All rights reserved.
//

#import "CoupleViewCell.h"
#import "UIViewAdditions.h"
#import <YYKit/YYKit.h>
#import "NSDate+MJ.h"
#import "DBSchools.h"
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

- (void)setModelCouple:(ModelCouple *)modelCouple{
    _modelCouple = modelCouple;
    [_portraitImageView setImageWithURL:[NSURL URLWithString:_modelCouple.icon_thumbnailUrl] placeholder:[UIImage imageNamed:@"photo_fail"]];
    _nameLabel.text = modelCouple.nickname;
    _collegeNameLabel.text = [self searchSchoolNameWithID:[modelCouple.school intValue]];
    NSLog(@"modelCouple = %@",modelCouple);
    
    if (modelCouple.sign) {
        _signLabel.text = modelCouple.sign;
    }else{
        _signLabel.text = @"火星来的，没有签名......";
    }
    
    _distanceLabel.text = [NSString stringWithFormat:@"%ldkm",(long)_modelCouple.distance];
    if ([_modelCouple.sex isEqualToString:@"1"]) {
        [_genderImageView setImage:[UIImage imageNamed:@"list_icon_boy"]];
    }else{
        [_genderImageView setImage:[UIImage imageNamed:@"list_icon_girl"]];
    }
    _timeLabel.text = [NSDate distanceTimeWithBeforeTime:_modelCouple.actytime];
}


- (NSString *)searchSchoolNameWithID:(NSInteger)schoolID{
    DBSchools *dbSchools = [DBSchools shareInstance];
    return [[dbSchools schoolWithID:schoolID] objectForKey:@"schoolName"];
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
