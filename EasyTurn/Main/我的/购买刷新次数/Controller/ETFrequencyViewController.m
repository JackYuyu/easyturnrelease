//
//  ETFrequencyViewController.m
//  EasyTurn
//
//  Created by 王翔 on 2019/8/2.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import "ETFrequencyViewController.h"
#import "MEVIPTableViewCell.h"
#import "ETProductModel.h"
#import "ETMineModel.h"
#import "WXApiRequestHandler.h"
#import "WXApiManager.h"
#import "WechatAuthSDK.h"
#import "WXApiObject.h"
#import <AlipaySDK/AlipaySDK.h>
#import "APOrderInfo.h"
#import "APAuthInfo.h"
#import "APRSASigner.h"
#import "UserInfoModel.h"
#import "WXApiManagerShare.h"
#import "SSPayUtils.h"
#import "ETViphuiyuanModel.h"
#define kOrderId @"OrderId"
@interface ETFrequencyViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView*tab;
@property(nonatomic,strong)NSMutableArray*products;
@property (nonatomic,strong) UIView * maskTheView;
@property (nonatomic,strong) UIView * shareView;
@property (nonatomic,strong) UIButton * wxBtn;
@property (nonatomic,strong) UIButton * zfbBtn;
@property (nonatomic,assign) int paytype;
@property (nonatomic,strong) NSString *vipid;
@property (nonatomic,strong)MEVIPTableViewCell*cell;
@property (nonatomic,strong) UIButton *subBtn;
@property (nonatomic,strong) NSString* aliprice;
@property (nonatomic,strong) UIButton* issign;

@property (nonatomic,strong) UIView * maskTheView1;
@property (nonatomic,strong) UIView * shareView1;

@property (nonatomic,strong) UIButton *bottomTitleBtn1;
@property (nonatomic,strong) UILabel *centerTitleLab1;
@property (nonatomic,strong)NSString *invitationCodeUtilMe;
@end

