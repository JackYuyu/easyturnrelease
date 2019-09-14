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
@property (nonatomic,strong) UIButton *bottomTitleBtn1;
@property (nonatomic,strong) UILabel *centerTitleLab1;
@property (nonatomic,strong)NSString *invitationCodeUtilMe;
@property (nonatomic,strong) UIButton *tenRefrech;
@property (nonatomic,strong) UIButton *twentyRefrech;
@property (nonatomic,strong) UIButton *goPayBtn;
@property (nonatomic,assign) int proprty;
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
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}


- (void)YQM {
    [MBProgressHUD showMBProgressHud:self.view withText:@"已复制" withTime:1];
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = _centerTitleLab1.text;
}



-(UITableView *)tab {
    if (!_tab) {
        _tab=[[UITableView alloc]initWithFrame:CGRectMake(0, 20, Screen_Width, Screen_Height) style:UITableViewStyleGrouped];
        _tab.delegate=self;
        _tab.dataSource=self;
        _tab.rowHeight=60;
        [_tab registerClass:[MEVIPTableViewCell class] forCellReuseIdentifier:@"cell"];
        _tab.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0,0,0,0.01)];
        _tab.sectionFooterHeight =0;
        UIView* v=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 140)];
        _goPayBtn = [[UIButton alloc]init];
        _goPayBtn.backgroundColor= [UIColor colorWithRed:20/255.0 green:138/255.0 blue:236/255.0 alpha:1.0];
        [_goPayBtn setTitle:@"立即支付" forState:UIControlStateNormal];
        _goPayBtn.titleLabel.font=[UIFont systemFontOfSize:15];
        _goPayBtn.layer.cornerRadius = 20;
        _goPayBtn.userInteractionEnabled=YES;
        [_goPayBtn addTarget:self action:@selector(stagepay) forControlEvents:UIControlEventTouchUpInside];
        [v addSubview:_goPayBtn];
        
//        [v mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(0);
//            make.left.mas_equalTo(15);
//            make.right.mas_equalTo(-15);
//            make.height.mas_equalTo(39);
//        }];
        [_goPayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(30);
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.height.mas_equalTo(39);
        }];
        
        _tab.tableFooterView=v;
    }
    return _tab;
}
- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title=@"购买次数";
    self.view.backgroundColor=RGBCOLOR(242, 242, 242);
    [self enableLeftBackWhiteButton];
    [WRNavigationBar wr_setDefaultNavBarTitleColor:kACColorWhite];
    [self setNavi1];
