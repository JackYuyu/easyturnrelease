//
//  MainViewController.m
//  AutoTraderCloud
//
//  Created by zhangMo on 2017/2/16.
//  Copyright © 2017年 AutoHome. All rights reserved.
//

#import "MainViewController.h"
#import "ETHomeViewController.h"
#import "ETEnterpriseServiceController.h"
#import "ETReleaseViewController.h"
#import "ETMessageCenterController.h"
#import "ETMineViewController.h"
#import "ETMinesViewController.h"
#import "SSNavigationController.h"
#import "SSPayUtils.h"
#import "ETRKongViewController.h"
#import "EaseSyetemController.h"
#import "ETBuyPushViewController.h"
#import "ETProductModel.h"
@interface MainViewController ()<UITabBarControllerDelegate>

@property (nonatomic, strong) UITabBarController *tabController;
@property (nonatomic, strong) NSMutableArray *controllers;
@property (nonatomic, strong) SSNavigationController *navHome;
@property (nonatomic, strong) SSNavigationController *navEnterpriseService;
@property (nonatomic, strong) SSNavigationController *navRelease;
@property (nonatomic, strong) SSNavigationController *navMessage;
@property (nonatomic, strong) SSNavigationController *navMine;
@end

@implementation MainViewController

static MainViewController *vcMain = nil;
+ (MainViewController *)sharedVCMain {
    return vcMain;
}

-(void)viewWillAppear:(BOOL)animated{
    
    self.navigationController.navigationBar.hidden = YES;
   
}

