//
//  ACLoadingAlert.m
//  AutoTraderCloud
//
//  Created by zhangMo on 2017/11/10.
//  Copyright © 2017年 AutoHome. All rights reserved.
//

#import "ACLoadingAlert.h"
#import "ACLoadingHUD.h"
#import "ACToastView.h"
#import "ACAlertView.h"
#import "LGAlertView.h"
#import "NSString+AHKit.h"

#define kContainerViewWidth  280
#define kContainerViewHeight 70

@interface ACLoadingAlert ()

/** init */
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSString *actionButtonTitle;
@property (nonatomic, strong) NSString *cancelButtonTitle;
@property (nonatomic, copy) ACLoadingAlertActionHandler actionHandler;
@property (nonatomic, copy) ACLoadingAlertCancelHandler cancelHandler;
@property (nonatomic, copy) ACLoadingAlertActionHandler retryHandler;

/** SubViews */
@property (nonatomic, strong) UIView *vContainer;
@property (nonatomic, strong) ACLoadingHUD *loadingHUD;
@property (nonatomic, strong) UILabel *labInfo;

/** ACAlertView */
@property (nonatomic, strong) ACAlertView *defaultAlert;
@property (nonatomic, strong) ACAlertView *loadingAlert;
@property (nonatomic, strong) ACAlertView *successAlert;
@property (nonatomic, strong) ACAlertView *failureAlert;

@end

@implementation ACLoadingAlert
- (nonnull instancetype)initWithTitle:(nullable NSString *)title
                              message:(nullable NSString *)message
                    actionButtonTitle:(nullable NSString *)actionButtonTitle
                    cancelButtonTitle:(nullable NSString *)cancelButtonTitle
                        actionHandler:(ACLoadingAlertActionHandler)actionHandler
                        cancelHandler:(ACLoadingAlertCancelHandler)cancelHandler
                         retryHandler:(ACLoadingAlertActionHandler)retryHandler
{
    self = [super init];
    if (self) {
        self.title = title;
        self.message = message;
        self.actionButtonTitle = actionButtonTitle;
        self.cancelButtonTitle = cancelButtonTitle;
        self.actionHandler = actionHandler;
        self.cancelHandler = cancelHandler;
        self.retryHandler = retryHandler;
        
        [self setupDefaults];
    }
    return self;
}

#pragma mark - Public Methods
- (void)showAnimated:(BOOL)animated completionHandler:(void(^)(void))completionHandler {
    WEAKSELF
    _defaultAlert = [[ACAlertView alloc] initWithTitle:self.title message:self.message style:AHKAlertViewStyleAlert buttonTitles:@[self.actionButtonTitle] cancelButtonTitle:self.cancelButtonTitle destructiveButtonTitle:nil actionHandler:^(NSString *title, NSUInteger index) {
       
        if (weakSelf.actionHandler) weakSelf.actionHandler(weakSelf, index, title);
    } cancelHandler:^{
       
        [weakSelf dismissDefaultAlert];
        if (weakSelf.cancelHandler) weakSelf.cancelHandler();
    } destructiveHandler:nil];
    _defaultAlert.dismissOnAction = NO;
    [_defaultAlert showAnimated:animated completionHandler:^{
        if (completionHandler) completionHandler();
    }];
}

- (void)showLoadingWithMessage:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle animated:(BOOL)animated transition:(BOOL)transition completionHandler:(void(^_Nullable)(void))completionHandler {
    [_loadingHUD startLoading];
    
    _labInfo.text = message;
    _loadingAlert = [[ACAlertView alloc] initWithViewAndTitle:@"" message:@"" style:AHKAlertViewStyleAlert view:_vContainer buttonTitles:nil cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:nil actionHandler:nil cancelHandler:nil destructiveHandler:nil];
    _loadingAlert.cancelOnTouch = NO;
    _loadingAlert.cancelButtonEnabled = NO;
    
    if (transition) {
        if (_defaultAlert && ((LGAlertView *)_defaultAlert.alert).isShowing) {
            [_defaultAlert transitionToAlertView:_loadingAlert completionHandler:^{
                if (completionHandler) completionHandler();
            }];
        }else if (_failureAlert && ((LGAlertView *)_failureAlert.alert).isShowing) {
            [_failureAlert transitionToAlertView:_loadingAlert completionHandler:^{
                if (completionHandler) completionHandler();
            }];
        }
    }else {
        [_loadingAlert showAnimated:animated completionHandler:^{
            if (completionHandler) completionHandler();
        }];
    }
}

