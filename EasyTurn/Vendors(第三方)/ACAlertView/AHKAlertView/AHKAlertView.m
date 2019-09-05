//
//  AHKAlertView.m
//  AHKit
//
//  Created by OutMan_Coder on 2018/10/24.
//  Copyright © 2018年 AutoHome. All rights reserved.
//

#import "AHKAlertView.h"
#import "LGAlertView.h"
#import "LGAlertView+AHKAlertView.h"

@interface AHKAlertView ()

@property (nonatomic, strong) LGAlertView *alertView;
@property (nonatomic, assign) BOOL didDismissAfterBlock;

@end

@implementation AHKAlertView

#pragma mark - 类方法(初始化方法)
+ (instancetype)alertViewWithTitle:(NSString *)title
                           message:(NSString *)message
                             style:(AHKAlertViewStyle)style
                      buttonTitles:(NSArray *)buttonTitles
                 cancelButtonTitle:(NSString *)cancelButtonTitle
            destructiveButtonTitle:(NSString *)destructiveButtonTitle
                     actionHandler:(AHKAlertViewActionBlock)actionHandler
                     cancelHandler:(AHKAlertViewCancelBlock)cancelHandler
                destructiveHandler:(AHKAlertViewDestructiveBlock)destructiveHandler {
    
    AHKAlertView *alert = [[self alloc] initWithTitle:title
                                             message:message
                                               style:style
                                        buttonTitles:buttonTitles
                                   cancelButtonTitle:cancelButtonTitle
                              destructiveButtonTitle:destructiveButtonTitle
                                       actionHandler:actionHandler
                                       cancelHandler:cancelHandler
                                  destructiveHandler:destructiveHandler];
    alert.didDismissAfterBlock = NO;
    return alert;
}

+ (instancetype)alertViewWithTitle:(NSString *)title
                           message:(NSString *)message
                             style:(AHKAlertViewStyle)style
                      buttonTitles:(NSArray *)buttonTitles
                 cancelButtonTitle:(NSString *)cancelButtonTitle
            destructiveButtonTitle:(NSString *)destructiveButtonTitle
           didDismissActionHandler:(AHKAlertViewActionBlock)didDismissActionHandler
           didDismissCancelHandler:(AHKAlertViewCancelBlock)didDismissCancelHandler
      didDismissDestructiveHandler:(AHKAlertViewDestructiveBlock)didDismissDestructiveHandler {
    AHKAlertView *alert = [[self alloc] initWithTitle:title
                                             message:message
                                               style:style
                                        buttonTitles:buttonTitles
                                   cancelButtonTitle:cancelButtonTitle
                              destructiveButtonTitle:destructiveButtonTitle
                                       actionHandler:didDismissActionHandler
                                       cancelHandler:didDismissCancelHandler
                                  destructiveHandler:didDismissDestructiveHandler];
    alert.didDismissAfterBlock = YES;
    return alert;
}

+ (instancetype)alertViewWithViewAndTitle:(NSString *)title
                                  message:(NSString *)message
                                    style:(AHKAlertViewStyle)style
                                     view:(UIView *)view
                             buttonTitles:(NSArray *)buttonTitles
                        cancelButtonTitle:(NSString *)cancelButtonTitle
                   destructiveButtonTitle:(NSString *)destructiveButtonTitle
                            actionHandler:(AHKAlertViewActionBlock)actionHandler
                            cancelHandler:(AHKAlertViewCancelBlock)cancelHandler
                       destructiveHandler:(AHKAlertViewDestructiveBlock)destructiveHandler {
    AHKAlertView *alert = [[self alloc] initWithViewAndTitle:title
                                                    message:message
                                                      style:style
                                                       view:view
                                               buttonTitles:buttonTitles
                                          cancelButtonTitle:cancelButtonTitle
                                     destructiveButtonTitle:destructiveButtonTitle
                                              actionHandler:actionHandler
                                              cancelHandler:cancelHandler
                                         destructiveHandler:destructiveHandler];
    alert.didDismissAfterBlock = NO;
    return alert;
}

+ (instancetype)alertViewWithViewAndTitle:(NSString *)title
                                  message:(NSString *)message
                                    style:(AHKAlertViewStyle)style
                                     view:(UIView *)view
                             buttonTitles:(NSArray *)buttonTitles
                        cancelButtonTitle:(NSString *)cancelButtonTitle
                   destructiveButtonTitle:(NSString *)destructiveButtonTitle
                  didDismissActionHandler:(AHKAlertViewActionBlock)didDismissActionHandler
                  didDismissCancelHandler:(AHKAlertViewCancelBlock)didDismissCancelHandler
             didDismissDestructiveHandler:(AHKAlertViewDestructiveBlock)didDismissDestructiveHandler {
    AHKAlertView *alert = [[self alloc] initWithViewAndTitle:title
                                                    message:message
                                                      style:style
                                                       view:view
                                               buttonTitles:buttonTitles
                                          cancelButtonTitle:cancelButtonTitle
                                     destructiveButtonTitle:destructiveButtonTitle
                                              actionHandler:didDismissActionHandler
                                              cancelHandler:didDismissCancelHandler
                                         destructiveHandler:didDismissDestructiveHandler];
    alert.didDismissAfterBlock = YES;
    return alert;
}

