//
//  CellCollectionEmojiStore.m
//  BuHuiAi
//
//  Created by zhanghao on 16/7/5.
//  Copyright © 2016年 zhanghao. All rights reserved.
//

#import "CellCollectionEmojiStore.h"
#import "ModelEmojiStore.h"
#import "IMEmojiUrlHelper.h"

#import <YYKit/YYKit.h>
/**
 * 收藏的表情
 */
@interface CellCollectionEmojiStore()

@property (weak, nonatomic) IBOutlet UIImageView *imgEmoji;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;

@end
@implementation CellCollectionEmojiStore

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setManager{
    [self.imgEmoji setImage:[UIImage imageNamed:@"input_view_panel_emoji_switch_store_manager"]];
    [self.labelTitle setText:@"管理"];
}

- (void)setModel:(ModelEmojiStore *)model{
    if (!model) {
        [self.imgEmoji setImage:nil];
        [self.labelTitle setText:@""];
    }else{
        NSURL *url = [NSURL URLWithString:[IMEmojiUrlHelper urlEmojiCustomWithFileName:model.fileName format:model.format]];
        [self.imgEmoji setImageWithURL:url placeholder:nil];
        [self.labelTitle setText:model.title];
    }
}

@end