- (void)showSuccessWithMessage:(NSString *)message actionButtonTitle:(NSString *)actionButtonTitle animated:(BOOL)animated transition:(BOOL)transition completionHandler:(void(^_Nullable)(void))completionHandler {
    [_loadingHUD finishWithSuccess:nil];
    
    NSArray *arrayTitles = nil;
    if (actionButtonTitle.length > 0) {
        arrayTitles = @[actionButtonTitle];
    }
    _labInfo.text = message;
    _successAlert = [[ACAlertView alloc] initWithViewAndTitle:@"" message:@"" style:AHKAlertViewStyleAlert view:_vContainer buttonTitles:arrayTitles cancelButtonTitle:nil destructiveButtonTitle:nil actionHandler:nil cancelHandler:nil destructiveHandler:nil];
    _successAlert.cancelOnTouch = YES;
    if (transition) {
        if (_loadingAlert && ((LGAlertView *)_loadingAlert.alert).isShowing) {
            [_loadingAlert transitionToAlertView:_successAlert completionHandler:^{
                if (completionHandler) completionHandler();
            }];
        }
    }else {
        [_successAlert showAnimated:animated completionHandler:^{
            if (completionHandler) completionHandler();
        }];
    }
}

- (void)showPlainText:(NSString *_Nullable)plainText actionButtonTitle:(NSString *)actionButtonTitle animated:(BOOL)animated transition:(BOOL)transition completionHandler:(void(^_Nullable)(void))completionHandler {
    [_loadingHUD endLoading];
    
    UILabel *labMessage = [[UILabel alloc] init];
    labMessage.textColor = kACColorGray2_R85_G85_B85_A1;
    labMessage.numberOfLines = 0;
    
    NSMutableAttributedString *strAttrMessage = [[NSMutableAttributedString alloc] initWithString:plainText];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 3;
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    [strAttrMessage addAttributes:@{NSFontAttributeName: kFontSize(14),
                             NSParagraphStyleAttributeName: paragraphStyle}
                     range:NSMakeRange(0, strAttrMessage.length)];

    // 20.f 用来按设计图修正 UI
    CGFloat labMessageHeight = [SSJewelryCore sizeOfAttributedString:strAttrMessage fittingSize:CGSizeMake(kAlertDefaultWidth - 30, CGFLOAT_MAX)].height + 20.f;
    
    [labMessage setFrame:CGRectMake(0, 100, kAlertDefaultWidth - 30, ceil(labMessageHeight))];
    
    labMessage.attributedText = strAttrMessage;
    
    NSArray *arrayTitles = nil;
    if (actionButtonTitle.length > 0) {
        arrayTitles = @[actionButtonTitle];
    }
    
    _successAlert = [[ACAlertView alloc] initWithViewAndTitle:nil message:nil style:AHKAlertViewStyleAlert view:labMessage buttonTitles:arrayTitles cancelButtonTitle:nil destructiveButtonTitle:nil actionHandler:nil cancelHandler:nil destructiveHandler:nil];
    _successAlert.cancelOnTouch = YES;
    if (transition) {
        if (_loadingAlert && ((LGAlertView *)_loadingAlert.alert).isShowing) {
            [_loadingAlert transitionToAlertView:_successAlert completionHandler:^{
                if (completionHandler) completionHandler();
            }];
        }
    }else {
        [_successAlert showAnimated:animated completionHandler:^{
            if (completionHandler) completionHandler();
        }];
    }
}