+ (instancetype)alertViewWithActivityIndicatorAndTitle:(NSString *)title
                                               message:(NSString *)message
                                                 style:(AHKAlertViewStyle)style
                                          buttonTitles:(NSArray *)buttonTitles
                                     cancelButtonTitle:(NSString *)cancelButtonTitle
                                destructiveButtonTitle:(NSString *)destructiveButtonTitle
                                         actionHandler:(AHKAlertViewActionBlock)actionHandler
                                         cancelHandler:(AHKAlertViewCancelBlock)cancelHandler
                                    destructiveHandler:(AHKAlertViewDestructiveBlock)destructiveHandler {
    AHKAlertView *alert = [[self alloc] initWithActivityIndicatorAndTitle:title
                                                                 message:message
                                                                   style:style
                                                            buttonTitles:buttonTitles
                                                       cancelButtonTitle:cancelButtonTitle
                                                  destructiveButtonTitle:destructiveButtonTitle
                                                           actionHandler:actionHandler
                                                           cancelHandler:cancelHandler
                                                      destructiveHandler:destructiveHandler];
    alert.didDismissAfterBlock = NO;
    return alert;
}

+ (instancetype)alertViewWithActivityIndicatorAndTitle:(NSString *)title
                                               message:(NSString *)message
                                                 style:(AHKAlertViewStyle)style
                                          buttonTitles:(NSArray *)buttonTitles
                                     cancelButtonTitle:(NSString *)cancelButtonTitle
                                destructiveButtonTitle:(NSString *)destructiveButtonTitle
                               didDismissActionHandler:(AHKAlertViewActionBlock)didDismissActionHandler
                               didDismissCancelHandler:(AHKAlertViewCancelBlock)didDismissCancelHandler
                          didDismissDestructiveHandler:(AHKAlertViewDestructiveBlock)didDismissDestructiveHandler {
    AHKAlertView *alert = [[self alloc] initWithActivityIndicatorAndTitle:title
                                                                 message:message
                                                                   style:style
                                                            buttonTitles:buttonTitles
                                                       cancelButtonTitle:cancelButtonTitle
                                                  destructiveButtonTitle:destructiveButtonTitle
                                                           actionHandler:didDismissActionHandler
                                                           cancelHandler:didDismissCancelHandler
                                                      destructiveHandler:didDismissDestructiveHandler];
    alert.didDismissAfterBlock = YES;
    return alert;
}

+ (instancetype)alertViewWithProgressViewAndTitle:(NSString *)title
                                          message:(NSString *)message
                                            style:(AHKAlertViewStyle)style
                                progressLabelText:(NSString *)progressLabelText
                                     buttonTitles:(NSArray *)buttonTitles
                                cancelButtonTitle:(NSString *)cancelButtonTitle
                           destructiveButtonTitle:(NSString *)destructiveButtonTitle
                                    actionHandler:(AHKAlertViewActionBlock)actionHandler
                                    cancelHandler:(AHKAlertViewCancelBlock)cancelHandler
                               destructiveHandler:(AHKAlertViewDestructiveBlock)destructiveHandler {
    AHKAlertView *alert = [[self alloc] initWithProgressViewAndTitle:title
                                                            message:message
                                                              style:style
                                                  progressLabelText:progressLabelText
                                                       buttonTitles:buttonTitles
                                                  cancelButtonTitle:cancelButtonTitle
                                             destructiveButtonTitle:destructiveButtonTitle
                                                      actionHandler:actionHandler
                                                      cancelHandler:cancelHandler
                                                 destructiveHandler:destructiveHandler];
    alert.didDismissAfterBlock = NO;
    return alert;
}

+ (instancetype)alertViewWithProgressViewAndTitle:(NSString *)title
                                          message:(NSString *)message
                                            style:(AHKAlertViewStyle)style
                                progressLabelText:(NSString *)progressLabelText
                                     buttonTitles:(NSArray *)buttonTitles
                                cancelButtonTitle:(NSString *)cancelButtonTitle
                           destructiveButtonTitle:(NSString *)destructiveButtonTitle
                          didDismissActionHandler:(AHKAlertViewActionBlock)didDismissActionHandler
                          didDismissCancelHandler:(AHKAlertViewCancelBlock)didDismissCancelHandler
                     didDismissDestructiveHandler:(AHKAlertViewDestructiveBlock)didDismissDestructiveHandler {
    AHKAlertView *alert = [[self alloc] initWithProgressViewAndTitle:title
                                                            message:message
                                                              style:style
                                                  progressLabelText:progressLabelText
                                                       buttonTitles:buttonTitles
                                                  cancelButtonTitle:cancelButtonTitle
                                             destructiveButtonTitle:destructiveButtonTitle
                                                      actionHandler:didDismissActionHandler
                                                      cancelHandler:didDismissCancelHandler
                                                 destructiveHandler:didDismissDestructiveHandler];
    alert.didDismissAfterBlock = YES;
    return alert;
}

#pragma mark - Only Cancel Button
+ (instancetype)alertViewWithTitle:(NSString *)title
                           message:(NSString *)message
                             style:(AHKAlertViewStyle)style
                 cancelButtonTitle:(NSString *)cancelButtonTitle {
    return [[self alloc] initWithTitle:title
                               message:message
                                 style:style
                          buttonTitles:nil
                     cancelButtonTitle:cancelButtonTitle
                destructiveButtonTitle:nil
                         actionHandler:nil
                         cancelHandler:nil
                    destructiveHandler:nil];
}