@implementation ETFrequencyViewController
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
        _shareView = [[UIView alloc]initWithFrame:CGRectMake(0, Screen_Height-303, Screen_Width,303)];
        if (IPHONE_X) {
            _shareView = [[UIView alloc]initWithFrame:CGRectMake(0, Screen_Height-303-24, Screen_Width,303)];
        }
        //        _shareView.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
        _shareView.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
        
    }
    return _shareView;
}
- (void)shareViewController {
    UIImageView *returnImage=[[UIImageView alloc]initWithFrame:CGRectMake(15, 23, 18, 18)];
    returnImage.image=[UIImage imageNamed:@"提现_关闭"];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickImage)];
    [returnImage addGestureRecognizer:tapGesture];
    returnImage.userInteractionEnabled = YES;
    [_shareView addSubview:returnImage];
    
    UILabel *lab=[[UILabel alloc]init];
    lab.text=@"请选择支付方式";
    lab.font=[UIFont systemFontOfSize:15];
    lab.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    [_shareView addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.mas_equalTo(133);
        make.right.mas_equalTo(-133);
        make.height.mas_equalTo(21);
    }];
    
    UIView*topView=[[UIView alloc]init];
    topView.backgroundColor= [UIColor colorWithRed:242/255.f green:242/255.f blue:242/255.f alpha:0.5];
    [_shareView addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(60);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(1);
    }];
    
    UIImageView *wxImg=[[UIImageView alloc]init];
    wxImg.image=[UIImage imageNamed:@"提现_微信"];
    [_shareView addSubview:wxImg];
    [wxImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(75);
        make.left.mas_equalTo(15);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    UILabel *wxLab=[[UILabel alloc]init];
    wxLab.text=@"微信账户";
    wxLab.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    [_shareView addSubview:wxLab];
    [wxLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(79);
        make.left.mas_equalTo(57);
        make.size.mas_equalTo(CGSizeMake(119, 21));
    }];
    
    _wxBtn=[[UIButton alloc]init];
    [_wxBtn setImage:[UIImage imageNamed:@"注册_未选中"] forState:UIControlStateNormal];
    [_wxBtn setImage:[UIImage imageNamed:@"注册_选中"] forState:UIControlStateSelected];
    _wxBtn.tag=0;
    [_shareView addSubview:_wxBtn];
    [_wxBtn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_wxBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(79);
        make.right.mas_equalTo(-13);
        make.size.mas_equalTo(CGSizeMake(19, 19));
    }];
    
    UIView*centerView=[[UIView alloc]init];
    centerView.backgroundColor= [UIColor colorWithRed:242/255.f green:242/255.f blue:242/255.f alpha:0.5];
    [_shareView addSubview:centerView];
    [centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(119);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(1);
    }];
    
    UIImageView *zfbImg=[[UIImageView alloc]init];
    zfbImg.image=[UIImage imageNamed:@"提现_支付宝"];
    [_shareView addSubview:zfbImg];
    [zfbImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(135);
        make.left.mas_equalTo(15);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    UILabel *zfbLab=[[UILabel alloc]init];
    zfbLab.text=@"支付宝账户";
    zfbLab.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    [_shareView addSubview:zfbLab];
    [zfbLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(139);
        make.left.mas_equalTo(57);
        make.size.mas_equalTo(CGSizeMake(134, 21));
    }];
    
    _zfbBtn=[[UIButton alloc]init];
    [_zfbBtn setImage:[UIImage imageNamed:@"注册_未选中"] forState:UIControlStateNormal];
    [_zfbBtn setImage:[UIImage imageNamed:@"注册_选中"] forState:UIControlStateSelected];
    _zfbBtn.tag=1;
    [_shareView addSubview:_zfbBtn];
    [_zfbBtn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_zfbBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(139);
        make.right.mas_equalTo(-13);
        make.size.mas_equalTo(CGSizeMake(19, 19));
    }];
    
    UIView*botomView=[[UIView alloc]init];
    botomView.backgroundColor= [UIColor colorWithRed:242/255.f green:242/255.f blue:242/255.f alpha:0.5];
    [_shareView addSubview:botomView];
    [botomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(179);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(1);
    }];
    
    UIButton *goPayBtn = [[UIButton alloc]init];
    goPayBtn.backgroundColor= [UIColor colorWithRed:20/255.0 green:138/255.0 blue:236/255.0 alpha:1.0];
    [goPayBtn setTitle:@"去支付" forState:UIControlStateNormal];
    goPayBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    goPayBtn.layer.cornerRadius = 12;
    [goPayBtn addTarget:self action:@selector(stagepay) forControlEvents:UIControlEventTouchUpInside];
    [_shareView addSubview:goPayBtn];
    [goPayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(189);
        make.left.mas_equalTo(51);
        make.right.mas_equalTo(-51);
        make.height.mas_equalTo(39);
    }];
}

- (void)clickImage {
    [self.maskTheView removeFromSuperview];
    [self.shareView removeFromSuperview];
}

-(void)titleBtnClick:(UIButton *)btn
{
    if (btn!= _wxBtn) {
        self.wxBtn.selected = NO;
        btn.selected = YES;
        self.wxBtn = btn;
    }else{
        self.wxBtn.selected = YES;
        _paytype=2;

    }
    if (btn!= _zfbBtn) {
        self.zfbBtn.selected = NO;
        btn.selected = YES;
        self.zfbBtn = btn;
    }else{
        self.zfbBtn.selected = YES;
        _paytype=1;

    }
    if (btn.tag==0) {
        _paytype=2;
    }
    if (btn.tag==1) {
        _paytype=1;
    }
}


- (UIView *)maskTheView1{
    if (!_maskTheView1) {
        _maskTheView1 = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _maskTheView1.backgroundColor = [UIColor colorWithRed:0/255.f green:0/255.f blue:0/255.f alpha:0.5];
        //添加一个点击手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(maskClickGesture1)];
        [_maskTheView1 addGestureRecognizer:tap];//让header去检测点击手势
    }
    return _maskTheView1;
}

- (void)maskClickGesture1 {
    [self.maskTheView1 removeFromSuperview];
    [self.shareView1 removeFromSuperview];
    
}

