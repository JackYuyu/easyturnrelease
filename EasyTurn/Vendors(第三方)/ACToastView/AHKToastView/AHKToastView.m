//
//  AHKToastView.m
//  AHKit
//
//  Created by OutMan_Coder on 2018/11/5.
//  Copyright © 2018年 AutoHome. All rights reserved.
//

#import "AHKToastView.h"


@interface AHKToastView ()

@property (nonatomic, copy) ToastCancel blockCancel;

@end

@implementation AHKToastView

static AHKToastView *instance_;
+ (AHKToastView *)toastView {
    return [[self class] toastView:NO];
}

+ (AHKToastView *)toastView:(BOOL)isIntercept {
    AHKToastHUDMaskType hudMaskType;
    //是否禁止操作
    if (isIntercept) {
        hudMaskType = AHKToastHUDMaskTypeBlack;
    } else {
        hudMaskType = AHKToastHUDMaskTypeNone;
    }
    return [self toastViewStyle:hudMaskType];
}

+ (AHKToastView *)toastViewStyle:(AHKToastHUDMaskType)toastHUDMaskType {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance_ = [[AHKToastView alloc] init];
    });
    if (toastHUDMaskType == AHKToastHUDMaskTypeNone) {
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    } else if (toastHUDMaskType == AHKToastHUDMaskTypeClear) {
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    } else if (toastHUDMaskType == AHKToastHUDMaskTypeBlack) {
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    } else if (toastHUDMaskType == AHKToastHUDMaskTypeGradient) {
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    } else if (toastHUDMaskType == AHKToastHUDMaskTypeClear) {
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    }
    [SVProgressHUD setImageViewSize:CGSizeMake(28, 28)];
    return instance_;
}

#pragma mark - UI
+ (void)configHudMinimumSize:(CGSize)minimumSize {
    [[SVProgressHUD appearance] setMinimumSize:minimumSize];
}

+ (void)configHudConstraintSize:(CGSize)constraintSize {
    [[SVProgressHUD appearance] setConstraintSize:constraintSize];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [SVProgressHUD setBackgroundColor:kColorBlack];
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD setSuccessImage:kImageRequestSuccess];
        [SVProgressHUD setErrorImage:kImageRequestError];
        [SVProgressHUD setMinimumDismissTimeInterval:AHKToastDurationNormal];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onClickCancle) name:SVProgressHUDDidReceiveTouchEventNotification object:nil];
    }
    return self;
}

- (void)showLoading:(NSString *)title cancel:(ToastCancel)blockCancel {
    _blockCancel = blockCancel;
    [self show:title icon:nil isLoading:YES duration:AHKToastDurationNormal];
}

- (void)showMessage:(NSString *)title icon:(UIImage *)icon duration:(AHKToastDuration)duration {
    [self show:title icon:icon isLoading:NO duration:duration];
}

- (void)showMessage:(NSString *)title {
    [SVProgressHUD setImageViewSize:CGSizeMake(0, 0)];
    [SVProgressHUD showImage:[[UIImage alloc] init] status:title];
}

- (void)showSuccessWithStatus:(NSString *)status {
    [SVProgressHUD showSuccessWithStatus:status];
}

- (void)showSuccessWithStatus:(NSString *)status completion:(ToastDismissCompletion)completion {
    [SVProgressHUD showSuccessWithStatus:status];
    NSTimeInterval time = [SVProgressHUD displayDurationForString:status];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((0.15 + time) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (completion) {
            completion();
        }
    });
}

- (void)showErrorWithStatus:(NSString *)status {
    [SVProgressHUD showInfoWithStatus:status];
}

- (void)showErrorWithStatus:(NSString *)status completion:(ToastDismissCompletion)completion {
    [SVProgressHUD showErrorWithStatus:status];
    NSTimeInterval time = [SVProgressHUD displayDurationForString:status];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((0.15 + time) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (completion) {
            completion();
        }
    });
}

- (void)showInfoWithStatus:(NSString *)status {
    [SVProgressHUD showInfoWithStatus:status];
}

- (void)showInfoWithStatus:(NSString *)status completion:(ToastDismissCompletion)completion {
    [SVProgressHUD showInfoWithStatus:status];
    NSTimeInterval time = [SVProgressHUD displayDurationForString:status];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((0.15 + time) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (completion) {
            completion();
        }
    });
}

- (void)showViewHUD:(UIView *)view status: (NSString *)status {
    [SVProgressHUD showViewHUD:view status:status];
}

/* 隐藏提示框 */
- (void)hide {
    [SVProgressHUD dismissWithDelay:.15];
}

- (void)hideWithCompletion:(ToastDismissCompletion)completion {
    [SVProgressHUD dismissWithCompletion:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completion) {
                completion();
            }
        });
    }];
}

- (void)hideWithDelay:(NSTimeInterval)delay completion:(ToastDismissCompletion)completion {
    [SVProgressHUD dismissWithDelay:delay completion:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completion) {
                completion();
            }
        });
    }];
}

- (void)updateMessage:(NSString *)title {
    [SVProgressHUD setStatus:title];
}

- (NSTimeInterval)displayDurationForString:(NSString*)string {
    NSTimeInterval time = [SVProgressHUD displayDurationForString:string];
    return time;
}

/* 显示提示框 */
- (void)show:(NSString *)title icon:(UIImage *)icon isLoading:(BOOL)isLoading duration:(NSTimeInterval)duration {
    [SVProgressHUD setMinimumDismissTimeInterval:duration];
    
    if (isLoading) {
        [SVProgressHUD showWithStatus:title];
    } else {
        if ([icon isEqual:kImageRequestSuccess]) {
            [SVProgressHUD showSuccessWithStatus:title];
        } else {
            [SVProgressHUD showErrorWithStatus:title];
        }
    }
}

#pragma mark - NSNotification
- (void)onClickCancle {
    AMLog(@"onClickCancle");
    if (_blockCancel) {
        _blockCancel();
    }
}

#pragma mark - Setter And Getter
- (void)setDefaultStyle:(SVProgressHUDStyle)defaultStyle {
    [SVProgressHUD setDefaultStyle:defaultStyle];
}
- (SVProgressHUDStyle)defaultStyle {
    return [SVProgressHUD sharedView].defaultStyle;
}

-(void)setCornerRadius:(CGFloat)cornerRadius {
    [SVProgressHUD setCornerRadius:cornerRadius];
}

- (CGFloat)cornerRadius {
    return [SVProgressHUD sharedView].cornerRadius;
}

- (void)setRingRadius:(CGFloat)ringRadius {
    [SVProgressHUD setRingRadius:ringRadius];
}

- (CGFloat)ringRadius {
    return [SVProgressHUD sharedView].ringRadius;
}

- (void)setRingThickness:(CGFloat)ringThickness {
    [[SVProgressHUD sharedView] setRingThickness:ringThickness];
}

- (CGFloat)ringThickness {
    return [SVProgressHUD sharedView].ringThickness;
}

- (void)setForegroundColor:(UIColor *)foregroundColor {
    [SVProgressHUD setForegroundColor:foregroundColor];
}

- (UIColor *)foregroundColor {
    return [SVProgressHUD sharedView].foregroundColor;
}

- (void)setMinimumSize:(CGSize)minimumSize {
    [SVProgressHUD setMinimumSize:minimumSize];
}

- (void)setConstraintSize:(CGSize)constraintSize {
    [SVProgressHUD setConstraintSize:constraintSize];
}

#pragma mark - Dealloc
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SVProgressHUDDidReceiveTouchEventNotification object:nil];
}

@end