+ (instancetype)alertViewWithViewAndTitle:(NSString *)title
                                  message:(NSString *)message
                                    style:(AHKAlertViewStyle)style
                                     view:(UIView *)view
                        cancelButtonTitle:(NSString *)cancelButtonTitle {
    return [[self alloc] initWithViewAndTitle:title
                                      message:message
                                        style:style
                                         view:view
                                 buttonTitles:nil
                            cancelButtonTitle:cancelButtonTitle
                       destructiveButtonTitle:nil
                                actionHandler:nil
                                cancelHandler:nil
                           destructiveHandler:nil];
}

+ (instancetype)alertViewWithActivityIndicatorAndTitle:(NSString *)title
                                               message:(NSString *)message
                                                 style:(AHKAlertViewStyle)style
                                     cancelButtonTitle:(NSString *)cancelButtonTitle {
    return [[self alloc] initWithActivityIndicatorAndTitle:title
                                                   message:message
                                                     style:style
                                              buttonTitles:nil
                                         cancelButtonTitle:cancelButtonTitle
                                    destructiveButtonTitle:nil
                                             actionHandler:nil
                                             cancelHandler:nil
                                        destructiveHandler:nil];
}

+ (instancetype)alertViewWithProgressViewAndTitle:(NSString *)title
                                          message:(NSString *)message
                                            style:(AHKAlertViewStyle)style
                                progressLabelText:(NSString *)progressLabelText
                                cancelButtonTitle:(NSString *)cancelButtonTitle {
    return [[self alloc] initWithProgressViewAndTitle:title
                                              message:message
                                                style:style
                                    progressLabelText:progressLabelText
                                         buttonTitles:nil
                                    cancelButtonTitle:cancelButtonTitle
                               destructiveButtonTitle:nil
                                        actionHandler:nil
                                        cancelHandler:nil
                                   destructiveHandler:nil];
}

#pragma mark - 类方法(全局UI配置)
+ (void)alertConfigLayerCornerRadius:(CGFloat)layerCornerRadius {
    [[LGAlertView appearance] setLayerCornerRadius:layerCornerRadius];
}

+ (void)alertConfigCancelOnTouch:(BOOL)cancelOnTouch {
    [[LGAlertView appearance] setCancelOnTouch:cancelOnTouch];
}

+ (void)alertConfigTitleNumberOfLines:(NSInteger) titleNumberOfLines {
    [[LGAlertView appearance] setTitleNumberOfLines: titleNumberOfLines];
}

+ (void)alertConfigSeparatorsColor:(UIColor *)separatorsColor {
    [[LGAlertView appearance] setSeparatorsColor:separatorsColor];
}

+ (void)alertConfigWidth:(CGFloat)width {
    [[LGAlertView appearance] setWidth:width];
}

+ (void)alertConfigTitleTextColor:(UIColor *)titleTextColor {
    [[LGAlertView appearance] setTitleTextColor:titleTextColor];
}

+ (void)alertConfigTitleFont:(UIFont *)titleFont {
    [[LGAlertView appearance] setTitleFont:titleFont];
}

+ (void)alertConfigMessageTextColor:(UIColor *)messageTextColor {
    [[LGAlertView appearance] setMessageTextColor:messageTextColor];
}

+ (void)alertConfigMessageFont:(UIFont *)messageFont {
    [[LGAlertView appearance] setMessageFont:messageFont];
}

+ (void)alertConfigButtonsFont:(UIFont *)buttonsFont {
    [[LGAlertView appearance] setButtonsFont:buttonsFont];
}

+ (void)alertConfigButtonsTitleColor:(UIColor *)buttonsTitleColor {
    [[LGAlertView appearance] setButtonsTitleColor:buttonsTitleColor];
}

+ (void)alertConfigButtonsTitleColorHighlighted:(UIColor *)buttonsTitleColorHighlighted {
    [[LGAlertView appearance] setButtonsTitleColorHighlighted: buttonsTitleColorHighlighted];
}

+ (void)alertConfigButtonsBackgroundColorHighlighted:(UIColor *)buttonsBackgroundColorHighlighted {
    [[LGAlertView appearance] setButtonsBackgroundColorHighlighted:buttonsBackgroundColorHighlighted];
}

+ (void)alertConfigCancelButtonFont:(UIFont *)cancelButtonFont {
    [[LGAlertView appearance] setCancelButtonFont:cancelButtonFont];
}

+ (void)alertConfigCancelButtonTitleColor:(UIColor *)cancelButtonTitleColor {
    [[LGAlertView appearance] setCancelButtonTitleColor:cancelButtonTitleColor];
}

+ (void)alertConfigCancelButtonTitleColorHighlighted:(UIColor *)cancelButtonTitleColorHighlighted {
    [[LGAlertView appearance] setCancelButtonTitleColorHighlighted:cancelButtonTitleColorHighlighted];
}

+ (void)alertConfigCancelButtonBackgroundColorHighlighted:(UIColor *)cancelButtonBackgroundColorHighlighted {
    [[LGAlertView appearance] setCancelButtonBackgroundColorHighlighted:cancelButtonBackgroundColorHighlighted];
}

