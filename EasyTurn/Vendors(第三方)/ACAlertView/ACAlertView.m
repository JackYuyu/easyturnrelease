//
//  ACAlertView.m
//  AutoTraderCloud
//
//  Created by GeWei on 2017/11/8.
//  Copyright © 2017年 AutoHome. All rights reserved.
//

#import "ACAlertView.h"
#define kAlertMessageFontSzie kFontSize(14)

@implementation ACAlertView

+ (void)makeATCAlertStyle {
    // 点击灰色蒙层不关闭Alert
    [AHKAlertView alertConfigCancelOnTouch:NO];
    // 标题居中，极限值10汉字
    [AHKAlertView alertConfigTitleNumberOfLines:1];
    [AHKAlertView alertConfigSeparatorsColor:kACColorLine_R233_G233_B233_A1];
    [AHKAlertView alertConfigTitleTextColor:kACColorGray1_R25_G25_B25_A1];
    [AHKAlertView alertConfigTitleFont:kFontSize(17)];
    [AHKAlertView alertConfigMessageTextColor:kACColorGray2_R85_G85_B85_A1];
    [AHKAlertView alertConfigMessageFont:kAlertMessageFontSzie];

    // 主操作 buttons 按钮颜色均为蓝色
    [AHKAlertView alertConfigButtonsFont:kFontSize(15)];
    [AHKAlertView alertConfigButtonsTitleColor:kACColorBlue_R85_G172_B238_A1];
    [AHKAlertView alertConfigButtonsTitleColorHighlighted:kACColorWhite];
    [AHKAlertView alertConfigButtonsBackgroundColorHighlighted:kACColorBlue2_R2_G154_B255_A1];
    // 辅助操作 CancelButton 颜色 灰色
    [AHKAlertView alertConfigCancelButtonFont:kFontSize(15)];
    [AHKAlertView alertConfigCancelButtonTitleColor:kACColorGray2_R85_G85_B85_A1];
    [AHKAlertView alertConfigCancelButtonTitleColorHighlighted:kACColorWhite];
    [AHKAlertView alertConfigCancelButtonBackgroundColorHighlighted:kACColorBlue2_R2_G154_B255_A1];
    // 辅助操作 DestructiveButton 颜色 灰色
    [AHKAlertView alertConfigDestructiveButtonFont:kFontSize(15)];
    [AHKAlertView alertConfigDestructiveButtonTitleColor:kACColorGray2_R85_G85_B85_A1];
    [AHKAlertView alertConfigDestructiveButtonTitleColorHighlighted:kACColorWhite];
    [AHKAlertView alertConfigDestructiveButtonBackgroundColorHighlighted:kACColorBlue2_R2_G154_B255_A1];

    // 设置圆角 4pt
    [AHKAlertView alertConfigLayerCornerRadius:4];
    // 设置宽度270
    [[AHKAlertView appearance] setWidth:kAlertDefaultWidth];
    // 设置圆角4pt 按钮字数超过6汉字 (现在是7个字)
    [AHKAlertView alertConfigLayerCornerRadius:4];
}

