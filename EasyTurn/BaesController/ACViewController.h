//
//  ACViewController.h
//  AutoTraderCloud
//
//  Created by zhangMo on 2017/2/15.
//  Copyright © 2017年 AutoHome. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSNavigationController.h"
#import "WRCustomNavigationBar.h"
@interface ACViewController : UIViewController
@property (nonatomic, readonly) UIBarButtonItem *leftBarButtonItem;
@property (nonatomic, readonly) UIBarButtonItem *rightBarButtonItem;
@property (nonatomic, strong) SSNavigationController *acNaviController;
@property (nonatomic, strong) UIViewController *vcSource;
@property (nonatomic, strong, readonly) UIView *vSafeAreaContainer;
@property (nonatomic, strong) WRCustomNavigationBar *customNavBar;
- (void)enableLeftBackButton;
- (void)enableLeftBackWhiteButton;
- (void)enableLeftBackButtonShowTab:(BOOL)showTab;
- (void)setTabBarHidden:(BOOL)hidden;

- (void)setLeftNavigationItemWithCustomView:(UIView *)view;
- (void)setRightNavigationItemWithCustomView:(UIView *)view;

- (void)setLeftNavigationItemsWithCustomViews:(NSArray *)arrViews;
- (void)setRightNavigationItemsWithCustomViews:(NSArray *)arrViews;

/**
 返回按钮点击事件：子类可以重写
 
 @param btn 返回按钮
 */
- (void)onClickBtnBack:(UIButton *)btn;

@end