- (UIView *)shareView1{
    if (!_shareView1) {
        _shareView1 = [[UIView alloc]initWithFrame:CGRectMake(Screen_Width/2-150, Screen_Height/2-200, 300,320)];
//        if (IPHONE_X) {
//            _shareView1 = [[UIView alloc]initWithFrame:CGRectMake(0, Screen_Height-303-24, Screen_Width,303)];
//        }
        _shareView1.layer.cornerRadius = 18;
        //        _shareView.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
        _shareView1.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
        
    }
    return _shareView1;
}
- (void)shareViewController1 {
    UIImageView *returnImage=[[UIImageView alloc]initWithFrame:CGRectMake(-15, -23, 18, 18)];
    returnImage.image=[UIImage imageNamed:@"邀请码_关闭"];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickImage1)];
    [returnImage addGestureRecognizer:tapGesture];
    returnImage.userInteractionEnabled = YES;
    [_shareView1 addSubview:returnImage];
    
    UIImageView *topImg =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _shareView1.size.width, 100)];
    topImg.image=[UIImage imageNamed:@"邀请码_分组 3"];
    topImg.userInteractionEnabled = YES;
    [_shareView1 addSubview:topImg];
    
    UILabel *titleLab=[[UILabel alloc]initWithFrame:CGRectMake(_shareView1.size.width/2-50, 30, 120, 50)];
    titleLab.text=@"邀请好友";
    titleLab.textColor=[UIColor whiteColor];
    titleLab.font=[UIFont systemFontOfSize:25];
     [_shareView1 addSubview:titleLab];
    
    UILabel *centerTitleLab=[[UILabel alloc]initWithFrame:CGRectMake(_shareView1.size.width/2-50, 110, 120, 30)];
    centerTitleLab.text=@"我的邀请码";
    centerTitleLab.textColor=[UIColor colorWithRed:47/255.0 green:134/255.0 blue:251/255.0 alpha:1.0];
    centerTitleLab.font=[UIFont systemFontOfSize:20];
    [_shareView1 addSubview:centerTitleLab];
    
   _centerTitleLab1=[[UILabel alloc]initWithFrame:CGRectMake(_shareView1.size.width/2-80, 140, 160, 30)];
//    NSString* token=[userInfoModel objectForKey:@"invitationCodeUtilMe"];
  
    _centerTitleLab1.textColor=[UIColor orangeColor];
    _centerTitleLab1.font=[UIFont systemFontOfSize:23];
    [_shareView1 addSubview:_centerTitleLab1];
    
    UIButton *centerTitleBtn=[[UIButton alloc]initWithFrame:CGRectMake(_shareView1.size.width/2-30, 190, 60, 30)];
    [centerTitleBtn setTitle:@"复制" forState:UIControlStateNormal];
    centerTitleBtn.layer.cornerRadius=10;
    [centerTitleBtn addTarget:self action:@selector(YQM) forControlEvents:UIControlEventTouchUpInside];
    centerTitleBtn.backgroundColor=[UIColor colorWithRed:47/255.0 green:134/255.0 blue:251/255.0 alpha:1.0];
    [_shareView1 addSubview:centerTitleBtn];
    
    UIButton *bottomTitleBtn1=[[UIButton alloc]initWithFrame:CGRectMake(_shareView1.size.width/2-70, 240, 50, 50)];
    [bottomTitleBtn1 setImage:[UIImage imageNamed:@"邀请码_分组 2"] forState:UIControlStateNormal];
    [bottomTitleBtn1 addTarget:self action:@selector(shareYQM) forControlEvents:UIControlEventTouchUpInside];
    [_shareView1 addSubview:bottomTitleBtn1];
    
    UIButton *bottomTitleBtn=[[UIButton alloc]initWithFrame:CGRectMake(_shareView1.size.width/2+20, 240, 50, 50)];
    [bottomTitleBtn setImage:[UIImage imageNamed:@"邀请码_分组 4"] forState:UIControlStateNormal];
    [bottomTitleBtn addTarget:self action:@selector(shareYQM) forControlEvents:UIControlEventTouchUpInside];
    [_shareView1 addSubview:bottomTitleBtn];
    
    
    
}

