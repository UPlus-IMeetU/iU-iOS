//
//  CellCollectionEmojiSwitch.m
//  BuHuiAi
//
//  Created by zhanghao on 16/7/5.
//  Copyright © 2016年 zhanghao. All rights reserved.
//

#import "CellCollectionEmojiSwitch.h"
#import "UIColor+Plug.h"
#import <YYKit/YYKit.h>

@interface CellCollectionEmojiSwitch()

@property (weak, nonatomic) IBOutlet UIImageView *imgEmoji;

@property (nonatomic, strong) UIView *viewBG;

@end
@implementation CellCollectionEmojiSwitch

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected{
    if (selected) {
        self.backgroundColor = [UIColor xmColorWithHexStrRGB:@"DDDDDD"];
    }else{
        self.backgroundColor = [UIColor clearColor];
    }
}

- (void)setImg:(UIImage *)img{
    [self.imgEmoji setImage:img];
}

- (void)setImgUrl:(NSString *)url{
    [self.imgEmoji setImageWithURL:[NSURL URLWithString:url] placeholder:[UIImage imageNamed:@"input_view_panel_emoji_switch_btn_defult"]];
}

- (UIView *)viewBG{
    if (!_viewBG) {
        _viewBG = [[UIView alloc] init];
        _viewBG.backgroundColor = [UIColor xmColorWithHexStrRGB:@"808080"];
    }
    return _viewBG;
}
@end
