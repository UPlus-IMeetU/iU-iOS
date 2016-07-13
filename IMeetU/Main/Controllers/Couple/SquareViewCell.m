//
//  SquareViewCell.m
//  IMeetU
//
//  Created by Spring on 16/7/5.
//  Copyright © 2016年 zhanghao. All rights reserved.
//

#import "SquareViewCell.h"
@interface SquareViewCell()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *colorView;
@property (weak, nonatomic) IBOutlet UIImageView *topicImageView;
@property (weak, nonatomic) IBOutlet UIView *topicNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *topicInfoLabel;
@property (weak, nonatomic) IBOutlet UILabel *topicNum;


@end
@implementation SquareViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
