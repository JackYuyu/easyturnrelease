//
//  LGAlertView+AHKAlertView.m
//  AHKit
//
//  Created by OutMan_Coder on 2018/10/24.
//  Copyright © 2018年 AutoHome. All rights reserved.
//

#import "LGAlertView+AHKAlertView.h"
#import <objc/runtime.h>

static NSString *const kAHKit_AlertDidDismissAfterBlock = @"kAHKit_AlertDidDismissAfterBlock";

@implementation LGAlertView (AHKAlertView)

#pragma mark - Setter And Getter
- (void)setDidDismissAfterBlock:(BOOL)didDismissAfterBlock {
    NSNumber *value = didDismissAfterBlock ? @(1) : @(0);
    objc_setAssociatedObject(self, &kAHKit_AlertDidDismissAfterBlock, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)didDismissAfterBlock {
    NSNumber *value = objc_getAssociatedObject(self, &kAHKit_AlertDidDismissAfterBlock);
    return value.integerValue > 0 ? YES : NO;
}

@end