+ (void)alertConfigDestructiveButtonFont:(UIFont *)destructiveButtonFont {
    [[LGAlertView appearance] setDestructiveButtonFont:destructiveButtonFont];
}

+ (void)alertConfigDestructiveButtonTitleColor:(UIColor *)destructiveButtonTitleColor {
    [[LGAlertView appearance] setDestructiveButtonTitleColor:destructiveButtonTitleColor];
}

+ (void)alertConfigDestructiveButtonTitleColorHighlighted:(UIColor *)destructiveButtonTitleColorHighlighted {
    [[LGAlertView appearance] setDestructiveButtonTitleColorHighlighted:destructiveButtonTitleColorHighlighted];
}

+ (void)alertConfigDestructiveButtonBackgroundColorHighlighted:(UIColor *)destructiveButtonBackgroundColorHighlighted {
    [[LGAlertView appearance] setDestructiveButtonBackgroundColorHighlighted:destructiveButtonBackgroundColorHighlighted];
}

#pragma mark - UIAppearance
+ (instancetype)appearance {
    return [self sharedAlertViewForAppearance];
}

+ (instancetype)appearanceWhenContainedIn:(Class<UIAppearanceContainer>)ContainerClass, ... {
    return [self sharedAlertViewForAppearance];
}

+ (instancetype)appearanceForTraitCollection:(UITraitCollection *)trait {
    return [self sharedAlertViewForAppearance];
}

+ (instancetype)appearanceForTraitCollection:(UITraitCollection *)trait whenContainedIn:(Class<UIAppearanceContainer>)ContainerClass, ... {
    return [self sharedAlertViewForAppearance];
}

+ (instancetype)sharedAlertViewForAppearance {
    static AHKAlertView *alertView;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        alertView = [[AHKAlertView alloc] initAsAppearance];
    });
    
    return alertView;
}

#pragma mark - 对象方法
- (nonnull instancetype)initAsAppearance {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)message
                        style:(AHKAlertViewStyle)style
                 buttonTitles:(NSArray *)buttonTitles
            cancelButtonTitle:(NSString *)cancelButtonTitle
       destructiveButtonTitle:(NSString *)destructiveButtonTitle
                actionHandler:(AHKAlertViewActionBlock)actionHandler
                cancelHandler:(AHKAlertViewCancelBlock)cancelHandler
           destructiveHandler:(AHKAlertViewDestructiveBlock)destructiveHandler {
    self = [super init];
    if (self) {
        
        LGAlertViewStyle lgStyle = (style == AHKAlertViewStyleAlert) ? LGAlertViewStyleAlert : LGAlertViewStyleActionSheet;
        _alertView = [[LGAlertView alloc] initWithTitle:title
                                                message:message
                                                  style:lgStyle
                                           buttonTitles:buttonTitles
                                      cancelButtonTitle:cancelButtonTitle
                                 destructiveButtonTitle:destructiveButtonTitle
                                          actionHandler:^(LGAlertView * _Nonnull alertView, NSUInteger index, NSString * _Nullable title) {
                                              if (!alertView.didDismissAfterBlock) {
                                                  if (actionHandler) actionHandler(title, index);
                                              }
                                          } cancelHandler:^(LGAlertView * _Nonnull alertView) {
                                              if (!alertView.didDismissAfterBlock) {
                                                  if (cancelHandler) cancelHandler();
                                              }
                                          } destructiveHandler:^(LGAlertView * _Nonnull alertView) {
                                              if (!alertView.didDismissAfterBlock) {
                                                  if (destructiveHandler) destructiveHandler();
                                              }
                                          }];
        _alertView.didDismissAfterActionHandler = ^(LGAlertView * _Nonnull alertView, NSUInteger index, NSString * _Nullable title) {
            if (alertView.didDismissAfterBlock) {
                if (actionHandler) actionHandler(title,index);
            }
        };
        _alertView.didDismissAfterCancelHandler = ^(LGAlertView * _Nonnull alertView) {
            if (alertView.didDismissAfterBlock) {
                if (cancelHandler) cancelHandler();
            }
        };
        _alertView.didDismissAfterDestructiveHandler = ^(LGAlertView * _Nonnull alertView) {
            if (alertView.didDismissAfterBlock) {
                if (destructiveHandler) destructiveHandler();
            }
        };
    }
    return self;
}

