//
//  ACLoadingAlert.h
//  AutoTraderCloud
//
//  Created by zhangMo on 2017/11/10.
//  Copyright © 2017年 AutoHome. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ACLoadingAlert;

typedef void (^ _Nullable ACLoadingAlertActionHandler)(ACLoadingAlert * _Nonnull alertView, NSUInteger index, NSString * _Nullable title);
typedef void (^ _Nullable ACLoadingAlertCancelHandler)(void);

@interface ACLoadingAlert : UIView

#pragma mark - init -
- (nonnull instancetype)initWithTitle:(nullable NSString *)title
                              message:(nullable NSString *)message
                    actionButtonTitle:(nullable NSString *)actionButtonTitle
                    cancelButtonTitle:(nullable NSString *)cancelButtonTitle
                        actionHandler:(ACLoadingAlertActionHandler)actionHandler
                        cancelHandler:(ACLoadingAlertCancelHandler)cancelHandler
                         retryHandler:(ACLoadingAlertActionHandler)retryHandler;

/**
 * 展示 默认提示Alert
 *
 * @param animated 是否动画
 * @param completionHandler 回调
 */
- (void)showAnimated:(BOOL)animated completionHandler:(void(^_Nullable)(void))completionHandler;

/**
 * 展示 LoadingAlert
 *
 * @param message  文案
 * @param cancelButtonTitle  按钮文案 loading时不可点击，故设置cancelbutton
 * @param animated 是否动画
 * @param transition 是否由Alert过渡展示，外部直接展示请传 NO。
 * @param completionHandler 回调
 */
- (void)showLoadingWithMessage:(NSString *_Nullable)message
             cancelButtonTitle:(NSString *_Nullable)cancelButtonTitle
                      animated:(BOOL)animated
                    transition:(BOOL)transition
             completionHandler:(void(^_Nullable)(void))completionHandler;

/**
 * 展示 SuccessAlert
 *
 * @param message  文案
 * @param actionButtonTitle  按钮文案
 * @param animated 是否动画
 * @param transition 是否由Alert过渡展示，外部直接展示请传 NO。
 * @param completionHandler 回调
 */
- (void)showSuccessWithMessage:(NSString *_Nullable)message
             actionButtonTitle:(NSString *_Nullable)actionButtonTitle
                      animated:(BOOL)animated
                    transition:(BOOL)transition
             completionHandler:(void(^_Nullable)(void))completionHandler;

/**
 * 展示 FailureAlert
 *
 * @param message  文案
 * @param cancelButtonTitle & actionButtonTitle  按钮文案
 * @param animated 是否动画
 * @param transition 是否由Alert过渡展示，外部直接展示请传 NO。
 * @param completionHandler 回调
 */
- (void)showFailureWithMessage:(NSString *_Nullable)message
             cancelButtonTitle:(NSString *_Nullable)cancelButtonTitle
             actionButtonTitle:(NSString *_Nullable)actionButtonTitle
                      animated:(BOOL)animated
                    transition:(BOOL)transition
             completionHandler:(void(^_Nullable)(void))completionHandler;

/**
 * 展示 纯文本Alert
 *
 * @param plainText  纯文本
 * @param actionButtonTitle  按钮文案
 * @param animated   是否动画
 * @param transition 是否由Alert过渡展示，外部直接展示请传 NO。
 * @param completionHandler 回调
 */
- (void)showPlainText:(NSString *_Nullable)plainText
    actionButtonTitle:(NSString *_Nullable)actionButtonTitle
             animated:(BOOL)animated
           transition:(BOOL)transition
    completionHandler:(void(^_Nullable)(void))completionHandler;

@end
