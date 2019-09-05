//
//  SSNavigationController.m
//  SSJewelry
//
//  Created by sszb on 2019/5/6.
//  Copyright © 2019 Song. All rights reserved.
//

#import "SSNavigationController.h"
#import "ACViewController.h"
@interface SSNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation SSNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.interactivePopGestureRecognizer.delegate = self;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    if ([viewController isKindOfClass:[ACViewController class]]) {
        ACViewController *viewControllerac = (ACViewController *)viewController;
        viewControllerac.vcSource = self.viewControllers.lastObject;
    }
    
    [super pushViewController:viewController animated:animated];
}

@end
