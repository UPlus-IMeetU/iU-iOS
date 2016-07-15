//
//  ControllerMyVoice.h
//  IMeetU
//
//  Created by Spring on 16/7/13.
//  Copyright © 2016年 zhanghao. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^MyVoiceBlock) (NSInteger voiceSecond);
@interface ControllerMyVoice : UIViewController
@property (nonatomic,copy) MyVoiceBlock myVoiceBlock;
@end
