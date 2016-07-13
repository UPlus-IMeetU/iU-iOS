//
//  InputViewIM.m
//  IMTest
//
//  Created by zhanghao on 16/7/1.
//  Copyright © 2016年 zhanghao. All rights reserved.
//

#import "InputViewIM.h"

@implementation InputViewIM

//覆盖父类方法，控制视图大小
- (CGRect)frame{
    return CGRectMake(0, 80, [UIScreen mainScreen].bounds.size.width, 220);
}

+ (id)viewWithNibName:(NSString*)nibName viewClass:(Class)viewClass{
    UINib *nib = [UINib nibWithNibName:nibName bundle:[NSBundle mainBundle]];
    NSArray *views = [nib instantiateWithOwner:nil options:nil];
    
    for (id v in views) {
        if ([v isKindOfClass:viewClass]) {
            return v;
        }
    }
    
    return nil;
}

@end
