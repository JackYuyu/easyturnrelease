//
//  MainViewController.h
//  AutoTraderCloud
//
//  Created by zhangMo on 2017/2/16.
//  Copyright © 2017年 AutoHome. All rights reserved.
//

#import "ACViewController.h"
typedef NS_ENUM(NSInteger,STTabBarControllerType){
    STTabBarControllerHome = 0,//首页
    STTabBarControllerClassify = 1,//分类
    STTabBarControllerFind = 2,//任务中心
    STTabBarControllerStore = 3,//购物车
    STTabBarControllerMine = 4,//我的
};
@interface MainViewController : ACViewController
/**控制器类型*/
@property (nonatomic, assign) STTabBarControllerType tabVcType;

@property (nonatomic, copy) NSString *liveState;

+ (MainViewController *)sharedVCMain;
/** 初始化 */
- (id)initWithLaunchOptions:(NSDictionary *)options;
/** 重建TabBarVC */
- (void)initialTabBarController;
/** 移除TabBarVC */
- (void)removeTabBarController;

/**
 设置选中 指定的Controller
 
 @param tabCode     ACNavigationController 中 Code 对应值
 */
- (void)setSelectViewController:(NSString *)tabCode;

/**
 设置 tabBarItem 角标
 
 @param tabCode     ACNavigationController 中 Code 对应值
 @param badgeValue  角标数
 */
- (void)setBadgeValue:(NSString *)badgeValue atViewController:(NSString *)tabCode;
- (void)showBadgeOnItemAtViewController:(NSString *)tabCode;

/** 当前选中Nav */
- (SSNavigationController *)selectedNavController;

/** TabBar中VC个数 */
- (NSInteger)viewControllersInTabBar;

@end