-(void)PostInfoUI
{
    ETProductModel* p=[_products objectAtIndex:0];
    
    NSDictionary *params = @{
                         
                             };
    
    [HttpTool get:[NSString stringWithFormat:@"user/info"] params:params success:^(id responseObj) {
        //        _products=[NSMutableArray new];
        NSDictionary* a=responseObj[@"data"];
        UserInfoModel* info=[UserInfoModel mj_objectWithKeyValues:responseObj[@"data"][@"userInfo"]];
       _invitationCodeUtilMe=info.invitationCodeUtilMe;
        _centerTitleLab1.text=[NSString stringWithFormat:@"%@",_invitationCodeUtilMe];
        NSLog(@"");
//        dispatch_async(dispatch_get_main_queue(), ^{
//            //                [self showError:@"微信授权失败"];
//            NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:5];
//            [_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
//        });
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}


- (void)YQM {
    [MBProgressHUD showMBProgressHud:self.view withText:@"已复制" withTime:1];
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = _centerTitleLab1.text;
}

- (void)shareYQM {
    [self actionSheet:_bottomTitleBtn1 clickedButtonAtIndex:0];
}

- (void)clickImage1 {
    [self.maskTheView1 removeFromSuperview];
    [self.shareView1 removeFromSuperview];
}

-(UITableView *)tab {
    if (!_tab) {
        _tab=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height) style:UITableViewStyleGrouped];
        _tab.delegate=self;
        _tab.dataSource=self;
        _tab.rowHeight=60;
        [_tab registerClass:[MEVIPTableViewCell class] forCellReuseIdentifier:@"cell"];
        _tab.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0,0,0,0.01)];
        _tab.sectionFooterHeight =0;
    }
    return _tab;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"购买次数";
    [self enableLeftBackWhiteButton];
    [WRNavigationBar wr_setDefaultNavBarTitleColor:kACColorWhite];
    self.view.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.tab];
    [self PostUI:@"1"];
    [self shareView];
    [self shareViewController];
    [self shareView1];
    [self shareViewController1];
    [self PostissignUI];
    [self PostInfoUI];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestPayResult) name:Request_PayResult object:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return _products.count;
    }else if (section==1) {
        return 3;
    }
    return YES;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MEVIPTableViewCell*cell=[[MEVIPTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section==0) {
        ETMineModel *m=[_products objectAtIndex:indexPath.row];
        cell.titleLab.text=m.title;
        cell.subTitleLab.text=m.money;
        cell.subTitleLab.textColor=[UIColor colorWithRed:248/255.0 green:124/255.0 blue:43/255.0 alpha:1.0];
        [cell.subBtn setTitle:@"购买" forState:UIControlStateNormal];
        cell.subBtn.backgroundColor=[UIColor orangeColor];
        cell.subBtn.layer.cornerRadius=10;
        cell.subBtn.titleLabel.font=[UIFont systemFontOfSize:13];
        cell.subBtn.tag=indexPath.row;
        [cell.subBtn addTarget:self action:@selector(goumaiBtn:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:cell.subBtn];
    }else if (indexPath.section==1) {
        NSArray*arr=@[@"新用户注册成功首次登录送10次刷新",@"每日签到送一次刷新",@"邀请好友注册成功送10次刷新"];
        cell.textLabel.text=arr[indexPath.row];
        if (indexPath.row==0) {
            [cell.subBtn setTitle:@"已获得" forState:UIControlStateNormal];
            [cell.subBtn  setTitleColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0] forState:UIControlStateNormal];
            cell.subBtn .backgroundColor=[UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
            [cell  addSubview:cell.subBtn ];
            [cell.subBtn  mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(17);
                make.right.mas_equalTo(-15);
                make.size.mas_equalTo(CGSizeMake(59, 25));
            }];
        }else if (indexPath.row==1) {
            _subBtn=cell.subBtn;

            [cell.subBtn setTitle:@"签到" forState:UIControlStateNormal];
            [cell.subBtn setTitle:@"已签到" forState:UIControlStateSelected];
            [cell.subBtn  setTitleColor:[UIColor colorWithRed:248/255.0 green:124/255.0 blue:43/255.0 alpha:1.0] forState:UIControlStateNormal];
            [cell.subBtn setTitleColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0] forState:UIControlStateSelected];
            UserInfoModel *user =[UserInfoModel loadUserInfoModel];
            if ([user.isSign isEqualToString:@"1"]) {
                
                NSLog(@"1");
                //            [_signBtn endEditing:NO];
                [_subBtn setTitle:@"已签到" forState:UIControlStateNormal];
                [_subBtn setTitleColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0] forState:UIControlStateNormal];
                 _subBtn.backgroundColor=[UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
//                _subBtn.layer.borderColor=[UIColor lightGrayColor].CGColor;
                _subBtn.enabled=NO;
            }else {
                NSLog(@"2");
                [_subBtn setTitle:@"签到" forState:UIControlStateNormal];
                cell.subBtn.backgroundColor=[UIColor whiteColor];
                cell.subBtn.layer.borderWidth=1;
                cell.subBtn.layer.borderColor=[UIColor colorWithRed:248/255.0 green:124/255.0 blue:43/255.0 alpha:1.0].CGColor;
                //                    _subBtn.selected=YES;
            }
            [cell  addSubview:cell.subBtn];
//            cell.subBtn.layer.borderWidth=1;
            [cell.subBtn addTarget:self action:@selector(aaa:) forControlEvents:UIControlEventTouchUpInside];
//            cell.subBtn.layer.borderColor=[UIColor colorWithRed:248/255.0 green:124/255.0 blue:43/255.0 alpha:1.0].CGColor;
            _issign=cell.subBtn;
            [cell.subBtn  mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(17);
                make.right.mas_equalTo(-15);
                make.size.mas_equalTo(CGSizeMake(59, 25));
            }];
        }else if (indexPath.row==2) {
            [cell.subBtn setTitle:@"去邀请" forState:UIControlStateNormal];
            [cell.subBtn  setTitleColor:[UIColor colorWithRed:248/255.0 green:124/255.0 blue:43/255.0 alpha:1.0] forState:UIControlStateNormal];
            [cell  addSubview:cell.subBtn ];
            cell.subBtn.backgroundColor=[UIColor whiteColor];
            [cell.subBtn addTarget:self action:@selector(diaoyongfengx) forControlEvents:UIControlEventTouchUpInside];
            cell.subBtn.layer.borderWidth=1;
            cell.subBtn.layer.borderColor=[UIColor colorWithRed:248/255.0 green:124/255.0 blue:43/255.0 alpha:1.0].CGColor;
            [cell.subBtn  mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(17);
                make.right.mas_equalTo(-15);
                make.size.mas_equalTo(CGSizeMake(59, 25));
            }];
        }
    }
    
    return cell;
}

