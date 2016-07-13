//
//  CellCollectionEmojiEmoji.m
//  BuHuiAi
//
//  Created by zhanghao on 16/7/5.
//  Copyright © 2016年 zhanghao. All rights reserved.
//

#import "CellCollectionEmojiEmoji.h"

/**
 * 表情符号
 */
@interface CellCollectionEmojiEmoji()

@property (weak, nonatomic) IBOutlet UIImageView *imgEmoji;

@end
@implementation CellCollectionEmojiEmoji

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setImg:(UIImage*)img{
    [self.imgEmoji setImage:img];
}
@end