- (id)initWithLaunchOptions:(NSDictionary *)options {
    self = [self init];
    if (self) {
        vcMain = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kACColorWhite;
    [self initItemTitleTextAttributes];
    [self initialTabBarController];

}

- (void)removeTabBarController {
    if (_tabController) {
        _controllers = nil;
        [_tabController.view removeFromSuperview];
        [_tabController removeFromParentViewController];
        _tabController = nil;
    }
}

- (void)initialTabBarController {
    
    [self initViewControllers];
    [self.view addSubview:_tabController.view];
}

- (void)initItemTitleTextAttributes {
    UITabBarItem *item = [UITabBarItem appearance];
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSFontAttributeName] = kFontSize(11);
    normalAttrs[NSForegroundColorAttributeName] = kACColorGray2_R85_G85_B85_A1;
    [item setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = kACColorBlue_Theme;
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}

#pragma mark - init VC
- (void)initViewControllers {
    
    _controllers = [[NSMutableArray alloc] init];
    ETHomeViewController *vcHome = [[ETHomeViewController alloc]init];
    _navHome = [[SSNavigationController alloc] initWithRootViewController:vcHome];
    _navHome.tabCode = TabCode_Home;
    [self setNaviController:_navHome title:@"首页" defautImage:[UIImage ak_imageNamed:@"首页_未选中"] selectedImage:[UIImage ak_imageNamed:@"首页_选中"]];
    [_controllers addObject:_navHome];
    
    ETEnterpriseServiceController *vcEnterpriseService = [[ETEnterpriseServiceController alloc] init];
    _navEnterpriseService = [[SSNavigationController alloc] initWithRootViewController:vcEnterpriseService];
    _navEnterpriseService.tabCode = TabCode_EnterpriseService;
    [self setNaviController:_navEnterpriseService title:@"企服者" defautImage:[UIImage ak_imageNamed:@"企服者_未选中"] selectedImage:[UIImage ak_imageNamed:@"企服者_选中"]];
    [_controllers addObject:_navEnterpriseService];
  
    ETReleaseViewController *vcRelease = [[ETReleaseViewController alloc] init];
    _navRelease = [[SSNavigationController alloc] initWithRootViewController:vcRelease];
    _navRelease.tabCode = TabCode_Release;
    [self setNaviController:_navRelease title:@"发布" defautImage:[UIImage ak_imageNamed:@"发布_选中"] selectedImage:[UIImage ak_imageNamed:@"发布_选中"]];
    [_controllers addObject:_navRelease];
    
//    ETMessageCenterController *vcMessage = [[ETMessageCenterController alloc] init];
    EaseConversationListViewController *chatListVC = [[EaseConversationListViewController alloc] init];
    chatListVC.block1 = ^(NSString *a) {
        NSString* where = [NSString stringWithFormat:@"where %@=%@",bg_sqlKey(@"touser"),bg_sqlValue(a)];
        
        NSArray * array1 = [ETProductModel bg_find:@"ETProductModel" where:where];
        [self PostSaveUI:a];
        [self PostUI:a];
    };
    
    _navMessage = [[SSNavigationController alloc] initWithRootViewController:chatListVC];
    _navMessage.tabCode = TabCode_Message;
    [self setNaviController:_navMessage title:@"消息" defautImage:[UIImage ak_imageNamed:@"消息_未选中"] selectedImage:[UIImage ak_imageNamed:@"消息_选中"]];
    chatListVC.block = ^(int index){
        EaseSyetemController *vc = [EaseSyetemController new];
        vc.index=index;
        [_navMessage pushViewController:vc animated:YES];
        NSLog(@"");
    };
    [_controllers addObject:_navMessage];
    ETMineViewController *vcMine = [[ETMineViewController alloc] init];
//    ETMinesViewController *vcMine = [[ETMinesViewController alloc] init];
    _navMine = [[SSNavigationController alloc] initWithRootViewController:vcMine];
    _navMine.tabCode = TabCode_Mine;
    [self setNaviController:_navMine title:@"我的" defautImage:[UIImage ak_imageNamed:@"我的_未选中"] selectedImage:[UIImage ak_imageNamed:@"我的_选中"]];
    [_controllers addObject:_navMine];
    
    _tabController = [[UITabBarController alloc] init];
    _tabController.delegate = self;
//    [_tabController.tabBar setItems:@[]];
    [[UITabBar appearance] setBackgroundImage:[UIImage ak_resizableImageWithColor:kACColorWhite]];
    [[UITabBar appearance] setShadowImage:[UIImage ak_imageWithColor:kACColorLine_R233_G233_B233_A1 size:CGSizeMake(Screen_Width, 0.5)]];
    _tabController.viewControllers = _controllers;
    // 默认展示首页
    [self setSelectViewController:TabCode_Home];
    [self addChildViewController:_tabController];
    [_tabController.view layoutIfNeeded];
    
}
- (void)PostUI:(NSString*)releaseid {
    NSMutableDictionary* dic=[NSMutableDictionary new];
    NSDictionary *params = @{
                             @"releaseId" : releaseid
                             };
    [HttpTool get:[NSString stringWithFormat:@"release/releaseDetail"] params:params success:^(id responseObj) {
        if ([responseObj[@"msg"] containsString:@"次数已用尽"]) {
            UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提示" message:@"免费查看次数已用尽！您可以选择充值会员来开启无限查看权限！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            alter.delegate=self;
            [alter show];
            return;
        }
        NSDictionary* a=responseObj[@"data"];
        for (NSDictionary* prod in responseObj[@"data"]) {
            ETProductModel* p=[ETProductModel mj_objectWithKeyValues:prod];
            //            [_products addObject:p];
            
        }
        //        NSLog(@"");
        ETProductModel* p=[ETProductModel mj_objectWithKeyValues:a];
        
        NSLog(@"");

        ETBuyPushViewController *buy =[[ETBuyPushViewController alloc]init];
        buy.product=p;

        buy.releaseId=releaseid;
        [self.navigationController pushViewController:buy animated:YES];

    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}


//小黄车先调接口
- (void)PostSaveUI:(NSString* )releaseId {
//    NSMutableDictionary* dic=[NSMutableDictionary new];
//    ETProductModel* p=_products[0];
    NSUserDefaults* user=[NSUserDefaults standardUserDefaults];
    
    NSDictionary *params = @{
                             @"releaseId" : releaseId,
                             @"forUserId" : [user objectForKey:@"foruserid"]
                             
                             };
    [HttpTool get:[NSString stringWithFormat:@"pay/saveForUserId"] params:params success:^(id responseObj) {
        
        //        NSString* a=responseObj[@"data"][@"result"];
        //        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:[responseObj dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
        //
        //        NSDictionary* d=[jsonDict copy];
        NSLog(@"");
        //        [MBProgressHUD showMBProgressHud:self.view withText:@"提交成功" withTime:1];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
- (void)setNaviController:(SSNavigationController *)naviController
                    title:(NSString *)title
              defautImage:(UIImage *)image
            selectedImage:(UIImage *)selImage {
    
    naviController.tabBarItem.title = title;
    naviController.tabBarItem.image = image;
    naviController.tabBarItem.selectedImage = selImage;
//    naviController.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, 3);
//    naviController.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0,-6, 0);//（当只有图片的时候）需要自动调整
}


#pragma mark - TabBarVC
- (void)setSelectViewController:(NSString *)tabCode {
    for (SSNavigationController *vc in _tabController.viewControllers) {
        if ([vc.tabCode isEqualToString:tabCode]) {
            _tabController.selectedViewController = vc;
            break;
        }
    }
}

- (SSNavigationController *)selectedNavController {
    SSNavigationController *navController = nil;
    if (_tabController.selectedIndex < _tabController.viewControllers.count) {
        navController = _tabController.viewControllers[_tabController.selectedIndex];
    }
    return navController;
}

- (NSInteger)viewControllersInTabBar {
    if (_tabController) {
        return _tabController.viewControllers.count;
    }
    return 0;
}

#pragma mark - UITabBarControllerDelegate

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
   
    //点击tabBarItem动画
    [self tabBarButtonClick:[self getTabBarButton]];
    if ([viewController.tabBarItem.title isEqualToString:@"我的"]){
        [[NSNotificationCenter defaultCenter]postNotificationName:Refresh_Mine object:nil];
    }
    
    if ([viewController.tabBarItem.title isEqualToString:@"发布"]){
        ETRKongViewController*et=[[ETRKongViewController alloc]init];
        UIImage *image = [self imageWithCaputureView:self.view];
        et.backImg = image;
        [self presentViewController:et animated:NO completion:nil];
    }
}

- (UIImage *)imageWithCaputureView:(UIView *)view
{
    CGSize size = CGSizeMake(view.bounds.size.width, view.bounds.size.height*0.9);
    
    // 开启位图上下文
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    
    // 获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 把控件上的图层渲染到上下文,layer只能渲染
    [view.layer renderInContext:ctx];
    
    // 生成新图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    // 关闭上下文
    UIGraphicsEndImageContext();
    
    return image;
}

#pragma mark - 控制器跳转拦截
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        UIViewController *vcTemp = ((UINavigationController *)viewController).viewControllers.firstObject;
        if ([vcTemp isKindOfClass:[ETReleaseViewController  class]]) {
            ETRKongViewController*et=[[ETRKongViewController alloc]init];
            UIImage *image = [self imageWithCaputureView:self.view];
            et.backImg = image;
            [self presentViewController:et animated:NO completion:nil];
            return NO;
        }
    }
    return YES;
}
#pragma mark - 获取tabarButton
- (UIControl *)getTabBarButton{
    NSMutableArray *tabBarButtons = [[NSMutableArray alloc]initWithCapacity:0];
    
    for (UIView *tabBarButton in self.tabController.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]){
            [tabBarButtons addObject:tabBarButton];
        }
    }
    UIControl *tabBarButton = [tabBarButtons objectAtIndex:self.tabController.selectedIndex];
    
    return tabBarButton;
}

#pragma mark - 点击动画
- (void)tabBarButtonClick:(UIControl *)tabBarButton
{
    for (UIView *imageView in tabBarButton.subviews) {
        if ([imageView isKindOfClass:NSClassFromString(@"UITabBarSwappableImageView")]) {
            //需要实现的帧动画,这里根据自己需求改动
            CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
            animation.keyPath = @"transform.scale";
            animation.values = @[@1.0,@1.1,@0.9,@1.0];
            animation.duration = 0.3;
            animation.calculationMode = kCAAnimationCubic;
            //添加动画
            [imageView.layer addAnimation:animation forKey:nil];
        }
    }
    
}


- (void)dealloc {
     [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
