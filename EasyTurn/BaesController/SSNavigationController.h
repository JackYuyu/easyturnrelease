//
//  SSNavigationController.h
//  SSJewelry
//
//  Created by sszb on 2019/5/6.
//  Copyright © 2019 Song. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
//维护Tab每个vc特定的code，scheme跳转和设置角标用
static NSString *const TabCode_Home    = @"10001"; // 首页
static NSString *const TabCode_EnterpriseService     = @"10002"; // 企服者
static NSString *const TabCode_Release  = @"10003"; // 发布
static NSString *const TabCode_Message  = @"10004"; // 消息
static NSString *const TabCode_Mine  = @"10005"; // 我的

@interface SSNavigationController : UINavigationController

@property (nonatomic, strong) NSString *tabCode;

@end

NS_ASSUME_NONNULL_END
