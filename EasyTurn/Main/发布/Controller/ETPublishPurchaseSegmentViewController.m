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
@end

@implementation ETPublishPurchaseSegmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createSubViewsAndConstraints];
    self.navigationItem.title = @"发布求购";
    self.navigationController.navigationBar.hidden = NO;
    [self enableLeftBackWhiteButton];
}

#pragma mark - createSubViewsAndConstraints
- (void)createSubViewsAndConstraints {
    [self.view addSubview:self.segment];
    ETEnterpriseServicesViewController *vcEnterpriseServices = [[ETEnterpriseServicesViewController alloc] init];
    [self addChildViewController:vcEnterpriseServices];
    _vEnterpriseServices = vcEnterpriseServices.view;
    _vEnterpriseServices.hidden = YES;
    [self.view addSubview:_vEnterpriseServices];
    [_vEnterpriseServices mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.segment.mas_bottom);
        make.leading.bottom.trailing.mas_equalTo(0);
    }];
    
    ETPublishPurchaseViewController *vcPublishPurchase = [[ETPublishPurchaseViewController alloc] init];
    [self addChildViewController:vcPublishPurchase];
    _vEnterpriseTurn = vcPublishPurchase.view;
    [self.view addSubview:_vEnterpriseTurn];
    [_vEnterpriseTurn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.segment.mas_bottom);
        make.leading.bottom.trailing.mas_equalTo(0);
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
@end
