//
//  AHKAlertView.h
//  AHKit
//
//  Created by OutMan_Coder on 2018/10/24.
//  Copyright © 2018年 AutoHome. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LGAlertViewButtonProperties.h"

typedef void(^AHKAlertViewActionBlock)(NSString *title, NSUInteger index);
typedef void(^AHKAlertViewCancelBlock)(void);
typedef void(^AHKAlertViewDestructiveBlock)(void);

/**
 *  AlertView 样式
 */
typedef NS_ENUM(NSUInteger, AHKAlertViewStyle) {
    /**
     *   Alert 弹出框样式
     */
    AHKAlertViewStyleAlert = 0,
    /**
     *   Action Sheet 样式
     */
    AHKAlertViewStyleActionSheet = 1
};

@interface AHKAlertView : NSObject <UIAppearance>

@property (nonatomic, strong, readonly) id alert;
#pragma mark - UI Config
/**
 Default:
 if (style == LGAlertViewStyleAlert) then 280.0
 else if (iPad) then 304.0
 else window.width - 16.0
 */
@property (nonatomic, assign) CGFloat width UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) BOOL cancelOnTouch;
@property (nonatomic, assign) BOOL dismissOnAction;
@property (nonatomic, strong) UIColor         *titleTextColor;
@property (nonatomic, assign) NSTextAlignment titleTextAlignment;
/** Default is 0 */
@property (nonatomic, assign) NSInteger titleNumberOfLines;
@property (strong, nonatomic) UIFont          *titleFont;

#pragma mark - Message Properties
@property (nonatomic, copy, readonly) NSString *message;
@property (nonatomic, strong) UIColor         *messageTextColor;
@property (nonatomic, assign) NSTextAlignment messageTextAlignment;
@property (nonatomic, strong) UIFont          *messageFont;

@property (nonatomic, strong, readonly) NSArray *buttonTitles;
@property (nonatomic, strong) UIColor         *buttonsTitleColor;
@property (nonatomic, strong) UIColor         *buttonsTitleColorHighlighted;
@property (nonatomic, strong) UIColor         *buttonsTitleColorDisabled;
@property (nonatomic, strong) UIColor         *buttonsBackgroundColor;
@property (nonatomic, strong) UIColor         *buttonsBackgroundColorHighlighted;
@property (nonatomic, strong) UIColor         *buttonsBackgroundColorDisabled;
@property (nonatomic, strong) UIFont          *buttonsFont;

@property (nonatomic, assign, getter=isCancelButtonEnabled) BOOL cancelButtonEnabled;
@property (nonatomic, strong) NSString        *cancelButtonTitle;
@property (nonatomic, strong) UIColor         *cancelButtonTitleColor;
@property (nonatomic, strong) UIColor         *cancelButtonTitleColorHighlighted;
@property (nonatomic, strong) UIColor         *cancelButtonTitleColorDisabled;
@property (nonatomic, strong) UIColor         *cancelButtonBackgroundColor;
@property (nonatomic, strong) UIColor         *cancelButtonBackgroundColorHighlighted;
@property (nonatomic, strong) UIColor         *cancelButtonBackgroundColorDisabled;
@property (nonatomic, strong) UIFont          *cancelButtonFont;

@property (nonatomic, copy, readonly) NSString *destructiveButtonTitle;
@property (nonatomic, strong) UIColor         *destructiveButtonTitleColor;
@property (nonatomic, strong) UIColor         *destructiveButtonTitleColorHighlighted;
@property (nonatomic, strong) UIColor         *destructiveButtonTitleColorDisabled;
@property (nonatomic, strong) UIColor         *destructiveButtonBackgroundColor;
@property (nonatomic, strong) UIColor         *destructiveButtonBackgroundColorHighlighted;
@property (nonatomic, strong) UIColor         *destructiveButtonBackgroundColorDisabled;
@property (nonatomic, strong) UIFont          *destructiveButtonFont;

@property (nonatomic, assign) UIActivityIndicatorViewStyle activityIndicatorViewStyle;
@property (nonatomic, strong) UIColor                      *activityIndicatorViewColor;

@property (nonatomic, strong) UIColor         *progressViewProgressTintColor;
@property (nonatomic, strong) UIColor         *progressViewTrackTintColor;
@property (nonatomic, strong) UIImage         *progressViewProgressImage;
@property (nonatomic, strong) UIImage         *progressViewTrackImage;
@property (nonatomic, strong) UIColor         *progressLabelTextColor;
@property (nonatomic, assign) NSTextAlignment progressLabelTextAlignment;
@property (nonatomic, strong) UIFont          *progressLabelFont;
@property (nonatomic, assign, readonly) float progress;

