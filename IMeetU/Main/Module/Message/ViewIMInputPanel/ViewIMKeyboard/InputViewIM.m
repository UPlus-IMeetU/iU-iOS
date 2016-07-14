//
//  InputViewIM.m
//  IMTest
//
//  Created by zhanghao on 16/7/1.
//  Copyright © 2016年 zhanghao. All rights reserved.
//

#import "InputViewIM.h"

@implementation InputViewIM

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
