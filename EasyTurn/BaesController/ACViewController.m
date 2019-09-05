//
//  ACViewController.m
//  AutoTraderCloud
//
//  Created by zhangMo on 2017/2/15.
//  Copyright © 2017年 AutoHome. All rights reserved.
//

#import "ACViewController.h"

@interface ACViewController () {
    UIBarButtonItem *_leftBarButtonItem;
    UIBarButtonItem *_rightBarButtonItem;
    BOOL showTabWhenGoBack;
}

@end

@implementation ACViewController

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpFixiOS11];
    self.navigationController.navigationBar.translucent = NO;
}

#pragma mark - 适配iOS11
- (void)setUpFixiOS11 {
    if (@available(ios 11.0,*)) {
        UIScrollView.appearance.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        UITableView.appearance.estimatedRowHeight = 0;
        UITableView.appearance.estimatedSectionFooterHeight = 0;
        UITableView.appearance.estimatedSectionHeaderHeight = 0;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

- (SSNavigationController *)acNaviController {
    return (SSNavigationController *)self.navigationController;
}

- (void)enableLeftBackButton {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 44, 44);
    [btn setImage:[UIImage imageNamed:@"nav_leftBack_Black"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"nav_leftBack_Black"] forState:UIControlStateHighlighted];
    [btn setImage:[UIImage imageNamed:@"nav_leftBack_Black"] forState:UIControlStateSelected];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
    [btn addTarget:self action:@selector(onClickBtnBack:) forControlEvents:UIControlEventTouchUpInside];
    [self setLeftNavigationItemWithCustomView:btn];
}

- (void)enableLeftBackWhiteButton {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 44, 44);
    [btn setImage:[UIImage imageNamed:@"nav_leftBack"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"nav_leftBack"] forState:UIControlStateHighlighted];
    [btn setImage:[UIImage imageNamed:@"nav_leftBack"] forState:UIControlStateSelected];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
    [btn addTarget:self action:@selector(onClickBtnBack:) forControlEvents:UIControlEventTouchUpInside];
    [self setLeftNavigationItemWithCustomView:btn];
}

- (void)enableLeftBackButtonShowTab:(BOOL)showTab {
    [self enableLeftBackButton];
    showTabWhenGoBack = showTab;
   
}

- (void)onClickBtnBack:(UIButton *)btn {
    if (![SSJewelryCore isValidClick]) {
        return;
    }
    [self.view endEditing:YES];
    if (showTabWhenGoBack) {
        [self setTabBarHidden:NO];
    }
    
    if (self.presentingViewController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)setTabBarHidden:(BOOL)hidden {
    self.tabBarController.tabBar.hidden = hidden;
}

- (void)setLeftNavigationItemWithCustomView:(UIView *)view {
    if (_leftBarButtonItem) {
        _leftBarButtonItem = nil;
    }
    _leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:view];
    self.navigationItem.leftBarButtonItem = _leftBarButtonItem;
}

- (void)setRightNavigationItemWithCustomView:(UIView *)view {
    if (_rightBarButtonItem) {
        _rightBarButtonItem = nil;
    }
    _rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:view];
    self.navigationItem.rightBarButtonItem = _rightBarButtonItem;
}

- (void)setLeftNavigationItemsWithCustomViews:(NSArray *)arrViews {
    if (arrViews && arrViews.count > 0) {
        NSMutableArray *arrItems = [NSMutableArray new];
        UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        space.width = -15;
        [arrItems addObject:space];
        for (long i = 0; i < arrViews.count; i++) {
            UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:arrViews[i]];
            [arrItems addObject:rightButton];
        }
        self.navigationItem.leftBarButtonItems = arrItems;
    }
}

- (void)setRightNavigationItemsWithCustomViews:(NSArray *)arrViews {
    if (arrViews && arrViews.count > 0) {
        NSMutableArray *arrItems = [NSMutableArray new];
        UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        space.width = -15;
        [arrItems addObject:space];
        for (long i = 0; i < arrViews.count; i++) {
            UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:arrViews[i]];
            [arrItems addObject:rightButton];
        }
        self.navigationItem.rightBarButtonItems = arrItems;
    }
}

#pragma mark - 横竖屏
- (BOOL)shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    AMLog(@"dealloc");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
