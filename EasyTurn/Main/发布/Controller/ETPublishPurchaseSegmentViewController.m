//
//  ETPublishPurchaseSegmentViewController.m
//  EasyTurn
//
//  Created by 程立 on 2019/9/8.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import "ETPublishPurchaseSegmentViewController.h"
#import "ETEnterpriseServicesViewController.h"
#import "ETPublishPurchaseViewController.h"

@interface ETPublishPurchaseSegmentViewController ()
/// 企业流转
@property (nonatomic, strong) UIView *vEnterpriseTurn;
/// 企业服务
@property (nonatomic, strong) UIView *vEnterpriseServices;
@property (nonatomic, strong) UISegmentedControl *segment;
@property (nonatomic, strong) UIButton *leftButton;
@end

@implementation ETPublishPurchaseSegmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *retView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,Screen_Width,kNavBarHeight_StateBarH)];
    retView.backgroundColor = kACColorBlue_Theme;
    [self.navigationController.view addSubview:retView];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(7, StatusBarHeight+7, 44, 44);
    [btn setImage:[UIImage imageNamed:@"nav_leftBack"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"nav_leftBack"] forState:UIControlStateHighlighted];
    [btn setImage:[UIImage imageNamed:@"nav_leftBack"] forState:UIControlStateSelected];
    _leftButton=btn;
    [_leftButton addTarget:self action:@selector(cancelClick) forControlEvents:(UIControlEventTouchUpInside)];
    [retView addSubview:_leftButton];
    
    UILabel *headtitle=[[UILabel alloc]initWithFrame:CGRectMake(Screen_Width/2-36, StatusBarHeight+7, 72, 25)];
    headtitle.textColor=kACColorWhite;
    headtitle.text=@"发布求购";
    [retView addSubview:headtitle];
    
    [self createSubViewsAndConstraints];
    self.navigationItem.title = @"发布求购";
    self.navigationController.navigationBar.hidden = NO;
    [self enableLeftBackWhiteButton];
}

#pragma mark - createSubViewsAndConstraints
- (void)createSubViewsAndConstraints {
    [self.view addSubview:self.segment];
    ETEnterpriseServicesViewController *vcEnterpriseServices = [[ETEnterpriseServicesViewController alloc] init];
    vcEnterpriseServices.block = ^{
        if (self.mDismissBlock) {
            self.mDismissBlock();
        }
    };
    [self addChildViewController:vcEnterpriseServices];
    _vEnterpriseServices = vcEnterpriseServices.view;
    _vEnterpriseServices.hidden = YES;
    [self.view addSubview:_vEnterpriseServices];
    [_vEnterpriseServices mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.segment.mas_bottom);
        make.leading.bottom.trailing.mas_equalTo(0);
    }];
    
//    ETPublishPurchaseViewController *vcPublishPurchase = [[ETPublishPurchaseViewController alloc] init];
//    [self addChildViewController:vcPublishPurchase];
//    _vEnterpriseTurn = vcPublishPurchase.view;
//    [self.view addSubview:_vEnterpriseTurn];
//    [_vEnterpriseTurn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.segment.mas_bottom);
//        make.leading.bottom.trailing.mas_equalTo(0);
//    }];
    
    ETPublishPurchaseViewController *vcPublishPurchase = [[ETPublishPurchaseViewController alloc] init];
    [self addChildViewController:vcPublishPurchase];
    _vEnterpriseTurn = vcPublishPurchase.view;
    [self.view addSubview:_vEnterpriseTurn];
    [_vEnterpriseTurn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.segment.mas_bottom);
        make.leading.bottom.trailing.mas_equalTo(0);
    }];
    WeakSelf(self);
    [vcPublishPurchase toDissmissSelf:^{
        if (weakself.mDismissBlock) {
            weakself.mDismissBlock();
        }
    }];
    
}

- (UISegmentedControl *)segment{
    if(!_segment){
        NSMutableArray *array = [NSMutableArray arrayWithObjects:@"企业流转",@"企业服务", nil];
        _segment = [[UISegmentedControl alloc] initWithItems:array];
        
        _segment.frame = CGRectMake(Screen_Width/4, 10, Screen_Width/2, 40);
        _segment.layer.cornerRadius = 10;
        _segment.layer.masksToBounds = YES;
        
        _segment.selectedSegmentIndex = 0;
        _segment.tintColor = [UIColor clearColor];
        NSDictionary *selectedTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:17],
                                                 NSForegroundColorAttributeName:[UIColor whiteColor]};
        //设置文字属性
        [_segment setTitleTextAttributes:selectedTextAttributes forState:UIControlStateSelected];
        NSDictionary* unselectedTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:17],
                                                   NSForegroundColorAttributeName:RGBCOLOR(0.21*255, 0.54*255, 0.97*255)};
        [_segment setTitleTextAttributes:unselectedTextAttributes forState:UIControlStateNormal];
        
        [_segment setBackgroundImage:[PublicFunc imageWithColor:[UIColor whiteColor]]
                            forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        
        [_segment setBackgroundImage:[PublicFunc imageWithColor:RGBCOLOR(0.21*255, 0.54*255, 0.97*255)]
                            forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
        
        [_segment addTarget:self action:@selector(topSegmentChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _segment;
}

#pragma mark 分段控件点击事件
- (void)topSegmentChanged:(UISegmentedControl *)sender{
    
    if (sender.selectedSegmentIndex == 0) {
        _vEnterpriseTurn.hidden = NO;
        _vEnterpriseServices.hidden = YES;
    } else {
        _vEnterpriseTurn.hidden = YES;
        _vEnterpriseServices.hidden = NO;
    }
}

//block声明方法
-(void)toDissmissSelf:(dismissBlock)block{
    self.mDismissBlock = block;
}
- (void)onClickBtnBack:(UIButton *)btn{
    if (self.mDismissBlock) {
        self.mDismissBlock();
    }
}
@end