- (instancetype)initWithViewAndTitle:(NSString *)title
                             message:(NSString *)message
                               style:(AHKAlertViewStyle)style
                                view:(UIView *)view
                        buttonTitles:(NSArray *)buttonTitles
                   cancelButtonTitle:(NSString *)cancelButtonTitle
              destructiveButtonTitle:(NSString *)destructiveButtonTitle
                       actionHandler:(AHKAlertViewActionBlock)actionHandler
                       cancelHandler:(AHKAlertViewCancelBlock)cancelHandler
                  destructiveHandler:(AHKAlertViewDestructiveBlock)destructiveHandler {
    self = [super init];
    if (self) {
        
        LGAlertViewStyle lgStyle = (style == AHKAlertViewStyleAlert) ? LGAlertViewStyleAlert : LGAlertViewStyleActionSheet;
        _alertView = [[LGAlertView alloc] initWithViewAndTitle:title
                                                       message:message
                                                         style:lgStyle
                                                          view:view
                                                  buttonTitles:buttonTitles
                                             cancelButtonTitle:cancelButtonTitle
                                        destructiveButtonTitle:destructiveButtonTitle
                                                 actionHandler:^(LGAlertView * _Nonnull alertView, NSUInteger index, NSString * _Nullable title) {
                                                     if (!alertView.didDismissAfterBlock) {
                                                         if (actionHandler) actionHandler(title, index);
                                                     }
                                                     
                                                 } cancelHandler:^(LGAlertView * _Nonnull alertView) {
                                                     if (!alertView.didDismissAfterBlock) {
                                                         if (cancelHandler) cancelHandler();
                                                     }
                                                     
                                                 } destructiveHandler:^(LGAlertView * _Nonnull alertView) {
                                                     if (!alertView.didDismissAfterBlock) {
                                                         if (destructiveHandler) destructiveHandler();
                                                     }
                                                     
                                                 }];
        
        _alertView.didDismissAfterActionHandler = ^(LGAlertView * _Nonnull alertView, NSUInteger index, NSString * _Nullable title) {
            if (alertView.didDismissAfterBlock) {
                if (actionHandler) actionHandler(title,index);
            }
        };
        _alertView.didDismissAfterCancelHandler = ^(LGAlertView * _Nonnull alertView) {
            if (alertView.didDismissAfterBlock) {
                if (cancelHandler) cancelHandler();
            }
        };
        _alertView.didDismissAfterDestructiveHandler = ^(LGAlertView * _Nonnull alertView) {
            if (alertView.didDismissAfterBlock) {
                if (destructiveHandler) destructiveHandler();
            }
        };
    }
    return self;
}

- (instancetype)initWithActivityIndicatorAndTitle:(NSString *)title
                                          message:(NSString *)message
                                            style:(AHKAlertViewStyle)style
                                     buttonTitles:(NSArray *)buttonTitles
                                cancelButtonTitle:(NSString *)cancelButtonTitle
                           destructiveButtonTitle:(NSString *)destructiveButtonTitle
                                    actionHandler:(AHKAlertViewActionBlock)actionHandler
                                    cancelHandler:(AHKAlertViewCancelBlock)cancelHandler
                               destructiveHandler:(AHKAlertViewDestructiveBlock)destructiveHandler {
    self = [super init];
    if (self) {
        
        LGAlertViewStyle lgStyle = (style == AHKAlertViewStyleAlert) ? LGAlertViewStyleAlert : LGAlertViewStyleActionSheet;
        _alertView = [[LGAlertView alloc] initWithActivityIndicatorAndTitle:title
                                                                    message:message
                                                                      style:lgStyle
                                                               buttonTitles:buttonTitles
                                                          cancelButtonTitle:cancelButtonTitle
                                                     destructiveButtonTitle:destructiveButtonTitle
                                                              actionHandler:^(LGAlertView * _Nonnull alertView, NSUInteger index, NSString * _Nullable title) {
                                                                  if (!alertView.didDismissAfterBlock) {
                                                                      if (actionHandler) actionHandler(title, index);
                                                                  }
                                                              } cancelHandler:^(LGAlertView * _Nonnull alertView) {
                                                                  if (!alertView.didDismissAfterBlock) {
                                                                      if (cancelHandler) cancelHandler();
                                                                  }
                                                              } destructiveHandler:^(LGAlertView * _Nonnull alertView) {
                                                                  if (!alertView.didDismissAfterBlock) {
                                                                      if (destructiveHandler) destructiveHandler();
                                                                  }
                                                              }];
        _alertView.didDismissAfterActionHandler = ^(LGAlertView * _Nonnull alertView, NSUInteger index, NSString * _Nullable title) {
            if (alertView.didDismissAfterBlock) {
                if (actionHandler) actionHandler(title,index);
            }
        };
        _alertView.didDismissAfterCancelHandler = ^(LGAlertView * _Nonnull alertView) {
            if (alertView.didDismissAfterBlock) {
                if (cancelHandler) cancelHandler();
            }
        };
        _alertView.didDismissAfterDestructiveHandler = ^(LGAlertView * _Nonnull alertView) {
            if (alertView.didDismissAfterBlock) {
                if (destructiveHandler) destructiveHandler();
            }
        };
    }
    return self;
}