@property (nonatomic, strong) UIColor *separatorsColor;

@property (nonatomic, assign) BOOL padShowsActionSheetFromBottom;
@property (nonatomic, assign) BOOL oneRowOneButton;

@property (nonatomic, copy) AHKAlertViewActionBlock didDismissAfterActionHandler;
@property (nonatomic, copy) AHKAlertViewCancelBlock didDismissAfterCancelHandler;
@property (nonatomic, copy) AHKAlertViewDestructiveBlock didDismissAfterDestructiveHandler;

#pragma mark - 类方法(初始化方法)
/** Do not forget about weak referens to self for actionHandler, cancelHandler and destructiveHandler blocks */
+ (instancetype)alertViewWithTitle:(NSString *)title
                           message:(NSString *)message
                             style:(AHKAlertViewStyle)style
                      buttonTitles:(NSArray *)buttonTitles
                 cancelButtonTitle:(NSString *)cancelButtonTitle
            destructiveButtonTitle:(NSString *)destructiveButtonTitle
                     actionHandler:(AHKAlertViewActionBlock)actionHandler
                     cancelHandler:(AHKAlertViewCancelBlock)cancelHandler
                destructiveHandler:(AHKAlertViewDestructiveBlock)destructiveHandler;

/** 后续操作在Alert dismiss后， 调用此方法 */
+ (instancetype)alertViewWithTitle:(NSString *)title
                           message:(NSString *)message
                             style:(AHKAlertViewStyle)style
                      buttonTitles:(NSArray *)buttonTitles
                 cancelButtonTitle:(NSString *)cancelButtonTitle
            destructiveButtonTitle:(NSString *)destructiveButtonTitle
           didDismissActionHandler:(AHKAlertViewActionBlock)didDismissActionHandler
           didDismissCancelHandler:(AHKAlertViewCancelBlock)didDismissCancelHandler
      didDismissDestructiveHandler:(AHKAlertViewDestructiveBlock)didDismissDestructiveHandler;

/** Do not forget about weak referens to self for actionHandler, cancelHandler and destructiveHandler blocks */
+ (instancetype)alertViewWithViewAndTitle:(NSString *)title
                                  message:(NSString *)message
                                    style:(AHKAlertViewStyle)style
                                     view:(UIView *)view
                             buttonTitles:(NSArray *)buttonTitles
                        cancelButtonTitle:(NSString *)cancelButtonTitle
                   destructiveButtonTitle:(NSString *)destructiveButtonTitle
                            actionHandler:(AHKAlertViewActionBlock)actionHandler
                            cancelHandler:(AHKAlertViewCancelBlock)cancelHandler
                       destructiveHandler:(AHKAlertViewDestructiveBlock)destructiveHandler;

/** 后续操作在Alert dismiss后， 调用此方法 */
+ (instancetype)alertViewWithViewAndTitle:(NSString *)title
                                  message:(NSString *)message
                                    style:(AHKAlertViewStyle)style
                                     view:(UIView *)view
                             buttonTitles:(NSArray *)buttonTitles
                        cancelButtonTitle:(NSString *)cancelButtonTitle
                   destructiveButtonTitle:(NSString *)destructiveButtonTitle
                  didDismissActionHandler:(AHKAlertViewActionBlock)didDismissActionHandler
                  didDismissCancelHandler:(AHKAlertViewCancelBlock)didDismissCancelHandler
             didDismissDestructiveHandler:(AHKAlertViewDestructiveBlock)didDismissDestructiveHandler;

/** Do not forget about weak referens to self for actionHandler, cancelHandler and destructiveHandler blocks */
+ (instancetype)alertViewWithActivityIndicatorAndTitle:(NSString *)title
                                               message:(NSString *)message
                                                 style:(AHKAlertViewStyle)style
                                          buttonTitles:(NSArray *)buttonTitles
                                     cancelButtonTitle:(NSString *)cancelButtonTitle
                                destructiveButtonTitle:(NSString *)destructiveButtonTitle
                                         actionHandler:(AHKAlertViewActionBlock)actionHandler
                                         cancelHandler:(AHKAlertViewCancelBlock)cancelHandler
                                    destructiveHandler:(AHKAlertViewDestructiveBlock)destructiveHandler;

