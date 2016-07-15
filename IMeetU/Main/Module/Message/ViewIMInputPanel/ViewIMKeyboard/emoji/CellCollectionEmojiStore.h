//
//  CellCollectionEmojiStore.h
//  BuHuiAi
//
//  Created by zhanghao on 16/7/5.
//  Copyright © 2016年 zhanghao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ModelEmojiStore;

@interface CellCollectionEmojiStore : UICollectionViewCell

//此cell为管理按钮
- (void)setManager;
- (void)setModel:(ModelEmojiStore*)model;

@end