- (instancetype)initWithProgressViewAndTitle:(NSString *)title
                                     message:(NSString *)message
                                       style:(AHKAlertViewStyle)style
                           progressLabelText:(NSString *)progressLabelText
                                buttonTitles:(NSArray *)buttonTitles
                           cancelButtonTitle:(NSString *)cancelButtonTitle
                      destructiveButtonTitle:(NSString *)destructiveButtonTitle
                               actionHandler:(AHKAlertViewActionBlock)actionHandler
                               cancelHandler:(AHKAlertViewCancelBlock)cancelHandler
                          destructiveHandler:(AHKAlertViewDestructiveBlock)destructiveHandler {
    self = [super init];
    if (self) {
        
        LGAlertViewStyle lgStyle = (style == AHKAlertViewStyleAlert) ? LGAlertViewStyleAlert : LGAlertViewStyleActionSheet;
        _alertView = [[LGAlertView alloc] initWithProgressViewAndTitle:title
                                                               message:message
                                                                 style:lgStyle
                                                     progressLabelText:progressLabelText
                                                          buttonTitles:buttonTitles
                                                     cancelButtonTitle:cancelButtonTitle
                                                destructiveButtonTitle:destructiveButtonTitle
                                                         actionHandler:^(LGAlertView * _Nonnull alertView, NSUInteger index, NSString * _Nullable title) {
                                                             if (!alertView.didDismissAfterBlock) {
                                                                 if (actionHandler) actionHandler(title, index);
                                                             }
                                                         } cancelHandler:^(LGAlertView * _Nonnull alertView) {
                                                             if (!alertView.didDismissAfterBlock) {
                                                                 if (cancelHandler) cancelHandler();
                                                             }
                                                         } destructiveHandler:^(LGAlertView * _Nonnull alertView) {
                                                             if (!alertView.didDismissAfterBlock) {
                                                                 if (destructiveHandler) destructiveHandler();
                                                             }
                                                         }];
        _alertView.didDismissAfterActionHandler = ^(LGAlertView * _Nonnull alertView, NSUInteger index, NSString * _Nullable title) {
            if (alertView.didDismissAfterBlock) {
                if (actionHandler) actionHandler(title,index);
            }
        };
        _alertView.didDismissAfterCancelHandler = ^(LGAlertView * _Nonnull alertView) {
            if (alertView.didDismissAfterBlock) {
                if (cancelHandler) cancelHandler();
            }
        };
        _alertView.didDismissAfterDestructiveHandler = ^(LGAlertView * _Nonnull alertView) {
            if (alertView.didDismissAfterBlock) {
                if (destructiveHandler) destructiveHandler();
            }
        };
    }
    return self;
}

#pragma mark -
- (void)showAnimated:(BOOL)animated completionHandler:(void(^)(void))completionHandler {
    [_alertView showAnimated:animated completionHandler:completionHandler];
}

- (void)dismissAnimated:(BOOL)animated completionHandler:(void(^)(void))completionHandler {
    [_alertView dismissAnimated:animated completionHandler:completionHandler];
}

- (void)transitionToAlertView:(AHKAlertView *)alertView completionHandler:(void(^)(void))completionHandler {
//    [_alertView dismissAnimated:YES completionHandler:^{
//        [alertView showAnimated:YES completionHandler:completionHandler];
//    }];
    [_alertView transitionToAlertView:alertView.alert completionHandler:completionHandler];
}

- (void)setProgress:(float)progress progressLabelText:(NSString *)progressLabelText {
    [_alertView setProgress:progress progressLabelText:progressLabelText];
}

- (void)setButtonAtIndex:(NSUInteger)index enabled:(BOOL)enabled {
    [_alertView setButtonEnabled:enabled atIndex:index];
}

- (BOOL)isButtonEnabledAtIndex:(NSUInteger)index {
    return [_alertView isButtonEnabledAtIndex:index];
}

- (void)forceCancel {
    [_alertView forceCancel];
}

- (void)forceDestructive {
    [_alertView forceDestructive];
}

- (void)forceActionAtIndex:(NSUInteger)index {
    [_alertView forceActionAtIndex:index];
}

- (void)setButtonPropertiesAtIndex:(NSUInteger)index handler:(void(^)(LGAlertViewButtonProperties *properties))handler {
    if (handler) {
        [_alertView setButtonPropertiesAtIndex:index handler:^(LGAlertViewButtonProperties * _Nonnull properties) {
            handler(properties);
        }];
    }
}

#pragma mark - Setter And Getter
- (void)setDidDismissAfterBlock:(BOOL)didDismissAfterBlock {
    _didDismissAfterBlock = didDismissAfterBlock;
    _alertView.didDismissAfterBlock = _didDismissAfterBlock;
}

- (id)alert {
    return _alertView;
}

- (void)setWidth:(CGFloat)width {
    _width = width;
    _alertView.width = width;
}

- (BOOL)cancelOnTouch {
    return _alertView.cancelOnTouch;
}

- (void)setCancelOnTouch:(BOOL)cancelOnTouch {
    [_alertView setCancelOnTouch:cancelOnTouch];
}

- (BOOL)dismissOnAction {
    return _alertView.dismissOnAction;
}

- (void)setDismissOnAction:(BOOL)dismissOnAction {
    [_alertView setDismissOnAction:dismissOnAction];
}

- (void)setTitleTextColor:(UIColor *)titleTextColor {
    _titleTextColor = titleTextColor;
    [_alertView setTitleTextColor:titleTextColor];
}


- (void)setTitleTextAlignment:(NSTextAlignment)titleTextAlignment {
    _titleTextAlignment = titleTextAlignment;
    [_alertView setTitleTextAlignment:titleTextAlignment];
}

- (void)setTitleFont:(UIFont *)titleFont {
    _titleFont = titleFont;
    [_alertView setTitleFont:titleFont];
}

- (NSString *)message {
    return _alertView.message;
}

- (void)setMessageTextColor:(UIColor *)messageTextColor {
    _messageTextColor = messageTextColor;
    [_alertView setMessageTextColor:messageTextColor];
}


- (void)setMessageTextAlignment:(NSTextAlignment)messageTextAlignment {
    _messageTextAlignment = messageTextAlignment;
    [_alertView setMessageTextAlignment:messageTextAlignment];
}

- (void)setMessageFont:(UIFont *)messageFont {
    _messageFont = messageFont;
    [_alertView setMessageFont:messageFont];
}