- (void)PostUI {
    NSMutableDictionary* dic=[NSMutableDictionary new];
    NSUserDefaults* user=[NSUserDefaults standardUserDefaults];
    if (![user objectForKey:@"uid"]) {
        return;
    }
    NSDictionary *params = @{
                             @"uid" : [user objectForKey:@"uid"]
                             };
    
    [HttpTool get:[NSString stringWithFormat:@"user/info"] params:params success:^(id responseObj) {
        //        _products=[NSMutableArray new];
        NSDictionary* a=responseObj[@"data"];
        UserInfoModel* info=[UserInfoModel mj_objectWithKeyValues:responseObj[@"data"][@"userInfo"]];
        [UserInfoModel saveUserInfoModel:info];
//        if ([info.isSign isEqualToString:@"1"]) {
//            [_subBtn setTitle:@"已签到" forState:UIControlStateNormal];
//        }else
//        {
//            [_subBtn setTitle:@"签到" forState:UIControlStateNormal];
//        }
        NSLog(@"");
        //        [_tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}


- (void)aaa:(UIButton*)sender {

    [self PostUI111];

}

- (void)PostUI111 {
    NSDictionary *params = @{
                             
                             };

    NSData *data = [NSJSONSerialization dataWithJSONObject:params options:NSUTF8StringEncoding error:nil];
    [HttpTool get:[NSString stringWithFormat:@"user/isSign"] params:params success:^(NSDictionary *response) {
        
        NSString* a=response[@"data"][@"status"];
        [self PostSignUI1212:_subBtn];
        
        if ([a isEqualToString:@"1"]) {
//            [MBProgressHUD showMBProgressHud:self withText:@"您今天已签到！" withTime:1];
            NSLog(@"1");
            [_subBtn endEditing:NO];
            [_subBtn setTitle:@"已签到" forState:UIControlStateNormal];
            
            UserInfoModel* info=[UserInfoModel loadUserInfoModel];
            info.isSign=@"1";
            [UserInfoModel saveUserInfoModel:info];
            [_tab reloadData];
//            [self PostUI];
        }else if ([a isEqualToString:@"0"]) {
            NSLog(@"2");
            [_subBtn setTitle:@"签到" forState:UIControlStateNormal];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"0");
        NSLog(@"失败");
    }];
    
}
- (void)PostSignUI1212:(NSString*)head {
    NSDictionary *params = @{
                             };
    NSData *data =    [NSJSONSerialization dataWithJSONObject:params options:NSUTF8StringEncoding error:nil];
    [HttpTool put:[NSString stringWithFormat:@"user/sign"] params:params success:^(NSDictionary *response) {
        NSString* a=response[@"data"][@"status"];
        
        [_subBtn endEditing:NO];
    } failure:^(NSError *error) {
        NSLog(@"失败");
    }];
    
}

-(void)diaoyongfengx {
    
    [self.view addSubview:self.maskTheView1];
    [self.view addSubview:self.shareView1];
//     [self actionSheet:_cell.subBtn clickedButtonAtIndex:nil];
    
}

- (void)actionSheet:(UIButton *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0: // 转发到会话
            [[WXApiManagerShare sharedManager] sendLinkContent:[[NSURL URLWithString:@"www.baidu.com"] absoluteString]
                                                         Title:@"分享邀请码"
                                                   Description:_centerTitleLab1.text
                                                       AtScene:WXSceneSession];
            break;
        case 1: //分享到朋友圈
            [[WXApiManagerShare sharedManager] sendLinkContent:[[NSURL URLWithString:@"www.baidu.com"] absoluteString]
                                                         Title:@"分享邀请码"
                                                   Description:_centerTitleLab1.text
                                                       AtScene:WXSceneTimeline];
            break;
        default:
            break;
    }
}


- (void)PostissignUI {
    NSDictionary *params = @{
                             
                             };
    NSData *data = [NSJSONSerialization dataWithJSONObject:params options:NSUTF8StringEncoding error:nil];
    [HttpTool get:[NSString stringWithFormat:@"user/isSign"] params:params success:^(NSDictionary *response) {
        
        UserInfoModel* info=[UserInfoModel loadUserInfoModel];
        
        NSString* a=response[@"data"][@"status"];
        if ([info.isSign isEqualToString:@"1"]) {
            
            NSLog(@"1");
//            [_signBtn endEditing:NO];
            [_issign setTitle:@"已签到" forState:UIControlStateNormal];
            [_issign setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            _issign.layer.borderColor=[UIColor lightGrayColor].CGColor;
            _issign.enabled=NO;
            
        }else if ([a isEqualToString:@"0"]) {
            NSLog(@"2");
            _issign.selected=YES;
        }
        
    } failure:^(NSError *error) {
        NSLog(@"0");
        NSLog(@"失败");
    }];
    
}
- (void)fanhuishangyiji {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)goumaiBtn:(UIButton*)sender {

    int a =sender.tag;

    if ([MySingleton sharedMySingleton].review == 1) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        NSString* productid;
        if (a==0) {
            productid=@"EasyTurn.yzqylzpt.refresh10";
        }
        if (a==1) {
            productid=@"EasyTurn.yzqylzpt.refresh20";
        }
        UGameManager* mgr= [UGameManager instance];
        mgr.block = ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        };
        if (mgr.canProcessPayments) {
            [mgr purchaseItem:productid];
        }
    }else {
        [self.view addSubview:self.maskTheView];
        [self.view addSubview:self.shareView];
        ETMineModel* m=[_products objectAtIndex:a];
        _vipid=m.vipid;
        _aliprice=[m.money substringFromIndex:1];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [_tab deselectRowAtIndexPath:indexPath animated:YES];
    
    MEVIPTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    // 2
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    // 3点击没有颜色改变
    cell.selected = NO;
}

- (void)PostUI:(NSString*)a {
    NSMutableDictionary* dic=[NSMutableDictionary new];
    NSDictionary *params = @{
                             };
    [HttpTool get:[NSString stringWithFormat:@"buy/getRefreshList"] params:params success:^(id responseObj) {
        _products=[NSMutableArray new];
        NSDictionary* a=responseObj[@"data"];
        for (NSDictionary* prod in responseObj[@"data"][@"list"]) {
            ETMineModel *m=[ETMineModel mj_objectWithKeyValues:prod];
            NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
            //            if (m) {
            [_products addObject:m];
            //            }
        }
        [_tab reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

#pragma mark - 去支付
- (void)stagepay {
   
    [self requestWithPayType:_paytype];
    [self clickImage];
}

- (void)requestWithPayType:(NSInteger )payType {
    //调用第三方支付前,保存支付状态值
    [SSPayUtils shareUser].State = @"begin";
    
    NSDictionary *params = @{
                             @"id" : @([_vipid intValue]),
                             @"type" : @(payType)
                             
                             };
    [HttpTool get:[NSString stringWithFormat:@"pay/prePay"] params:params success:^(id responseObj) {
        //存储订单ID
        NSString* orderId = responseObj[@"data"][@"id"];
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:orderId forKey:kOrderId];
        [userDefaults synchronize];
        
        NSString* result = responseObj[@"data"][@"result"];
        if (payType == 1) {
            [[AlipaySDK defaultService] payOrder:result fromScheme:kAppScheme callback:^(NSDictionary *resultDic) {
                
            }];
        }else if (payType == 2){
            NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:[result dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
            NSDictionary* dictResult = [jsonDict copy];
            [self wechatPay:dictResult];
        }
    } failure:^(NSError *error) {
        
    }];
}

- (void)wxPay {
   
}

- (void)alipay {
    
    NSDictionary *params = @{
                             @"id" : @([_vipid intValue]),
                             @"type" : @(_paytype)
                             
                             };
    [HttpTool get:[NSString stringWithFormat:@"pay/prePay"] params:params success:^(id responseObj) {
        //存储订单ID
        NSString* orderId = responseObj[@"data"][@"id"];
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:orderId forKey:kOrderId];
        [userDefaults synchronize];
        
        NSString* payOrder = responseObj[@"data"][@"result"];
        [[AlipaySDK defaultService] payOrder:payOrder fromScheme:kAppScheme callback:^(NSDictionary *resultDic) {
            
        }];
        NSLog(@"");
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    
}

- (void)wechatPay:(NSDictionary*)d {
    
    NSString *res = [WXApiRequestHandler jumpToBizPay:d];
    if( ![@"" isEqual:res] ){
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"支付失败" message:res delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alter show];
    }
}

#pragma mark - 请求网络查询支付结果
- (void)requestPayResult {
    WEAKSELF
    [[ACToastView toastView]showLoadingCircleViewWithStatus:@"正在加载中"];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *orderId = [userDefaults objectForKey:kOrderId];
    [ETViphuiyuanModel requestPayResultWithOrderId:orderId WithSuccess:^(id request, STResponseModel *response, id resultObject) {
        if (response.code == 0) {
            ETViphuiyuanModel *model = response.data;
            if ([model.result isEqualToString:@"1"]) {
                //支付成功
                [[ACToastView toastView]showSuccessWithStatus:@"支付成功" completion:^{
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                    //通知我的页面刷新数据
                    [[NSNotificationCenter defaultCenter]postNotificationName:Refresh_Mine object:nil];
                }];
            }else {
                [[ACToastView toastView]showInfoWithStatus:@"支付失败"];
            }
        }else{
            if (response.msg.length > 0) {
                [[ACToastView toastView] showErrorWithStatus:response.msg];
            } else {
                [[ACToastView toastView] showErrorWithStatus:kToastErrorServerNoErrorMessage];
            }
        }
    } failure:^(id request, NSError *error) {
        
    }];
    
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
