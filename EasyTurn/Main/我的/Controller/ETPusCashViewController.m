//
//  ETPusCashViewController.m
//  EasyTurn
//
//  Created by 王翔 on 2019/7/22.
//  Copyright © 2019年 EasyTurn. All rights reserved.
//

#import "ETPusCashViewController.h"
#import "Masonry.h"
#import "ETBindViewController.h"
@interface ETPusCashViewController ()
@property(nonatomic,strong) UIView *topView;
@property(nonatomic,strong) UILabel *cashoutLab;
@property(nonatomic,strong) UIImageView *wxImage;
@property(nonatomic,strong) UILabel *accountLabel;
@property(nonatomic,strong) UILabel *landLabel;
@property(nonatomic,strong) UIButton *bangdingBtn;

@property(nonatomic,strong) UIView *centerView;
@property(nonatomic,strong) UILabel *casLab;
@property(nonatomic,strong) UILabel *moneyImg;
@property(nonatomic,strong) UIView *grayView;
@property(nonatomic,strong) UILabel *surplusLab;
@property(nonatomic,strong) UIButton *casBtn;

@property(nonatomic,strong)UITextField *textField;


@property (nonatomic,strong) UIView * maskTheView;
@property (nonatomic,strong) UIView * shareView;

@property (nonatomic,strong) NSString* account;
@property (nonatomic,strong) NSString* name;

@end

@implementation ETPusCashViewController


- (UIView *)maskTheView{
    if (!_maskTheView) {
        _maskTheView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _maskTheView.backgroundColor = [UIColor colorWithRed:0/255.f green:0/255.f blue:0/255.f alpha:0.5];
        //添加一个点击手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(maskClickGesture)];
        [_maskTheView addGestureRecognizer:tap];//让header去检测点击手势
    }
    return _maskTheView;
}

- (void)maskClickGesture {
    [self.maskTheView removeFromSuperview];
    [self.shareView removeFromSuperview];

}

- (UIView *)shareView{
    if (!_shareView) {
        _shareView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 160)];
        _shareView.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
        _shareView.backgroundColor = [UIColor whiteColor];
        
    }
    return _shareView;
}

- (void)shareViewController {
    UIImageView *returnImage=[[UIImageView alloc]initWithFrame:CGRectMake(15, 23, 18, 18)];
    returnImage.image=[UIImage imageNamed:@"提现_关闭"];
    [_shareView addSubview:returnImage];
    
    UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(133, 20, 104, 21)];
    lab.text=@"请选择提现账户";
    lab.font=[UIFont systemFontOfSize:15];
    lab.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    [_shareView addSubview:returnImage];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    [self cashOut];
    [self cashoutController];
    [self centerPriceView];
    [self centerPriceController];
    [self shareView];
    [self shareViewController];
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
    _wxImage.image=[UIImage imageNamed:@"支付_支付宝"];
    [_topView addSubview:_wxImage];
    [_wxImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.mas_equalTo(115);
        make.size.mas_equalTo(CGSizeMake(18, 18));
    }];
    
    _accountLabel=[[UILabel alloc]init];
    _accountLabel.text=@"支付宝账户";
    _accountLabel.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    _accountLabel.font=[UIFont systemFontOfSize:13];
    [_topView addSubview:_accountLabel];
    [_accountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.mas_equalTo(143);
        make.size.mas_equalTo(CGSizeMake(70, 18));
    }];
    
    _landLabel=[[UILabel alloc]init];
    _landLabel.text=@"未登录，请先绑定";
    _landLabel.textColor=[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
    _landLabel.font=[UIFont systemFontOfSize:12];
    [_topView addSubview:_landLabel];
    [_landLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(42);
        make.left.mas_equalTo(143);
        make.size.mas_equalTo(CGSizeMake(160, 16));
    }];
    //    [self];
    _bangdingBtn=[[UIButton alloc]init];
    [_bangdingBtn setImage:[UIImage imageNamed:@"出售_进入0 copy"] forState:UIControlStateNormal];
    [_topView addSubview:_bangdingBtn];
    [_bangdingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(21);
        make.right.mas_equalTo(-15);
        make.size.mas_equalTo(CGSizeMake(10, 15));
    }];
    
    UIButton *btnClick = [UIButton buttonWithType:UIButtonTypeCustom];
    [_topView addSubview:btnClick];
    [btnClick mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.wxImage.mas_top).offset(0);
        make.left.mas_equalTo(self.wxImage.mas_left).offset(0);
        make.right.mas_equalTo(self.bangdingBtn.mas_right).offset(0);
        make.bottom.mas_equalTo(self.landLabel.mas_bottom).offset(0);
    }];
    [btnClick addTarget:self action:@selector(bangding) forControlEvents:UIControlEventTouchUpInside];
}