/** 后续操作在Alert dismiss后， 调用此方法 */
+ (instancetype)alertViewWithActivityIndicatorAndTitle:(NSString *)title
                                               message:(NSString *)message
                                                 style:(AHKAlertViewStyle)style
                                          buttonTitles:(NSArray *)buttonTitles
                                     cancelButtonTitle:(NSString *)cancelButtonTitle
                                destructiveButtonTitle:(NSString *)destructiveButtonTitle
                               didDismissActionHandler:(AHKAlertViewActionBlock)didDismissActionHandler
                               didDismissCancelHandler:(AHKAlertViewCancelBlock)didDismissCancelHandler
                          didDismissDestructiveHandler:(AHKAlertViewDestructiveBlock)didDismissDestructiveHandler;

/** Do not forget about weak referens to self for actionHandler, cancelHandler and destructiveHandler blocks
 *  progressLabelText 一定要设置初始文字，否则 UI 计算会失效，导致文字显示不完全
 */
+ (instancetype)alertViewWithProgressViewAndTitle:(NSString *)title
                                          message:(NSString *)message
                                            style:(AHKAlertViewStyle)style
                                progressLabelText:(NSString *)progressLabelText
                                     buttonTitles:(NSArray *)buttonTitles
                                cancelButtonTitle:(NSString *)cancelButtonTitle
                           destructiveButtonTitle:(NSString *)destructiveButtonTitle
                                    actionHandler:(AHKAlertViewActionBlock)actionHandler
                                    cancelHandler:(AHKAlertViewCancelBlock)cancelHandler
                               destructiveHandler:(AHKAlertViewDestructiveBlock)destructiveHandler;

/** 后续操作在Alert dismiss后， 调用此方法 */
+ (instancetype)alertViewWithProgressViewAndTitle:(NSString *)title
                                          message:(NSString *)message
                                            style:(AHKAlertViewStyle)style
                                progressLabelText:(NSString *)progressLabelText
                                     buttonTitles:(NSArray *)buttonTitles
                                cancelButtonTitle:(NSString *)cancelButtonTitle
                           destructiveButtonTitle:(NSString *)destructiveButtonTitle
                          didDismissActionHandler:(AHKAlertViewActionBlock)didDismissActionHandler
                          didDismissCancelHandler:(AHKAlertViewCancelBlock)didDismissCancelHandler
                     didDismissDestructiveHandler:(AHKAlertViewDestructiveBlock)didDismissDestructiveHandler;

#pragma mark - Only Cancel Button
+ (instancetype)alertViewWithTitle:(NSString *)title
                           message:(NSString *)message
                             style:(AHKAlertViewStyle)style
                 cancelButtonTitle:(NSString *)cancelButtonTitle;

+ (instancetype)alertViewWithViewAndTitle:(NSString *)title
                                  message:(NSString *)message
                                    style:(AHKAlertViewStyle)style
                                     view:(UIView *)view
                        cancelButtonTitle:(NSString *)cancelButtonTitle;

+ (instancetype)alertViewWithActivityIndicatorAndTitle:(NSString *)title
                                               message:(NSString *)message
                                                 style:(AHKAlertViewStyle)style
                                     cancelButtonTitle:(NSString *)cancelButtonTitle;

+ (instancetype)alertViewWithProgressViewAndTitle:(NSString *)title
                                          message:(NSString *)message
                                            style:(AHKAlertViewStyle)style
                                progressLabelText:(NSString *)progressLabelText
                                cancelButtonTitle:(NSString *)cancelButtonTitle;

#pragma mark - 类方法(全局UI配置)
+ (void)alertConfigLayerCornerRadius:(CGFloat)layerCornerRadius;

+ (void)alertConfigCancelOnTouch:(BOOL)cancelOnTouch;
+ (void)alertConfigTitleNumberOfLines:(NSInteger) titleNumberOfLines;
+ (void)alertConfigSeparatorsColor:(UIColor *)separatorsColor;
+ (void)alertConfigWidth:(CGFloat)width;

+ (void)alertConfigTitleTextColor:(UIColor *)titleTextColor;
+ (void)alertConfigTitleFont:(UIFont *)titleFont;

+ (void)alertConfigMessageTextColor:(UIColor *)messageTextColor;
+ (void)alertConfigMessageFont:(UIFont *)messageFont;

+ (void)alertConfigButtonsFont:(UIFont *)buttonsFont;
+ (void)alertConfigButtonsTitleColor:(UIColor *)buttonsTitleColor;
+ (void)alertConfigButtonsTitleColorHighlighted:(UIColor *)buttonsTitleColorHighlighted;
+ (void)alertConfigButtonsBackgroundColorHighlighted:(UIColor *)buttonsBackgroundColorHighlighted;

