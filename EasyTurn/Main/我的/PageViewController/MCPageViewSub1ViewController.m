//
//  MCPageViewSub1ViewController.m
//  QQFoundation
//
//  Created by qinmuqiao on 2018/9/19.
//  Copyright © 2018年 慕纯. All rights reserved.
//

#import "MCPageViewSub1ViewController.h"
#import "ETCheckStaffViewController.h"
#import "SSNavigationController.h"
@interface MCPageViewSub1ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UIView *topView;
@property (nonatomic,strong)UIImageView *userImg;
@property (nonatomic,strong)UILabel *comLab;
@property (nonatomic,strong)UILabel *regLab;
@property (nonatomic,strong)UILabel *infoLab;
@property (nonatomic,strong)UITableView *tab;
@property (nonatomic,strong)NSString *name;

@property (nonatomic,strong)NSString *mobile;

@end

@implementation MCPageViewSub1ViewController

-(UITableView *)tab {
    if (!_tab) {
        _tab=[[UITableView alloc]initWithFrame:CGRectMake(0, 250, Screen_Width, 98) style:UITableViewStylePlain];
        _tab.delegate=self;
        _tab.dataSource=self;
        _tab.bounces=NO;
        _tab.rowHeight=49;
        _tab.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0,0,0,0.01)];
    }
    return _tab;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:@"cell"];
    NSArray *arr=@[@"法   人:",@"联系电话:"];
    cell.textLabel.text=arr[indexPath.row];
    cell.textLabel.textColor=[UIColor blackColor];
    NSArray *arr1=@[@"法人姓名",@"18888888888"];
    cell.detailTextLabel.text=arr1[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UserInfoModel* info=[UserInfoModel loadUserInfoModel];

    if (_name&&indexPath.row==0) {
        cell.detailTextLabel.text=_name;
        
    }
    if(info.name&&indexPath.row==0)
        cell.detailTextLabel.text=info.name;
        
    if (_mobile&&indexPath.row==1) {
        cell.detailTextLabel.text=_mobile;

    }
    [cell.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.centerY.mas_equalTo(cell.contentView);
    }];
    return cell;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    [self qiyerengzheng];
    [self.view addSubview:self.tab];
    [self PostUI];
    [self PostCorpUI];
    