- (void)bangding {
    ETBindViewController *bindVC=[[ETBindViewController alloc]init];
    UIBarButtonItem *backItem = [UIBarButtonItem new];
    backItem.title = @"";
    self.navigationItem.backBarButtonItem = backItem;
    bindVC.block = ^(NSString * _Nonnull account, NSString * _Nonnull name) {
        _account=account;
        _name=name;
        _landLabel.text=[NSString stringWithFormat:@"已绑定 %@",_name];
    };
    [self.navigationController pushViewController:bindVC animated:YES];
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
    _moneyImg=[[UILabel alloc]init];
    _moneyImg.text=@"¥";
    _moneyImg.font=[UIFont systemFontOfSize:30];
    _moneyImg.backgroundColor=[UIColor whiteColor];
    [_centerView addSubview:_moneyImg];
    [_moneyImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(70);
        make.left.mas_equalTo(30);
        make.size.mas_equalTo(CGSizeMake(18, 41));
    }];
    
    _textField=[[UITextField alloc]init];
    _textField.placeholder=@"请输入提现金额";
    _textField.keyboardType=UIKeyboardTypeDecimalPad;
    [_centerView addSubview:self.textField];
        [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(70);
            make.left.mas_equalTo(58);
            make.size.mas_equalTo(CGSizeMake(283, 41));
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
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"账户余额¥%@元，全部提现",_change] attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 12],NSForegroundColorAttributeName: [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0]}];
    
    [string addAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.000000]} range:NSMakeRange(0, 12)];
    
    [string addAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:47/255.0 green:134/255.0 blue:251/255.0 alpha:1.000000]} range:NSMakeRange(string.length-4, 4)];
    _surplusLab.attributedText=string;
    _surplusLab.userInteractionEnabled=YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ClickGesture)];
    [_surplusLab addGestureRecognizer:tap];
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
    [_casBtn addTarget:self action:@selector(aaa) forControlEvents:UIControlEventTouchUpInside];
    _casBtn.layer.cornerRadius = 5;
    [_casBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(172);
        make.left.mas_equalTo(30);
        make.right.mas_equalTo(-30);
        make.height.mas_equalTo(39);
    }];
}
-(void)ClickGesture
{
    _textField.text=[NSString stringWithFormat:@"%@",_change];
}
-(void)ali
{
    [self.view addSubview: self.maskTheView ];
    [self.view addSubview:self.shareView ];
}
- (void) aaa {
    UserInfoModel* info=[UserInfoModel loadUserInfoModel];
    if ([info.isChecked isEqualToString:@"4"]) {
        [MBProgressHUD showMBProgressHud:self.view withText:@"员工不能提现" withTime:1];
        return;
    }
//    [self ali];
    if ([_textField.text isEqualToString:@""]  || _textField.text == nil) {
        [MBProgressHUD showMBProgressHud:self.view withText:@"请输入提现金额" withTime:1];
        return;
    }
    if (!_account&&!_name) {
        [MBProgressHUD showMBProgressHud:self.view withText:@"请先绑定支付宝账户" withTime:1];
        return;
    }

    [self cashToAlipay];
}

-(void)cashToAlipay
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    WeakSelf(self);
    NSString* a=[NSString stringWithFormat:@"%.2f",[_textField.text doubleValue]];
    NSDictionary *params;
//    if ([params isKindOfClass:[NSNull class]] || [params isEqual:[NSNull null]]) {
////        [MBProgressHUD showMBProgressHud:self.view withText:@"请先绑定支付宝" withTime:1];
//        return;
//    }
    params = @{
                             @"amount" : a,
                             @"payeeAccount": _name,
                             @"payerRealName": _account,
                             @"payerShowName": @"",
                             @"remark": @"易转提现"
                             };
    [HttpTool get:[NSString stringWithFormat:@"pay/payFromCompanyToUser"] params:params success:^(id responseObj) {
        [MBProgressHUD hideHUDForView:weakself.view animated:NO];
        if (responseObj && [responseObj isKindOfClass:[NSDictionary class]]) {
//            NSArray *array = responseObj[@"data"][@"rows"];
//            if(array && ![array isKindOfClass:[NSNull class]]){
//
//            }
            NSString *resMsg = [MySingleton filterNull:responseObj[@"msg"]];
            if (resMsg) {
                if ([resMsg isEqualToString:@"提现必须实名认证"]) {
                    [MBProgressHUD showMBProgressHud:self.view withText:@"提现必须在我的->身份认证中实名认证" withTime:1];
                    return;
                }
                
                if ([resMsg rangeOfString:@"余额不足"].location != NSNotFound) {
                    [MBProgressHUD showMBProgressHud:self.view withText:resMsg withTime:1];
                    return;
                }
            }
            
            
            [MBProgressHUD showMBProgressHud:self.view withText:@"请求成功" withTime:1];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popToRootViewControllerAnimated:YES];
            });
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [MBProgressHUD hideHUDForView:weakself.view animated:NO];
    }];
}
@end