+ (void)alertConfigCancelButtonFont:(UIFont *)cancelButtonFont;
+ (void)alertConfigCancelButtonTitleColor:(UIColor *)cancelButtonTitleColor;
+ (void)alertConfigCancelButtonTitleColorHighlighted:(UIColor *)cancelButtonTitleColorHighlighted;
+ (void)alertConfigCancelButtonBackgroundColorHighlighted:(UIColor *)cancelButtonBackgroundColorHighlighted;

+ (void)alertConfigDestructiveButtonFont:(UIFont *)destructiveButtonFont;
+ (void)alertConfigDestructiveButtonTitleColor:(UIColor *)destructiveButtonTitleColor;
+ (void)alertConfigDestructiveButtonTitleColorHighlighted:(UIColor *)destructiveButtonTitleColorHighlighted;
+ (void)alertConfigDestructiveButtonBackgroundColorHighlighted:(UIColor *)destructiveButtonBackgroundColorHighlighted;

#pragma mark - 对象方法
- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)message
                        style:(AHKAlertViewStyle)style
                 buttonTitles:(NSArray *)buttonTitles
            cancelButtonTitle:(NSString *)cancelButtonTitle
       destructiveButtonTitle:(NSString *)destructiveButtonTitle
                actionHandler:(AHKAlertViewActionBlock)actionHandler
                cancelHandler:(AHKAlertViewCancelBlock)cancelHandler
           destructiveHandler:(AHKAlertViewDestructiveBlock)destructiveHandler;

- (instancetype)initWithViewAndTitle:(NSString *)title
                             message:(NSString *)message
                               style:(AHKAlertViewStyle)style
                                view:(UIView *)view
                        buttonTitles:(NSArray *)buttonTitles
                   cancelButtonTitle:(NSString *)cancelButtonTitle
              destructiveButtonTitle:(NSString *)destructiveButtonTitle
                       actionHandler:(AHKAlertViewActionBlock)actionHandler
                       cancelHandler:(AHKAlertViewCancelBlock)cancelHandler
                  destructiveHandler:(AHKAlertViewDestructiveBlock)destructiveHandler;

- (instancetype)initWithActivityIndicatorAndTitle:(NSString *)title
                                          message:(NSString *)message
                                            style:(AHKAlertViewStyle)style
                                     buttonTitles:(NSArray *)buttonTitles
                                cancelButtonTitle:(NSString *)cancelButtonTitle
                           destructiveButtonTitle:(NSString *)destructiveButtonTitle
                                    actionHandler:(AHKAlertViewActionBlock)actionHandler
                                    cancelHandler:(AHKAlertViewCancelBlock)cancelHandler
                               destructiveHandler:(AHKAlertViewDestructiveBlock)destructiveHandler;

- (instancetype)initWithProgressViewAndTitle:(NSString *)title
                                     message:(NSString *)message
                                       style:(AHKAlertViewStyle)style
                           progressLabelText:(NSString *)progressLabelText
                                buttonTitles:(NSArray *)buttonTitles
                           cancelButtonTitle:(NSString *)cancelButtonTitle
                      destructiveButtonTitle:(NSString *)destructiveButtonTitle
                               actionHandler:(AHKAlertViewActionBlock)actionHandler
                               cancelHandler:(AHKAlertViewCancelBlock)cancelHandler
                          destructiveHandler:(AHKAlertViewDestructiveBlock)destructiveHandler;

#pragma mark -
- (void)showAnimated:(BOOL)animated completionHandler:(void(^)(void))completionHandler;
- (void)dismissAnimated:(BOOL)animated completionHandler:(void(^)(void))completionHandler;
- (void)transitionToAlertView:(AHKAlertView *)alertView completionHandler:(void(^)(void))completionHandler;
- (void)setProgress:(float)progress progressLabelText:(NSString *)progressLabelText;
- (void)setButtonAtIndex:(NSUInteger)index enabled:(BOOL)enabled;
- (BOOL)isButtonEnabledAtIndex:(NSUInteger)index;
- (void)forceCancel;
- (void)forceDestructive;
- (void)forceActionAtIndex:(NSUInteger)index;
- (void)setButtonPropertiesAtIndex:(NSUInteger)index handler:(void(^)(LGAlertViewButtonProperties *properties))handler;

@end
