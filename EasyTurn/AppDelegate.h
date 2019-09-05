//
//  AppDelegate.h
//  EasyTurn
//
//  Created by 程立 on 2019/7/18.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString *appKey = @"f1d791a41215e2248e64320a";
static NSString *channel = @"Publish channel";
static BOOL isProduction = FALSE;
@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (nonatomic,assign) int review;

@property (strong, nonatomic) UIWindow *window;

- (void)loginViewController;
@end

