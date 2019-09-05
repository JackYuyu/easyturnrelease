//
//  ACToastView.h
//  AutoTraderCloud
//
//  Created by GeWei on 2017/11/13.
//  Copyright © 2017年 AutoHome. All rights reserved.
//

#import "AHKToastView/AHKToastView.h"

typedef NS_ENUM(NSUInteger, ACToastHUDMaskType) {
    ACToastHUDMaskTypeNone = 1,  // default mask type, allow user interactions while HUD is displayed
    ACToastHUDMaskTypeClear,     // don't allow user interactions with background objects
    ACToastHUDMaskTypeBlack,     // don't allow user interactions with background objects and dim the UI in the back of the HUD (as seen in iOS 7 and above)
    ACToastHUDMaskTypeGradient,  // don't allow user interactions with background objects and dim the UI with a a-la UIAlertView background gradient (as seen in iOS 6)
    ACToastHUDMaskTypeCustom     // don't allow user interactions with background objects and dim the UI in the back of the HUD with a custom color
};



@interface ACToastView : AHKToastView

+ (ACToastView *)toastView;
+ (ACToastView *)toastView:(BOOL)isIntercept;
+ (ACToastView *)toastViewStyle:(ACToastHUDMaskType)toastHUDMaskType;

- (void)showMessage:(NSString *)message;

- (void)showLoadingCircleViewWithStatus:(NSString *)status;

- (void)showLoadingSuccessViewWithStatus:(NSString *)status completionHandler:(void(^)(void))completionHandler;

- (void)showLoadingFailureViewWithStatus:(NSString *)status completionHandler:(void(^)(void))completionHandler;

@end
