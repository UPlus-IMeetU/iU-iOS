//
//  SquareViewCell.m
//  IMeetU
//
//  Created by Spring on 16/7/5.
//  Copyright © 2016年 zhanghao. All rights reserved.
//

#import "SquareViewCell.h"
#import "UIColor+Plug.h"
#import <YYkit/YYkit.h>
@interface SquareViewCell()

@property (weak, nonatomic) IBOutlet UIView *colorView;
@property (weak, nonatomic) IBOutlet UIImageView *topicImageView;
@property (weak, nonatomic) IBOutlet UILabel *topicNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *topicInfoLabel;
@property (weak, nonatomic) IBOutlet UILabel *topicNum;


@end
@implementation SquareViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModelSquare:(ModelSquare *)modelSquare{
    _modelSquare = modelSquare;
    [_topicImageView setImageWithURL:[NSURL URLWithString:_modelSquare.icon_url] placeholder:[UIImage imageNamed:@"global_photo_load_fail"]];
    _topicNameLabel.text = _modelSquare.content;
    _topicInfoLabel.text = [NSString stringWithFormat:@"已经产生了%ld内容",(long)_modelSquare.number_response];
    _topicNum.text = [NSString stringWithFormat:@"%ld",(long)_modelSquare.number_duty];
    _colorView.backgroundColor = [UIColor xmColorWithHexStrRGB:_modelSquare.color];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