//    UIView* view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 44)];
//    [view setBackgroundColor:kACColorWhite];
//    UIButton* btn=[UIButton new];
//    [btn setTitle:@"员工管理" forState:UIControlStateNormal];
//    btn.titleLabel.font=[UIFont systemFontOfSize:14];
//    btn.layer.cornerRadius = 10;
//    btn.backgroundColor=[UIColor colorWithRed:20/255.0 green:138/255.0 blue:236/255.0 alpha:1.0];
//    [btn addTarget:self action:@selector(PostStaffUI) forControlEvents:UIControlEventTouchUpInside];
//    [view addSubview:btn];
//    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.mas_equalTo(120);
//        make.center.mas_equalTo(view);
//    }];
//    [self.view addSubview:view];
//    [view mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.mas_equalTo(self.view);
//        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-100);
//    }];
    
    UIButton *subBtn=[[UIButton alloc]initWithFrame:CGRectMake(10, Screen_Height-260, Screen_Width-20, 40)];
    subBtn.backgroundColor =[UIColor colorWithRed:47/255.0 green:134/255.0 blue:251/255.0 alpha:1.0];
    [subBtn setTitle:@"员工申请" forState:UIControlStateNormal];
        [subBtn addTarget:self action:@selector(PostStaffUI) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:subBtn];
}
-(void)PostStaffUI
{
    ETCheckStaffViewController* v=[[ETCheckStaffViewController alloc] init];

    SSNavigationController *nav = [[SSNavigationController alloc] initWithRootViewController:v];

    nav.modalPresentationStyle = UIModalPresentationOverCurrentContext;

    nav.view.backgroundColor = [UIColor clearColor];
    
    [self presentViewController:nav animated:YES completion:nil];
//    naviRoot.navigationBarHidden = NO;
//    [self.navigationController pushViewController:v animated:YES];
//    [self presentViewController:v animated:YES completion:nil];
}
- (void) qiyerengzheng {
    _topView=[[UIView alloc]initWithFrame:CGRectMake(0, 10, Screen_Width, 200)];
    _topView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.topView];
    
    _userImg=[[UIImageView alloc]initWithFrame:CGRectMake(12, 12, 54, 54)];
    _userImg.image=[UIImage imageNamed:@"我的_Bitmap"];
    [self.topView addSubview:self.userImg];
    
    _comLab=[[UILabel alloc]initWithFrame:CGRectMake(79, 14, 200, 21)];
    _comLab.text=@"北京易转科技信息有限公司";
    _comLab.font=[UIFont systemFontOfSize:15];
    _comLab.textColor=[UIColor blackColor];
    [self.topView addSubview:self.comLab];
    
    _regLab=[[UILabel alloc]initWithFrame:CGRectMake(79, 44, 60, 20)];
    _regLab.layer.borderWidth=1;
    _regLab.layer.borderColor=[UIColor colorWithRed:47/255.0 green:134/255.0 blue:251/255.0 alpha:1.0].CGColor;
    _regLab.text=@"工商注册";
    _regLab.textColor=[UIColor colorWithRed:47/255.0 green:134/255.0 blue:251/255.0 alpha:1.0];
    _regLab.layer.cornerRadius = 5;
    _regLab.textAlignment = NSTextAlignmentCenter;
    _regLab.font=[UIFont systemFontOfSize:11];
    [self.topView addSubview:self.regLab];
    
    _infoLab=[[UILabel alloc]initWithFrame:CGRectMake(79, 74, 280, 100)];
    _infoLab.text=@"简介：航空客运票务代理服务；软件服务；基础软件服务；应用软件服务；数据处理（数据处理中的银行卡中心、PUE值在1.4以上的云计算数据中心除外）；企业管理；财务咨询；市场调查。";
    _infoLab.font=[UIFont systemFontOfSize:14];
    _infoLab.textColor=[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    _infoLab.numberOfLines = 0;
    [self.topView addSubview:_infoLab];
}

#pragma mark - 法人
- (void)PostUI {
    NSMutableDictionary* dic=[NSMutableDictionary new];
    UserInfoModel* info=[UserInfoModel loadUserInfoModel];
    NSDictionary *params = @{
                             @"id" : @([info.uid longLongValue])
                             };
    [HttpTool get:[NSString stringWithFormat:@"user/getCorporationInfo"] params:params success:^(id responseObj) {
        //        _products=[NSMutableArray new];
        //        NSDictionary* a=responseObj[@"data"];
        //        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:responseObj options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"");
        NSDictionary *dictResult = [MySingleton filterNull:responseObj[@"data"]];
        if (dictResult) {
            _mobile=[MySingleton filterNull:dictResult[@"mobile"]];
            NSString *urlTemp = [MySingleton filterNull:dictResult[@"headImageUrl"]];
            if (urlTemp) {
                [_userImg sd_setImageWithURL:[NSURL URLWithString:urlTemp]];
            }
            
            [_tab reloadData];
            
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
#pragma mark - 公司
- (void)PostCorpUI {
    NSMutableDictionary* dic=[NSMutableDictionary new];
    UserInfoModel* info=[UserInfoModel loadUserInfoModel];
    NSDictionary *params = @{
                             @"id" : @([info.uid intValue])
                             };
    [HttpTool get:[NSString stringWithFormat:@"user/getCompanyInfo"] params:params success:^(id responseObj) {
        //        _products=[NSMutableArray new];
        //        NSDictionary* a=responseObj[@"data"];
        //        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:responseObj options:NSJSONReadingMutableLeaves error:nil];
        NSDictionary *dictResult = [MySingleton filterNull:responseObj[@"data"]];
        if (dictResult) {
            _mobile=[MySingleton filterNull:dictResult[@"mobile"]];

            _comLab.text=[MySingleton filterNull:dictResult[@"companyName"]];
            [_tab reloadData];
        }
        
        NSLog(@"");
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

@end