- (void)showFailureWithMessage:(NSString *)message
             cancelButtonTitle:(NSString *_Nullable)cancelButtonTitle
             actionButtonTitle:(NSString *_Nullable)actionButtonTitle
                      animated:(BOOL)animated
                    transition:(BOOL)transition
             completionHandler:(void(^_Nullable)(void))completionHandler
{
    [_loadingHUD finishWithFailure:nil];
    
    _labInfo.text = message;
    CGSize size = [_labInfo.text ak_sizeWithFontEX:kFontSize(15) constrainedToSize:CGSizeMake(kContainerViewWidth-20, CGFLOAT_MAX)];
    if (size.height > 20) {
        _labInfo.textAlignment = NSTextAlignmentLeft;
        CGRect frame = _labInfo.frame;
        frame.size.height = size.height;
        _labInfo.frame = frame;
        CGRect containerFrame = _vContainer.frame;
        containerFrame.size.height = 80;
        _vContainer.frame = containerFrame;
    }else {
        _labInfo.textAlignment = NSTextAlignmentCenter;
        CGRect frame = _labInfo.frame;
        frame.size.height = 20;
        _labInfo.frame = frame;
        CGRect containerFrame = _vContainer.frame;
        containerFrame.size.height = kContainerViewHeight;
        _vContainer.frame = containerFrame;
    }
    
    NSArray *arrayTitles = nil;
    if (actionButtonTitle.length > 0) {
        arrayTitles = @[actionButtonTitle];
    }
    WEAKSELF
    _failureAlert = [[ACAlertView alloc] initWithViewAndTitle:@"" message:@"" style:AHKAlertViewStyleAlert view:_vContainer buttonTitles:arrayTitles cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:nil actionHandler:^(NSString *title, NSUInteger index) {
        
        if (weakSelf.retryHandler) weakSelf.retryHandler(weakSelf, index, title);
    } cancelHandler:^ {
        [weakSelf dismissDefaultAlert];
    } destructiveHandler:nil];
    _failureAlert.cancelOnTouch = YES;
    _failureAlert.dismissOnAction = NO;
    if (transition) {
        if (_loadingAlert && ((LGAlertView *)_loadingAlert.alert).isShowing) {
            [_loadingAlert transitionToAlertView:_failureAlert completionHandler:^{
                if (completionHandler) completionHandler();
            }];
        }
    }else {
        [_failureAlert showAnimated:animated completionHandler:^{
            if (completionHandler) completionHandler();
        }];
    }
}

#pragma mark - Private Methods
- (void)dismissDefaultAlert {
    if (_defaultAlert && ((LGAlertView *)_defaultAlert.alert).isShowing) {
        [_defaultAlert dismissAnimated:YES completionHandler:nil];
    }else if (_failureAlert && ((LGAlertView *)_failureAlert.alert).isShowing) {
        [_failureAlert dismissAnimated:YES completionHandler:nil];
    }
}

#pragma mark - Create Subviews
- (void)setupDefaults {
    _vContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kContainerViewWidth, kContainerViewHeight)];
    
    _loadingHUD = [[ACLoadingHUD alloc] initWithFrame:CGRectMake(kContainerViewWidth/2-20, -10, 40, 40)];
    [_vContainer addSubview:_loadingHUD];
    
    _labInfo = [[UILabel alloc] initWithFrame:CGRectMake(20, 46, kContainerViewWidth-40, 20)];
    _labInfo.numberOfLines = 0;
    _labInfo.textAlignment = NSTextAlignmentCenter;
    _labInfo.font = kFontSize(15);
    _labInfo.textColor = kACColorGray1_R25_G25_B25_A1;
    [_vContainer addSubview:_labInfo];
}

#pragma mark - dealloc
- (void)dealloc {
    AMLog(@"<< dealloc >>");
}

@end