- (NSArray *)buttonTitles {
    return _alertView.buttonTitles;
}

- (void)setButtonsTitleColor:(UIColor *)buttonsTitleColor {
    _buttonsTitleColor = buttonsTitleColor;
    [_alertView setButtonsTitleColor:buttonsTitleColor];
}

- (void)setButtonsTitleColorHighlighted:(UIColor *)buttonsTitleColorHighlighted {
    _buttonsTitleColorHighlighted = buttonsTitleColorHighlighted;
    [_alertView setButtonsTitleColorHighlighted:buttonsTitleColorHighlighted];
}

- (void)setButtonsTitleColorDisabled:(UIColor *)buttonsTitleColorDisabled {
    _buttonsTitleColorDisabled = buttonsTitleColorDisabled;
    [_alertView setButtonsTitleColorDisabled:buttonsTitleColorDisabled];
}

- (void)setButtonsBackgroundColor:(UIColor *)buttonsBackgroundColor {
    _buttonsBackgroundColor = buttonsBackgroundColor;
    [_alertView setButtonsBackgroundColor:buttonsBackgroundColor];
}

- (void)setButtonsBackgroundColorHighlighted:(UIColor *)buttonsBackgroundColorHighlighted {
    _buttonsBackgroundColorHighlighted = buttonsBackgroundColorHighlighted;
    [_alertView setButtonsBackgroundColorHighlighted:buttonsBackgroundColorHighlighted];
}

- (void)setButtonsBackgroundColorDisabled:(UIColor *)buttonsBackgroundColorDisabled {
    _buttonsBackgroundColorDisabled = buttonsBackgroundColorDisabled;
    [_alertView setButtonsBackgroundColorDisabled:buttonsBackgroundColorDisabled];
}

- (void)setButtonsFont:(UIFont *)buttonsFont {
    _buttonsFont = buttonsFont;
    [_alertView setButtonsFont:buttonsFont];
}

- (void)setCancelButtonTitleColor:(UIColor *)cancelButtonTitleColor {
    _cancelButtonTitleColor = cancelButtonTitleColor;
    [_alertView setCancelButtonTitleColor:cancelButtonTitleColor];
}

- (void)setCancelButtonTitleColorHighlighted:(UIColor *)cancelButtonTitleColorHighlighted {
    _cancelButtonTitleColorHighlighted = cancelButtonTitleColorHighlighted;
    [_alertView setCancelButtonTitleColorHighlighted:cancelButtonTitleColorHighlighted];
}

- (void)setCancelButtonTitleColorDisabled:(UIColor *)cancelButtonTitleColorDisabled {
    _cancelButtonTitleColorDisabled = cancelButtonTitleColorDisabled;
    [_alertView setCancelButtonTitleColorDisabled:cancelButtonTitleColorDisabled];
}

- (void)setCancelButtonBackgroundColor:(UIColor *)cancelButtonBackgroundColor {
    _cancelButtonBackgroundColor = cancelButtonBackgroundColor;
    [_alertView setCancelButtonBackgroundColor:cancelButtonBackgroundColor];
}

- (void)setCancelButtonBackgroundColorHighlighted:(UIColor *)cancelButtonBackgroundColorHighlighted {
    _cancelButtonBackgroundColorHighlighted = cancelButtonBackgroundColorHighlighted;
    [_alertView setCancelButtonBackgroundColorHighlighted:cancelButtonBackgroundColorHighlighted];
}

- (void)setCancelButtonBackgroundColorDisabled:(UIColor *)cancelButtonBackgroundColorDisabled {
    _cancelButtonBackgroundColorDisabled = cancelButtonBackgroundColorDisabled;
    [_alertView setCancelButtonBackgroundColorDisabled:cancelButtonBackgroundColorDisabled];
}

- (void)setCancelButtonFont:(UIFont *)cancelButtonFont {
    _cancelButtonFont = cancelButtonFont;
    [_alertView setCancelButtonFont:cancelButtonFont];
}

- (NSString *)destructiveButtonTitle {
    return _alertView.destructiveButtonTitle;
}

- (void)setDestructiveButtonTitleColor:(UIColor *)destructiveButtonTitleColor {
    _destructiveButtonTitleColor = destructiveButtonTitleColor;
    [_alertView setDestructiveButtonTitleColor:destructiveButtonTitleColor];
}

- (void)setDestructiveButtonTitleColorHighlighted:(UIColor *)destructiveButtonTitleColorHighlighted {
    _destructiveButtonTitleColorHighlighted = destructiveButtonTitleColorHighlighted;
    [_alertView setDestructiveButtonTitleColorHighlighted:destructiveButtonTitleColorHighlighted];
}


- (void)setDestructiveButtonTitleColorDisabled:(UIColor *)destructiveButtonTitleColorDisabled {
    _destructiveButtonTitleColorDisabled = destructiveButtonTitleColorDisabled;
    [_alertView setDestructiveButtonTitleColorDisabled:destructiveButtonTitleColorDisabled];
}

- (void)setDestructiveButtonBackgroundColor:(UIColor *)destructiveButtonBackgroundColor {
    _destructiveButtonBackgroundColor = destructiveButtonBackgroundColor;
    [_alertView setDestructiveButtonBackgroundColor:destructiveButtonBackgroundColor];
}

