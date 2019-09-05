//
//  ETPusCashViewController.m
//  EasyTurn
//
//  Created by 王翔 on 2019/7/22.
//  Copyright © 2019年 EasyTurn. All rights reserved.
//

#import "ETPusCashViewController.h"
#import "Masonry.h"
@interface ETPusCashViewController ()
@property(nonatomic,strong) UIView *topView;
@property(nonatomic,strong) UILabel *cashoutLab;
@property(nonatomic,strong) UIImageView *wxImage;
@property(nonatomic,strong) UILabel *accountLabel;
@property(nonatomic,strong) UILabel *landLabel;

@property(nonatomic,strong) UIView *centerView;
@property(nonatomic,strong) UILabel *casLab;
@property(nonatomic,strong) UIImageView *moneyImg;
@property(nonatomic,strong) UIView *grayView;
@property(nonatomic,strong) UILabel *surplusLab;
@property(nonatomic,strong) UIButton *casBtn;
@end

@implementation ETPusCashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    [self cashOut];
    [self cashoutController];
    [self centerPriceView];
    [self centerPriceController];
}

- (void)cashOut
{
    _topView=[[UIView alloc]init];
    _topView.backgroundColor=[UIColor redColor];
    _topView.layer.backgroundColor = [UIColor colorWithRed:250/255.0 green:251/255.0 blue:250/255.0 alpha:1.0].CGColor;
    [self.view addSubview:_topView];
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(73);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(69);
    }];
}

- (void)cashoutController
{
    _cashoutLab=[[UILabel alloc]init];
    _cashoutLab.text=@"提现到";
    _cashoutLab.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    _cashoutLab.font=[UIFont systemFontOfSize:13];
    [_topView addSubview:_cashoutLab];
    [_cashoutLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.mas_equalTo(30);
        make.size.mas_equalTo(CGSizeMake(40, 18));
    }];
    
    _wxImage=[[UIImageView alloc]init];
    [_topView addSubview:_wxImage];
    _wxImage.backgroundColor=[UIColor whiteColor];
    [_wxImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.mas_equalTo(115);
        make.size.mas_equalTo(CGSizeMake(18, 18));
    }];
    
    _accountLabel=[[UILabel alloc]init];
    _accountLabel.text=@"微信账户";
    _accountLabel.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    _accountLabel.font=[UIFont systemFontOfSize:13];
    [_topView addSubview:_accountLabel];
    [_accountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.mas_equalTo(143);
        make.size.mas_equalTo(CGSizeMake(55, 18));
    }];
    
    _landLabel=[[UILabel alloc]init];
    _landLabel.text=@"未登录，请先绑定";
    _landLabel.textColor=[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
    _landLabel.font=[UIFont systemFontOfSize:12];
    [_topView addSubview:_landLabel];
    [_landLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(42);
        make.left.mas_equalTo(143);
        make.size.mas_equalTo(CGSizeMake(100, 16));
    }];
    //    [self];
}

- (void)centerPriceView
{
    _centerView=[[UIView alloc]init];
    _centerView.layer.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor;
    [self.view addSubview:_centerView];
    [_centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(142);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(251);
    }];
}

- (void)centerPriceController
{
    _casLab=[[UILabel alloc]init];
    _casLab.text=@"提现金额";
    _casLab.font=[UIFont systemFontOfSize:15];
    [_centerView addSubview:_casLab];
    [_casLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(28);
        make.left.mas_equalTo(30);
        make.size.mas_equalTo(CGSizeMake(65, 21));
    }];
    
    _moneyImg=[[UIImageView alloc]init];
    _moneyImg.image=[UIImage imageNamed:@""];
    _moneyImg.backgroundColor=[UIColor whiteColor];
    [_centerView addSubview:_moneyImg];
    [_moneyImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(70);
        make.left.mas_equalTo(30);
        make.size.mas_equalTo(CGSizeMake(18, 41));
    }];
    
    _grayView=[[UIView alloc]init];
    _grayView.backgroundColor=[UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    [_centerView addSubview:_grayView];
    [_grayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(116);
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(345, 1));
    }];
    
    _surplusLab=[[UILabel alloc]init];
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"账户余额¥6.000元，全部提现"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 12],NSForegroundColorAttributeName: [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0]}];
    
    [string addAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.000000]} range:NSMakeRange(0, 12)];
    
    [string addAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:47/255.0 green:134/255.0 blue:251/255.0 alpha:1.000000]} range:NSMakeRange(12, 4)];
    _surplusLab.attributedText=string;
    [_centerView addSubview:_surplusLab];
    [_surplusLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(136);
        make.left.mas_equalTo(30);
        make.size.mas_equalTo(CGSizeMake(160, 16));
    }];
    
    _casBtn=[[UIButton alloc]init];
    [_casBtn setTitle:@"提现" forState:UIControlStateNormal];
    _casBtn.backgroundColor=[UIColor colorWithRed:47/255.0 green:134/255.0 blue:251/255.0 alpha:1.0];
    [_centerView addSubview:_casBtn];
    _casBtn.layer.cornerRadius = 5;
    [_casBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(172);
        make.left.mas_equalTo(30);
        make.right.mas_equalTo(-30);
        make.height.mas_equalTo(39);
    }];
}

@end