#pragma mark - init
- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)message
                        style:(AHKAlertViewStyle)style
                 buttonTitles:(NSArray *)buttonTitles
            cancelButtonTitle:(NSString *)cancelButtonTitle
       destructiveButtonTitle:(NSString *)destructiveButtonTitle
                actionHandler:(AHKAlertViewActionBlock)actionHandler
                cancelHandler:(AHKAlertViewCancelBlock)cancelHandler
           destructiveHandler:(AHKAlertViewDestructiveBlock)destructiveHandler {
    self = [super initWithTitle:title message:message style:style buttonTitles:buttonTitles cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:destructiveButtonTitle actionHandler:actionHandler cancelHandler:cancelHandler destructiveHandler:destructiveHandler];
    if (self) {
        [self atcStylemessageTextAlignment];
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
                  destructiveHandler:(AHKAlertViewDestructiveBlock)destructiveHandler
{
    self = [super initWithViewAndTitle:title message:message style:style view:view buttonTitles:buttonTitles cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:destructiveButtonTitle actionHandler:actionHandler cancelHandler:cancelHandler destructiveHandler:destructiveHandler];
    if (self) {
      [self atcStylemessageTextAlignment];
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
                               destructiveHandler:(AHKAlertViewDestructiveBlock)destructiveHandler
{
    self = [super initWithActivityIndicatorAndTitle:title message:message style:style buttonTitles:buttonTitles cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:destructiveButtonTitle actionHandler:actionHandler cancelHandler:cancelHandler destructiveHandler:destructiveHandler];
    if (self) {
        [self atcStylemessageTextAlignment];
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
                          destructiveHandler:(AHKAlertViewDestructiveBlock)destructiveHandler
{
    self = [super initWithProgressViewAndTitle:title message:message style:style progressLabelText:progressLabelText buttonTitles:buttonTitles cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:destructiveButtonTitle actionHandler:actionHandler cancelHandler:cancelHandler destructiveHandler:destructiveHandler];
    if (self) {
        [self atcStylemessageTextAlignment];
    }
    return self;
}


#pragma mark - Show Alert
+ (instancetype)alertViewWithTitle:(NSString *)title
                           message:(NSString *)message
                             style:(AHKAlertViewStyle)style
                      buttonTitles:(NSArray *)buttonTitles
                 cancelButtonTitle:(NSString *)cancelButtonTitle
            destructiveButtonTitle:(NSString *)destructiveButtonTitle
                     actionHandler:(AHKAlertViewActionBlock)actionHandler
                     cancelHandler:(AHKAlertViewCancelBlock)cancelHandler
                destructiveHandler:(AHKAlertViewDestructiveBlock)destructiveHandler
{
    ACAlertView *alert = [[self alloc] initWithTitle:title
                                             message:message
                                               style:style
                                        buttonTitles:buttonTitles
                                   cancelButtonTitle:cancelButtonTitle
                              destructiveButtonTitle:destructiveButtonTitle
                                       actionHandler:actionHandler
                                       cancelHandler:cancelHandler
                                  destructiveHandler:destructiveHandler];
    [alert atcStylemessageTextAlignment];
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
                       destructiveHandler:(AHKAlertViewDestructiveBlock)destructiveHandler
{
    ACAlertView *alert = [[self alloc] initWithViewAndTitle:title
                                      message:message
                                        style:style
                                         view:view
                                 buttonTitles:buttonTitles
                            cancelButtonTitle:cancelButtonTitle
                       destructiveButtonTitle:destructiveButtonTitle
                                actionHandler:actionHandler
                                cancelHandler:cancelHandler
                           destructiveHandler:destructiveHandler];
    [alert atcStylemessageTextAlignment];
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
                                    destructiveHandler:(AHKAlertViewDestructiveBlock)destructiveHandler
{
    ACAlertView *alert =  [[self alloc] initWithActivityIndicatorAndTitle:title
                                                   message:message
                                                     style:style
                                              buttonTitles:buttonTitles
                                         cancelButtonTitle:cancelButtonTitle
                                    destructiveButtonTitle:destructiveButtonTitle
                                             actionHandler:actionHandler
                                             cancelHandler:cancelHandler
                                        destructiveHandler:destructiveHandler];
    [alert atcStylemessageTextAlignment];
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
                               destructiveHandler:(AHKAlertViewDestructiveBlock)destructiveHandler
{
    ACAlertView *alert = [[self alloc] initWithProgressViewAndTitle:title
                                              message:message
                                                style:style
                                    progressLabelText:progressLabelText
                                         buttonTitles:buttonTitles
                                    cancelButtonTitle:cancelButtonTitle
                               destructiveButtonTitle:destructiveButtonTitle
                                        actionHandler:actionHandler
                                        cancelHandler:cancelHandler
                                   destructiveHandler:destructiveHandler];
    [alert atcStylemessageTextAlignment];
    return alert;
}

#pragma mark - cancel Button Only
+ (instancetype)alertViewWithTitle:(NSString *)title
                           message:(NSString *)message
                             style:(AHKAlertViewStyle)style
                 cancelButtonTitle:(NSString *)cancelButtonTitle
{
    ACAlertView *alert = [[self alloc] initWithTitle:title
                               message:message
                                 style:style
                          buttonTitles:nil
                     cancelButtonTitle:cancelButtonTitle
                destructiveButtonTitle:nil
                         actionHandler:nil
                         cancelHandler:nil
                    destructiveHandler:nil];
    [alert atcStylemessageTextAlignment];
    return alert;
}

+ (instancetype)alertViewWithViewAndTitle:(NSString *)title
                                  message:(NSString *)message
                                    style:(AHKAlertViewStyle)style
                                     view:(UIView *)view
                        cancelButtonTitle:(NSString *)cancelButtonTitle
{
    ACAlertView *alert = [[self alloc] initWithViewAndTitle:title
                                      message:message
                                        style:style
                                         view:view
                                 buttonTitles:nil
                            cancelButtonTitle:cancelButtonTitle
                       destructiveButtonTitle:nil
                                actionHandler:nil
                                cancelHandler:nil
                           destructiveHandler:nil];
    [alert atcStylemessageTextAlignment];
    return alert;
}

+ (instancetype)alertViewWithActivityIndicatorAndTitle:(NSString *)title
                                               message:(NSString *)message
                                                 style:(AHKAlertViewStyle)style
                                     cancelButtonTitle:(NSString *)cancelButtonTitle
{
    ACAlertView *alert = [[self alloc] initWithActivityIndicatorAndTitle:title
                                                   message:message
                                                     style:style
                                              buttonTitles:nil
                                         cancelButtonTitle:cancelButtonTitle
                                    destructiveButtonTitle:nil
                                             actionHandler:nil
                                             cancelHandler:nil
                                        destructiveHandler:nil];
    [alert atcStylemessageTextAlignment];
    return alert;
}

+ (instancetype)alertViewWithProgressViewAndTitle:(NSString *)title
                                          message:(NSString *)message
                                            style:(AHKAlertViewStyle)style
                                progressLabelText:(NSString *)progressLabelText
                                cancelButtonTitle:(NSString *)cancelButtonTitle
{
    ACAlertView *alert = [[self alloc] initWithProgressViewAndTitle:title
                                              message:message
                                                style:style
                                    progressLabelText:progressLabelText
                                         buttonTitles:nil
                                    cancelButtonTitle:cancelButtonTitle
                               destructiveButtonTitle:nil
                                        actionHandler:nil
                                        cancelHandler:nil
                                   destructiveHandler:nil];
    [alert atcStylemessageTextAlignment];
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
    ACAlertView *alert = [super alertViewWithTitle:title message:message style:style buttonTitles:buttonTitles cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:destructiveButtonTitle didDismissActionHandler:didDismissActionHandler didDismissCancelHandler:didDismissCancelHandler didDismissDestructiveHandler:didDismissDestructiveHandler];
    
    [alert atcStylemessageTextAlignment];
    return alert;
}

/* UI方案: 1个按钮:蓝色  2个按钮: 灰色 蓝色 3个按钮:竖着 蓝色 灰色 灰色 (针对buttons)
 cancelButton 和 destructiveButton 始终灰色
 */
- (void)atcStylemessageTextAlignment {
    
//    CGFloat  messageHeight = [self.message  ak_sizeWithFontEX:kAlertMessageFontSzie constrainedToSize:CGSizeMake(kAlertDefaultWidth - 30, MAXFLOAT)].height;
//    // 进位取整, 因为 ak_sizeWithFontEX 也是进位取整计算的
//    CGFloat messageLineHeight = ceil(kFontSize(14).lineHeight);
//    NSInteger  messageLineCount = (NSInteger) ceil(messageHeight / messageLineHeight);
//    if (messageLineCount >= 2) {
//        self.messageTextAlignment = NSTextAlignmentLeft;
//    } else {
//        self.messageTextAlignment = NSTextAlignmentCenter;
//    }
    
    // 从1.19.16版本开始全部居中显示
    self.messageTextAlignment = NSTextAlignmentCenter;
    /* UI方案: 1个按钮:蓝色  2个按钮: 灰色 蓝色 3个按钮:竖着 蓝色 灰色 灰色 (针对所有类型的button)
     */
    
    /*
     一个按钮
     不管是什么类型的按钮都改为蓝色
     
     */

    /*
     两个按钮
     1.删除button:  删除 + button
     2.cancelButton: cancel + button
     3.删除cancel:  cancel + 删除
     4.buttons : button button
    */
    /*
     三个按钮
     1.删除button:  删除 + button + button
     2.cancelButton: button + button + cancel
     3.删除cancelButton: 删除  + button + cancel
     4.buttons: button + button + button
     */
    NSInteger buttonCount = 0;
    if (self.destructiveButtonTitle.length > 0) {
        buttonCount += 1;
    }
    
    if (self.cancelButtonTitle.length > 0) {
        buttonCount += 1;
    }
    
    if (self.buttonTitles && self.buttonTitles.count > 0) {
        buttonCount += self.buttonTitles.count;
    }
    
    // 只有1个按钮
    if (buttonCount == 1) {
        // 主操作 buttons 按钮颜色均为蓝色
        self.buttonsTitleColor = kACColorBlue1_R40_G115_B255_A1;
        // 辅助操作 CancelButton 颜色 蓝色
        self.cancelButtonTitleColor = kACColorBlue1_R40_G115_B255_A1;
        // 辅助操作 DestructiveButton 颜色 蓝色
        self.destructiveButtonTitleColor = kACColorBlue1_R40_G115_B255_A1;
    } else if (buttonCount == 2) {
        // 有buttons
         if (self.buttonTitles && self.buttonTitles.count > 0) {
             self.buttonsTitleColor = kACColorGray2_R85_G85_B85_A1;
             if (self.buttonTitles.count == 2) {
                  //4.buttons : button button
                 // 第二个buttonTitles是蓝色, 其余是灰色
                 [self setButtonPropertiesAtIndex:1 handler:^(LGAlertViewButtonProperties *properties) {
                     properties.titleColor = kACColorBlue1_R40_G115_B255_A1;
                 }];
             } else {
                 //1.删除button:  删除 + button
                 //2.cancelButton: cancel + button
                 // 第一个buttonTitles是蓝色, 其余是灰色
                 [self setButtonPropertiesAtIndex:0 handler:^(LGAlertViewButtonProperties *properties) {
                     properties.titleColor = kACColorBlue1_R40_G115_B255_A1;
                 }];
                 // 辅助操作 CancelButton 颜色 灰色
                 self.cancelButtonTitleColor = kACColorGray2_R85_G85_B85_A1;
                 // 辅助操作 DestructiveButton 颜色 灰色
                 self.destructiveButtonTitleColor = kACColorGray2_R85_G85_B85_A1;
             }
         } else {
             //3.删除cancel:  cancel + 删除
             // 辅助操作 CancelButton 颜色 灰色
             self.cancelButtonTitleColor = kACColorGray2_R85_G85_B85_A1;
             // 辅助操作 DestructiveButton 颜色 蓝色
             self.destructiveButtonTitleColor = kACColorBlue1_R40_G115_B255_A1;
         }
    } else if (buttonCount >= 3){
        
        if (self.destructiveButtonTitle.length > 0) {
            /*
             1.删除button:  删除 + button + button
             3.删除cancelButton: 删除  + button + cancel
             */
            
            // 辅助操作 DestructiveButton 颜色 蓝色
            self.destructiveButtonTitleColor = kACColorBlue1_R40_G115_B255_A1;
            // 辅助操作 CancelButton 颜色 灰色
            self.cancelButtonTitleColor = kACColorGray2_R85_G85_B85_A1;
            // 主操作 buttons 按钮颜色为灰色
            self.buttonsTitleColor = kACColorGray2_R85_G85_B85_A1;
        } else {
            /*
             2.cancelButton: button + button + cancel
             4.buttons: button + button + button
             */
            // 主操作 buttons 按钮颜色第一个为蓝色
            self.buttonsTitleColor = kACColorGray2_R85_G85_B85_A1;
            [self setButtonPropertiesAtIndex:0 handler:^(LGAlertViewButtonProperties *properties) {
                properties.titleColor = kACColorBlue1_R40_G115_B255_A1;
            }];
            // 辅助操作 CancelButton 颜色 灰色
            self.cancelButtonTitleColor = kACColorGray2_R85_G85_B85_A1;
        }
    }
    
    
   
    
    if (buttonCount >= 3) {
        self.oneRowOneButton = YES;
    }
    
}


@end