- (void)setDestructiveButtonBackgroundColorHighlighted:(UIColor *)destructiveButtonBackgroundColorHighlighted {
    _destructiveButtonBackgroundColorHighlighted = destructiveButtonBackgroundColorHighlighted;
    [_alertView setDestructiveButtonBackgroundColorHighlighted:destructiveButtonBackgroundColorHighlighted];
}

- (void)setDestructiveButtonBackgroundColorDisabled:(UIColor *)destructiveButtonBackgroundColorDisabled {
    _destructiveButtonBackgroundColorDisabled = destructiveButtonBackgroundColorDisabled;
    [_alertView setDestructiveButtonBackgroundColorDisabled:destructiveButtonBackgroundColorDisabled];
}


- (void)setDestructiveButtonFont:(UIFont *)destructiveButtonFont {
    _destructiveButtonFont = destructiveButtonFont;
    [_alertView setDestructiveButtonFont:destructiveButtonFont];
}

- (void)setActivityIndicatorViewStyle:(UIActivityIndicatorViewStyle)activityIndicatorViewStyle {
    _activityIndicatorViewStyle = activityIndicatorViewStyle;
    [_alertView setActivityIndicatorViewStyle:activityIndicatorViewStyle];
}

- (void)setActivityIndicatorViewColor:(UIColor *)activityIndicatorViewColor {
    _activityIndicatorViewColor = activityIndicatorViewColor;
    [_alertView setActivityIndicatorViewColor:activityIndicatorViewColor];
}

- (void)setProgressViewProgressTintColor:(UIColor *)progressViewProgressTintColor {
    _progressViewProgressTintColor = progressViewProgressTintColor;
    [_alertView setProgressViewProgressTintColor:progressViewProgressTintColor];
}

- (void)setProgressViewTrackTintColor:(UIColor *)progressViewTrackTintColor {
    _progressViewTrackTintColor = progressViewTrackTintColor;
    [_alertView setProgressViewTrackTintColor:progressViewTrackTintColor];
}

- (void)setProgressViewProgressImage:(UIImage *)progressViewProgressImage {
    _progressViewProgressImage = progressViewProgressImage;
    [_alertView setProgressViewProgressImage:progressViewProgressImage];
}

- (void)setProgressViewTrackImage:(UIImage *)progressViewTrackImage {
    _progressViewTrackImage = progressViewTrackImage;
    [_alertView setProgressViewTrackImage:progressViewTrackImage];
}

- (void)setProgressLabelTextColor:(UIColor *)progressLabelTextColor {
    _progressLabelTextColor = progressLabelTextColor;
    [_alertView setProgressLabelTextColor:progressLabelTextColor];
}

- (void)setProgressLabelTextAlignment:(NSTextAlignment)progressLabelTextAlignment {
    _progressLabelTextAlignment = progressLabelTextAlignment;
    [_alertView setProgressLabelTextAlignment:progressLabelTextAlignment];
}

- (void)setProgressLabelFont:(UIFont *)progressLabelFont {
    _progressLabelFont = progressLabelFont;
    [_alertView setProgressLabelFont:progressLabelFont];
}

- (void)setSeparatorsColor:(UIColor *)separatorsColor {
    _separatorsColor = separatorsColor;
    [_alertView setSeparatorsColor:separatorsColor];
}

- (void)setPadShowsActionSheetFromBottom:(BOOL)padShowActionSheetFromBottom {
    [_alertView setPadShowsActionSheetFromBottom:padShowActionSheetFromBottom];
}

- (void)setOneRowOneButton:(BOOL)oneRowOneButton {
    _oneRowOneButton = oneRowOneButton;
    [_alertView setOneRowOneButton:oneRowOneButton];
}

- (void)setCancelButtonEnabled:(BOOL)cancelButtonEnabled {
    _cancelButtonEnabled = cancelButtonEnabled;
    _alertView.cancelButtonEnabled = cancelButtonEnabled;
}

- (void)setCancelButtonTitle:(NSString *)cancelButtonTitle {
    [_alertView.cancelButton setTitle:cancelButtonTitle forState:UIControlStateNormal];
}

- (NSString *)cancelButtonTitle {
    return _alertView.cancelButtonTitle;
}

- (void)setDidDismissAfterActionHandler:(AHKAlertViewActionBlock)didDismissAfterActionHandler {
    if (didDismissAfterActionHandler) {
        _alertView.didDismissAfterActionHandler = ^(LGAlertView * _Nonnull alertView, NSUInteger index, NSString * _Nullable title) {
            didDismissAfterActionHandler(title,index);
        };
    }
}

- (void)setDidDismissAfterCancelHandler:(AHKAlertViewCancelBlock)didDismissAfterCancelHandler {
    if (didDismissAfterCancelHandler) {
        _alertView.didDismissAfterCancelHandler = ^(LGAlertView * _Nonnull alertView) {
            didDismissAfterCancelHandler();
        };
    }
}

- (void)setDidDismissAfterDestructiveHandler:(AHKAlertViewCancelBlock)didDismissAfterDestructiveHandler {
    if (didDismissAfterDestructiveHandler) {
        _alertView.didDismissAfterDestructiveHandler = ^(LGAlertView * _Nonnull alertView) {
            didDismissAfterDestructiveHandler();
        };
    }
}

#pragma mark - Dealloc
- (void)dealloc {
    
}

@end
