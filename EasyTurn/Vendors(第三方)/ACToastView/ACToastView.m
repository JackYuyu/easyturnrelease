//
//  ACToastView.m
//  AutoTraderCloud
//
//  Created by GeWei on 2017/11/13.
//  Copyright © 2017年 AutoHome. All rights reserved.
//

#import "ACToastView.h"
#import "ACLoadingHUD.h"
#import "NSString+AHKit.h"
@interface ACToastView ()

@property (nonatomic, strong) ACLoadingHUD *loadingView;
@end

static ACToastView *sharedACToastView = nil;
@implementation ACToastView

+ (ACToastView *)toastView {
    return  [self toastView:NO];
}
+ (ACToastView *)toastView:(BOOL)isIntercept {
    ACToastHUDMaskType toastHUDMaskType;
    if (isIntercept == YES) {
        toastHUDMaskType = ACToastHUDMaskTypeBlack;
    } else {
       toastHUDMaskType = ACToastHUDMaskTypeNone;
    }
    return  [self toastViewStyle:toastHUDMaskType];
}

+(ACToastView *)toastViewStyle:(ACToastHUDMaskType)toastHUDMaskType {
    if (toastHUDMaskType == ACToastHUDMaskTypeNone) {
        [super toastViewStyle:AHKToastHUDMaskTypeNone];
    } else if (toastHUDMaskType == ACToastHUDMaskTypeClear) {
        [super toastViewStyle:AHKToastHUDMaskTypeClear];
    } else if (toastHUDMaskType == ACToastHUDMaskTypeBlack) {
        [super toastViewStyle:AHKToastHUDMaskTypeBlack];
    } else if (toastHUDMaskType == ACToastHUDMaskTypeGradient) {
        [super toastViewStyle:AHKToastHUDMaskTypeGradient];
    } else if (toastHUDMaskType == ACToastHUDMaskTypeCustom) {
        [super toastViewStyle:AHKToastHUDMaskTypeCustom];
    }
    
    return  [self sharedACToastView];
}



+ (ACToastView*)sharedACToastView {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedACToastView = [[ACToastView alloc] init];
        [sharedACToastView setCornerRadius:4];
        [sharedACToastView setMinimumSize:CGSizeMake(100, 64)];
        UIFont *font = [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline];
        CGFloat fontHeight = ceilf(font.lineHeight);
        CGFloat pointSize = font.pointSize; // 字体高度
        [sharedACToastView setConstraintSize:CGSizeMake(pointSize * 13, fontHeight * 3)];
    });
    return sharedACToastView;
}


- (void)showMessage:(NSString *)message {
    //新规范 最小高度64 宽度计算
    CGSize size = [message ak_sizeWithFontEX:kFontSize(14) constrainedToSize:CGSizeMake(270, CGFLOAT_MAX)];
    CGFloat height = size.height;
    CGFloat width = size.width;
    height = height > 64 ? height : 64;
    // 边距为20
    width = width + 40;
    [sharedACToastView setMinimumSize:CGSizeMake(width, 64)];
    [super showMessage:message];
}

- (void)showLoadingCircleViewWithStatus:(NSString *)status {
    [[ACToastView sharedACToastView].loadingView startLoading];
    [[ACToastView sharedACToastView] showViewHUD:[ACToastView sharedACToastView].loadingView status:status];
}

- (void)showLoadingSuccessViewWithStatus:(NSString *)status completionHandler:(void(^_Nullable)(void))completionHandler {
    [[ACToastView sharedACToastView] updateMessage:status];
    [[ACToastView sharedACToastView].loadingView finishWithSuccess:^{
        NSTimeInterval time = [[ACToastView sharedACToastView] displayDurationForString:status];
        NSTimeInterval endingAnimationTime = [ACToastView sharedACToastView].loadingView.animationTime;
        time = time > endingAnimationTime ? time - endingAnimationTime : 0;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [[ACToastView sharedACToastView] hideWithCompletion:^{
                if (completionHandler) {
                    completionHandler();
                }
            }];
        });
    }];
}

- (void)showLoadingFailureViewWithStatus:(NSString *)status completionHandler:(void(^)(void))completionHandler {
    [[ACToastView sharedACToastView] updateMessage:status];
    [[ACToastView sharedACToastView].loadingView finishWithFailure:^{
        NSTimeInterval time = [[ACToastView sharedACToastView] displayDurationForString:status];
        NSTimeInterval endingAnimationTime = [ACToastView sharedACToastView].loadingView.animationTime;
        time = time > endingAnimationTime ? time - endingAnimationTime : 0;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [[ACToastView sharedACToastView] hideWithCompletion:^{
                if (completionHandler) {
                    completionHandler();
                }
            }];
        });
    }];
    
}

#pragma mark - private
 - (ACLoadingHUD *)loadingView {
     if (_loadingView == nil) {
         _loadingView = [[ACLoadingHUD alloc] initWithFrame:CGRectZero];
         _loadingView.loadingColor = [self foregroundColorForStyle];
         _loadingView.successColor = [self foregroundColorForStyle];
         _loadingView.failureColor = [self foregroundColorForStyle];
         _loadingView.lineWidth = [ACToastView sharedACToastView].ringThickness;
         CGFloat radius  =  [ACToastView sharedACToastView].ringRadius;
         _loadingView.bounds = CGRectMake(0, 0, radius * 2, radius * 2);
     }
     return _loadingView;
 }

- (UIColor*)foregroundColorForStyle {
    if([ACToastView sharedACToastView].defaultStyle == SVProgressHUDStyleLight) {
        return [UIColor blackColor];
    } else if([ACToastView sharedACToastView].defaultStyle == SVProgressHUDStyleDark) {
        return [UIColor whiteColor];
    } else {
        return [ACToastView sharedACToastView].foregroundColor;
    }
}

- (void)hide {
    [[ACToastView sharedACToastView].loadingView endLoading];
    [super hide];
}

- (void)hideWithCompletion:(ToastDismissCompletion)completion {
    [[ACToastView sharedACToastView].loadingView endLoading];
    [super hideWithCompletion:completion];
}

- (void)hideWithDelay:(NSTimeInterval)delay completion:(ToastDismissCompletion)completion {
    [[ACToastView sharedACToastView].loadingView endLoading];
    [super hideWithDelay:delay completion:completion];
}


@end
