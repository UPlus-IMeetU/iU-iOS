//
//  AlertView.h
//  IMeetU
//
//  Created by Spring on 16/7/15.
//  Copyright © 2016年 zhanghao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EnumHeader.h"
@interface AlertView : UIView
+(AlertView *)instanceAlertView;
@property (nonatomic,assign) AlertType alertType;
@end
