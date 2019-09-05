//
//  AHKToastView.h
//  AHKit
//
//  Created by OutMan_Coder on 2018/11/5.
//  Copyright © 2018年 AutoHome. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SVProgressHUD.h"

NS_ASSUME_NONNULL_BEGIN

#if NS_BLOCKS_AVAILABLE
typedef void (^ _Nullable ToastCancel)(void);
typedef void (^ _Nullable ToastDismissCompletion)(void);
#endif

#ifndef kColorBlack
#define kColorBlack [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1]
#endif

#ifndef kImageRequestSuccess
#define kImageRequestSuccess [UIImage imageNamed:@"ahkit_tips_icon_success"]
#endif

#ifndef kImageRequestError
#define kImageRequestError [UIImage imageNamed:@"ahkit_tips_icon_error"]
#endif

#ifndef kImageRequestWarning
#define kImageRequestWarning [UIImage imageNamed:@"ahkit_tips_icon_warning"]
#endif

#ifndef kImageRequestLoading
#define kImageRequestLoading [UIImage imageNamed:@"ahkit_popup_loading_icon"]
#endif

#ifndef kImageRequestLoading0
#define kImageRequestLoading0 [UIImage imageNamed:@"ahkit_network_loading"]
#endif

#ifndef kImageRequestRefresh0
#define kImageRequestRefresh0 [UIImage imageNamed:@"ahkit_network_refresh"]
#endif

typedef NS_ENUM(NSUInteger, AHKToastDuration) {
    AHKToastDurationNormal = 2,
    AHKToastDurationShort = 1,
    AHKToastDurationLong = 5
};

typedef NS_ENUM(NSUInteger, AHKToastHUDMaskType) {
    AHKToastHUDMaskTypeNone = 1,  // default mask type, allow user interactions while HUD is displayed
    AHKToastHUDMaskTypeClear,     // don't allow user interactions with background objects
    AHKToastHUDMaskTypeBlack,     // don't allow user interactions with background objects and dim the UI in the back of the HUD (as seen in iOS 7 and above)
    AHKToastHUDMaskTypeGradient,  // don't allow user interactions with background objects and dim the UI with a a-la UIAlertView background gradient (as seen in iOS 6)
    AHKToastHUDMaskTypeCustom     // don't allow user interactions with background objects and dim the UI in the back of the HUD with a custom color
};

@interface AHKToastView : NSObject

@property (nonatomic, assign) SVProgressHUDStyle defaultStyle;
@property (nonatomic, assign) CGFloat cornerRadius;
@property (nonatomic, assign) CGFloat ringRadius;
@property (nonatomic, assign) CGFloat ringThickness;
@property (nonatomic, strong) UIColor *foregroundColor;
@property (nonatomic, assign) CGSize minimumSize;
@property (nonatomic, assign) CGSize constraintSize; // default is 200 * 300 , stautslabel MaxSize

/** 通用提示框 */
+ (AHKToastView *)toastView;
+ (AHKToastView *)toastView:(BOOL)isIntercept;
+ (AHKToastView *)toastViewStyle:(AHKToastHUDMaskType)toastHUDMaskType;

#pragma mark - UI
+ (void)configHudMinimumSize:(CGSize)minimumSize;
+ (void)configHudConstraintSize:(CGSize)constraintSize;

- (void)showLoading:(NSString *)title cancel:(ToastCancel)blockCancel;
- (void)showMessage:(NSString *)title icon:(nullable UIImage *)icon duration:(AHKToastDuration)duration;
- (void)showMessage:(NSString *)title;

- (void)showSuccessWithStatus:(NSString *)status;
- (void)showSuccessWithStatus:(NSString *)status completion:(ToastDismissCompletion)completion;

- (void)showErrorWithStatus:(NSString *)status;
- (void)showErrorWithStatus:(NSString *)status completion:(ToastDismissCompletion)completion;

- (void)showInfoWithStatus:(NSString *)status;
- (void)showInfoWithStatus:(NSString *)status completion:(ToastDismissCompletion)completion;

- (void)showViewHUD:(UIView *)view status: (NSString *)status;

- (void)hide;
- (void)hideWithCompletion:(ToastDismissCompletion)completion;
- (void)hideWithDelay:(NSTimeInterval)delay completion:(ToastDismissCompletion)completion;

- (void)updateMessage:(NSString *)title;

- (NSTimeInterval)displayDurationForString:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