//    self.view.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.tab];
    [self PostUI:@"1"];
    [self shareView];
    [self shareViewController];
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
        if (indexPath.row==0) {
            _tenRefrech=[[UIButton alloc]init];
           
            [cell addSubview:_tenRefrech];
            _tenRefrech.tag=0;
            _tenRefrech.backgroundColor=[UIColor clearColor];
            [_tenRefrech addTarget:self action:@selector(titlesBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [_tenRefrech mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(0);
                make.left.mas_equalTo(15);
                make.right.mas_equalTo(-15);
                make.bottom.mas_equalTo(0);
            }];
        }else if (indexPath.row==1) {
            _twentyRefrech=[[UIButton alloc]init];
            _twentyRefrech.tag=1;
            [cell addSubview:_twentyRefrech];
           
            _twentyRefrech.backgroundColor=[UIColor clearColor];
            [_twentyRefrech addTarget:self action:@selector(titlesBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [_twentyRefrech mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(0);
                make.left.mas_equalTo(15);
                make.right.mas_equalTo(-15);
                make.bottom.mas_equalTo(0);
            }];
        }
        UIButton* b=[UIButton new];
        b.tag=0;
        [self titlesBtnClick:b];
        
        ETMineModel *m=[_products objectAtIndex:indexPath.row];
        cell.titleLab.text=[NSString stringWithFormat:@"%@刷新",m.condition];
        cell.subTitleLab.text=m.money;
        cell.subTitleLab.textColor=[UIColor colorWithRed:248/255.0 green:124/255.0 blue:43/255.0 alpha:1.0];
        [cell.titleLab setFont:[UIFont systemFontOfSize:15]];
        [cell.subTitleLab setFont:[UIFont systemFontOfSize:15]];

        [cell.subBtn setTitle:@"" forState:UIControlStateNormal];
        cell.subBtn.backgroundColor=[UIColor orangeColor];
        cell.subBtn.layer.cornerRadius=10;
        cell.subBtn.titleLabel.font=[UIFont systemFontOfSize:13];
        cell.subBtn.tag=indexPath.row;
        [cell.subBtn addTarget:self action:@selector(goumaiBtn:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:cell.subBtn];
    }else if (indexPath.section==1) {
        [cell.subBtn setTitle:@"" forState:UIControlStateNormal];
        cell.subBtn.backgroundColor=[UIColor clearColor];
//        NSArray*arr=@[@"新用户注册成功首次登录送10次刷新",@"每日签到送一次刷新",@"邀请好友注册成功送10次刷新"];
//        cell.textLabel.text=arr[indexPath.row];
        if (indexPath.row==0) {
            UILabel *lab=[[UILabel alloc]init];
            lab.text=@"支付方式";
            lab.font=[UIFont systemFontOfSize:18];
            lab.textColor=[UIColor blackColor];
            [cell addSubview:lab];
            [lab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(15);
                make.left.mas_equalTo(15);
                make.right.mas_equalTo(-133);
                make.height.mas_equalTo(21);
            }];
        }else if (indexPath.row==1) {
            UIImageView *wxImg=[[UIImageView alloc]init];
            wxImg.image=[UIImage imageNamed:@"提现_微信"];
            [cell addSubview:wxImg];
            [wxImg mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(15);
                make.left.mas_equalTo(15);
                make.size.mas_equalTo(CGSizeMake(30, 30));
            }];
            
            UILabel *wxLab=[[UILabel alloc]init];
            wxLab.text=@"微信账户";
            wxLab.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
            [cell addSubview:wxLab];
            [wxLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(19);
                make.left.mas_equalTo(57);
                make.size.mas_equalTo(CGSizeMake(119, 21));
            }];
            
            _wxBtn=[[UIButton alloc]init];
            [_wxBtn setImage:[UIImage imageNamed:@"注册_未选中"] forState:UIControlStateNormal];
            [_wxBtn setImage:[UIImage imageNamed:@"注册_选中"] forState:UIControlStateSelected];
            _wxBtn.tag=0;
            [cell addSubview:_wxBtn];
            [_wxBtn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [_wxBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(19);
                make.right.mas_equalTo(-13);
                make.size.mas_equalTo(CGSizeMake(19, 19));
            }];
        }else if (indexPath.row==2) {
            UIImageView *zfbImg=[[UIImageView alloc]init];
            zfbImg.image=[UIImage imageNamed:@"提现_支付宝"];
            [cell addSubview:zfbImg];
            [zfbImg mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(15);
                make.left.mas_equalTo(15);
                make.size.mas_equalTo(CGSizeMake(30, 30));
            }];
            
            UILabel *zfbLab=[[UILabel alloc]init];
            zfbLab.text=@"支付宝账户";
            zfbLab.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
            [cell addSubview:zfbLab];
            [zfbLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(19);
                make.left.mas_equalTo(57);
                make.size.mas_equalTo(CGSizeMake(134, 21));
            }];
            
            _zfbBtn=[[UIButton alloc]init];
            [_zfbBtn setImage:[UIImage imageNamed:@"注册_未选中"] forState:UIControlStateNormal];
            [_zfbBtn setImage:[UIImage imageNamed:@"注册_选中"] forState:UIControlStateSelected];
            _zfbBtn.tag=1;
            [cell addSubview:_zfbBtn];
            [_zfbBtn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [_zfbBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(19);
                make.right.mas_equalTo(-13);
                make.size.mas_equalTo(CGSizeMake(19, 19));
            }];
            
            UILabel * placeholder=[[UILabel  alloc]init];
            placeholder.text=@"新用户注册成功首次登陆送10次刷新";
            placeholder.font=[UIFont systemFontOfSize:12];
            placeholder.textColor=kACColorRGB(153, 153, 153);
            [cell addSubview:placeholder];
            [placeholder mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(cell.mas_bottom).mas_offset(5);
                make.left.mas_equalTo(15);
                make.right.mas_equalTo(-51);
                make.height.mas_equalTo(15);
            }];
            
            

        }
    }
    
    return cell;
}

-(void)titlesBtnClick:(UIButton *)btn
{
    if (btn.tag==0) {
        NSLog(@"1");
        _tenRefrech.backgroundColor=[UIColor clearColor];
        _tenRefrech.alpha=0.5;
        _tenRefrech.layer.borderWidth=2;
        _tenRefrech.layer.borderColor=kACColorRGB(248, 124, 43).CGColor;
        _twentyRefrech.backgroundColor=[UIColor clearColor];
        _twentyRefrech.layer.borderWidth=2;
        _twentyRefrech.layer.borderColor=[UIColor clearColor].CGColor;
       
    }else if (btn.tag==1) {
        NSLog(@"2");
        _tenRefrech.backgroundColor=[UIColor clearColor];
        _tenRefrech.layer.borderWidth=2;
        _tenRefrech.layer.borderColor=[UIColor clearColor].CGColor;
        _twentyRefrech.backgroundColor=[UIColor clearColor];
        _twentyRefrech.alpha=0.5;
        _twentyRefrech.layer.borderWidth=2;
        _twentyRefrech.layer.borderColor=kACColorRGB(248, 124, 43).CGColor;
      
    }
    int a =btn.tag;
    
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
//        [self.view addSubview:self.maskTheView];
//        [self.view addSubview:self.shareView];
        ETMineModel* m=[_products objectAtIndex:a];
        _vipid=m.vipid;
        _aliprice=[m.money substringFromIndex:1];
    }
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
    
    if (indexPath.row==1) {
        _paytype=2;
    }
    if (indexPath.row==2) {
        _paytype=1;
    }
    
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
