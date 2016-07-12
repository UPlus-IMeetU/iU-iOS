//
//  FilterView.h
//  IMeetU
//
//  Created by Spring on 16/7/12.
//  Copyright © 2016年 zhanghao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelFilter.h"
@interface FilterView : UIView
+(instancetype)createFilterView;
@property (weak, nonatomic) IBOutlet UIView *viewChooseAgeLeft;
@property (weak, nonatomic) IBOutlet UILabel *topicLabel;
@property (nonatomic,strong) ModelFilter *modelFilter;
@end
