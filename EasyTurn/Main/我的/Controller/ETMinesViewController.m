//
//  ETMineViewController.m
//  EasyTurn
//
//  Created by 程立 on 2019/7/18.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import "ETMinesViewController.h"
#import "Masonry.h"
#import "ETMineVIew.h"
#import "ETMETableViewCell.h"
#import "ETVIPViewController.h"
#import "ETAuthenticateViewController.h"
#import "ETPutViewController.h"
#import "ETAccountViewController.h"
#import "UserMegViewController.h"
#import "ETStoreUpViewController.h"
#import "ETProductModel.h"
#import "ETEnterpriseServiceTableViewCell1.h"
#import "ETFrequencyViewController.h"
#import "WXApiManagerShare.h"
#import "ETPaymentStagesVC.h"
#import "UGameManager.h"
#import "ETDynamicListCell.h"
#import "ETViphuiyuanViewController.h"
#import "ETCartViewController.h"
#import "MCPageViewViewController.h"
#import "ETMeinDynamicListCell.h"
#import "ETProductDetailVC.h"
#import "ETSaleDetailController.h"
#import "ETServiceDetailController.h"
#import "ETForBuyDetailController.h"
#import "ETPoctoryqgViewController.h"
@interface ETMinesViewController ()<UITableViewDataSource,UITableViewDelegate,AccountBindingDelegate>
@property (nonatomic,strong)NSString *checked;
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *dataSource;
@property (nonatomic, strong) NSMutableArray *products;
@property (nonatomic,strong)  UIButton *deleBtn;
@property (nonatomic,strong)  UIButton *refchBtn;
@property (nonatomic,strong)  UIButton *shareBtn;
@property (nonatomic, strong) NSMutableArray *counts;
@property (nonatomic,strong) NSString * share;
@property (nonatomic,assign)int select1;
//提示框
@property (nonatomic,strong) UIView * maskTheView;
@property (nonatomic,strong) UIView * shareView;

@property (nonatomic,assign)int aa;

@property (nonatomic,strong) NSString* select;
@property (nonatomic,strong) UIView * maskTheView1;
@property (nonatomic,strong) UIView * shareView1;
@property (nonatomic,strong) UILabel * lab1;
@property (nonatomic,strong) UILabel *lab;
@property (nonatomic,strong)ETMineVIew *mineview;

@end

static NSString *const cellIdentifier =@"cellIdentifier";
@implementation ETMinesViewController
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
        _shareView1 = [[UIView alloc]initWithFrame:CGRectMake(30, Screen_Height/2-100, Screen_Width-60,200)];
        //        _shareView.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
        _shareView1.layer.cornerRadius=20;
        _shareView1.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
        
    }
    return _shareView1;
}
//添加提示框
- (void)shareViewController1 {
    UIImageView *returnImage=[[UIImageView alloc]initWithFrame:CGRectMake(20, 23, 50, 50)];
    returnImage.image=[UIImage imageNamed:@"dropdown_loading_01"];
    returnImage.userInteractionEnabled = YES;
    [_shareView1 addSubview:returnImage];
    UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(80, 25, Screen_Width, 45)];
    UserInfoModel* info=[UserInfoModel loadUserInfoModel];
    lab.text=[NSString stringWithFormat:@"您的剩余刷新次数%@",info.refreshCount];
    lab.textColor=[UIColor blackColor];
    lab.font =[UIFont systemFontOfSize:20];
    _lab=lab;
    [_shareView1 addSubview:lab];
    _lab1=[[UILabel alloc]initWithFrame:CGRectMake(20, 75, Screen_Width-90, 50)];
    
    _lab1.numberOfLines=0;
    _lab1.textColor=[UIColor blackColor];
    _lab1.font =[UIFont systemFontOfSize:14];
    [_shareView addSubview:self.lab1];
    
    UIButton *returnbtn =[[UIButton alloc]initWithFrame:CGRectMake(_shareView.size.width-150, 155, 50, 21)];
    [returnbtn setTitle:@"关闭" forState:UIControlStateNormal];
    returnbtn.titleLabel.font=[UIFont systemFontOfSize:15];
    [returnbtn addTarget:self action:@selector(clickImage11) forControlEvents:UIControlEventTouchUpInside];
    [returnbtn setTitleColor:[UIColor colorWithRed:243/255.0 green:22/255.0 blue:22/255.0 alpha:1.0] forState:UIControlStateNormal];
    [_shareView1 addSubview:returnbtn];
    
    UIButton *surebtn =[[UIButton alloc]initWithFrame:CGRectMake(_shareView.size.width-100, 155, 50, 21)];
    [surebtn setTitle:@"确定" forState:UIControlStateNormal];
    surebtn.titleLabel.font=[UIFont systemFontOfSize:15];
    [surebtn setTitleColor:[UIColor colorWithRed:243/255.0 green:22/255.0 blue:22/255.0 alpha:1.0] forState:UIControlStateNormal];
    [surebtn addTarget:self action:@selector(postuia) forControlEvents:UIControlEventTouchUpInside];
    //    _surebtn=surebtn;
    [_shareView1 addSubview:surebtn];
    
}

- (void)clickImage11 {
    [self.maskTheView1 removeFromSuperview];
    [self.shareView1 removeFromSuperview];
}

- (void)postuia {
    [self PostUI2];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.navigationController popViewControllerAnimated:YES];
        [self.maskTheView1 removeFromSuperview];
        [self.shareView1 removeFromSuperview];
    });
    
}

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
        _shareView = [[UIView alloc]initWithFrame:CGRectMake(30, Screen_Height/2-80, Screen_Width-60,200)];
        _shareView.layer.cornerRadius=10;
        //        _shareView.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
        _shareView.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
        
    }
    return _shareView;
}
- (void)shareViewController {
    UIButton *returnImage=[[UIButton alloc]initWithFrame:CGRectMake(0, 140, _shareView.size.width, 60)];
    [returnImage setTitle:@"取消" forState:UIControlStateNormal];
    [returnImage setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickImage)];
    [returnImage addGestureRecognizer:tapGesture];
    [_shareView addSubview:returnImage];
    
    UIView*centerView=[[UIView alloc]init];
    centerView.backgroundColor= [UIColor colorWithRed:230/255.f green:230/255.f blue:230/255.f alpha:0.5];
    [_shareView addSubview:centerView];
    [centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(140);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
    UIButton *wxPyShare=[[UIButton alloc]initWithFrame:CGRectMake((_shareView.size.width-200)/2, 20, 40, 60)];
    [wxPyShare setImage:[UIImage imageNamed:@"分享_分组 4"] forState:UIControlStateNormal];
    UITapGestureRecognizer *tapGesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickImage1)];
    [wxPyShare addGestureRecognizer:tapGesture1];
    [_shareView addSubview:wxPyShare];
    
    UIButton *wxPyqShare=[[UIButton alloc]initWithFrame:CGRectMake((_shareView.size.width+100)/2, 20, 40, 60)];
    [wxPyqShare setImage:[UIImage imageNamed:@"分享_分组 7"] forState:UIControlStateNormal];
    UITapGestureRecognizer *tapGesture2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickImage2)];
    [wxPyqShare addGestureRecognizer:tapGesture2];
    [_shareView addSubview:wxPyqShare];
    
    UILabel* label=[[UILabel alloc] initWithFrame:CGRectMake(10, 100, _shareView.frame.size.width-20, 40)];
    label.text=@"分享一次赠送刷新次数6次(每天10次机会)";
    label.font = SYSTEMFONT(13);
    label.textColor=[UIColor redColor];
    label.textAlignment=UITextAlignmentCenter;
    [_shareView addSubview:label];
    
}
-(void)getshare
{
    
}
- (void)clickImage {
    [self.maskTheView removeFromSuperview];
    [self.shareView removeFromSuperview];
}

- (void)clickImage1 {
    [self delfav1];
    _select1=0;
    [self clickImage];
}

- (void)clickImage2 {
    [self delfav1];
     _select1=1;
    [self clickImage];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    
    if (!_mineview) {

    ETMineVIew *mineview = [[ETMineVIew alloc] init];
    
    mineview.frame = CGRectMake(0,0,Screen_Width,438);
    mineview.layer.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor;
    mineview.block = ^(NSString * _Nonnull a) {
        _select=a;
        [self PostUI:a];
        _aa=a;
    };
    _mineview=mineview;
    mineview.delegate=self;

    _tableView.tableHeaderView = mineview;
    _tableView.rowHeight=158;
    }
    [self PostUI:@"1"];
    
    _select=@"1";

    [self shareView1];
    if (!_lab) {
        [self shareViewController1];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
    while ([_maskTheView1.subviews lastObject] != nil)
    {
        [(UIView*)[_maskTheView1.subviews lastObject] removeFromSuperview];
    }
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}
- (UITableView *) tableView {
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height-kTabBarHeight) style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.bounces=NO;
         _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableFooterView=[[UIView alloc
                                     ]initWithFrame:CGRectZero];
//        [_tableView registerClass:[ETMETableViewCell class] forCellReuseIdentifier:cellIdentifier];
        [_tableView registerClass:[ETEnterpriseServiceTableViewCell1 class] forCellReuseIdentifier:@"cell"];
//        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    }
    return _tableView;
}
-(NSMutableArray *)dataSource
{
    if (!_dataSource)
    {
        _dataSource=[NSMutableArray array];
        
    }
    return _dataSource;
}
-(void)viewDidLoad
{
    [super viewDidLoad];
    [self viewWillDisappear:YES];
    self.title=@"分享详情";
    [self viewDidAppear:YES];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestRefreshMine) name:Refresh_Mine object:nil];
    
    _lab1.text=@"确定刷新吗？";
//    _select=@"1";
    [self.view addSubview:self.tableView];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    ETMineVIew*etmine=[[ETMineVIew alloc]init];
    etmine.delegate=self;
    [self PostuserinfoUI];
    [self PostUI:@"1"];
//    [self PostBaiduUI];
    UGameManager* mgr= [UGameManager instance];
    [mgr iniStoreKit];
    [self shareView];
    [self shareViewController];
}

#pragma mark - 出售全部订单
- (void)PostUI:(NSString*)a {
    NSMutableDictionary* dic=[NSMutableDictionary new];
    NSDictionary *params = @{
                             @"page" : @"1",
                             @"pageSize": @"10",
                             @"cityId": @(2),
                             @"releaseTypeId": a
                             };

    [HttpTool get:[NSString stringWithFormat:@"release/orders"] params:params success:^(id responseObj) {
        _products=[NSMutableArray new];
        NSDictionary* a=responseObj[@"data"];
        if (responseObj && [responseObj isKindOfClass:[NSDictionary class]]) {
            NSArray *array = responseObj[@"data"];
            if(array && ![array isKindOfClass:[NSNull class]]){
                [_products addObjectsFromArray:array];
                [_tableView reloadData];

            }
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return _products.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ETMeinDynamicListCell* cell= [ETMeinDynamicListCell dynamicListCell:tableView dict:_products[indexPath.row]];
    if ([_select isEqualToString:@"2"]) {
        cell.labelDesc.text=@"";
    }else if([_select isEqualToString:@"3"]) {
        cell.labelDesc.text=@"";
    }else if ([_select isEqualToString:@""]) {
//        cell.labelDesc.text=[cell.labelDesc.text stringByReplacingOccurrencesOfString:@"经营范围" withString:@"详细内容"];
                 cell.labelDesc.text=@"";
    }
    if ([_select isEqualToString:@"2"]) {
        cell.labelTag.text=@"";
    }
    _deleBtn =[[UIButton alloc]init];
    _deleBtn.tag=indexPath.row;
    [_deleBtn setTitle:@"删除" forState:UIControlStateNormal];
    if ([_select isEqualToString:@"1"]) {
        [_deleBtn addTarget:self action:@selector(aaaa:) forControlEvents:UIControlEventTouchUpInside];
    }else if([_select isEqualToString:@"3"]) {
        [_deleBtn addTarget:self action:@selector(aaaa:) forControlEvents:UIControlEventTouchUpInside];
    }else if([_select isEqualToString:@"2"]) {
        [_deleBtn addTarget:self action:@selector(aaaa:) forControlEvents:UIControlEventTouchUpInside];
    }
    if ([_select isEqualToString:@""]) {
        _deleBtn.tag=indexPath.row;
        [_deleBtn setTitle:@"删除" forState:UIControlStateNormal];
        [_deleBtn addTarget:self action:@selector(delfav123:) forControlEvents:UIControlEventTouchUpInside];
    }
    [_deleBtn setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0] forState:UIControlStateNormal];
    [cell addSubview:self.deleBtn];
    _deleBtn.layer.borderWidth=1;
    _deleBtn.layer.cornerRadius=4;
    _deleBtn.titleLabel.font=[UIFont systemFontOfSize:13 weight:9];
    _deleBtn.layer.borderColor=[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0].CGColor;
   
    [_deleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(120);
        make.right.mas_equalTo(-15);
        make.size.mas_equalTo(CGSizeMake(60, 26));
    }];
    _refchBtn =[[UIButton alloc]init];
    [_refchBtn setTitle:@"刷新" forState:UIControlStateNormal];
    _refchBtn.backgroundColor=[UIColor whiteColor];
   
//    [_refchBtn setTitle:@"查看" forState:UIControlStateNormal];
    if ([_select isEqualToString:@""]) {
        _refchBtn.tag=indexPath.row;
        [_refchBtn setTitle:@"查看" forState:UIControlStateNormal];
        [_refchBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
         _refchBtn.backgroundColor=[UIColor colorWithRed:20/255.0 green:138/255.0 blue:236/255.0 alpha:1.0];
        [_refchBtn addTarget:self action:@selector(gopay:) forControlEvents:UIControlEventTouchUpInside];
    }else if ([_select isEqualToString:@"1"]) {
        [_refchBtn addTarget:self action:@selector(refrechShare) forControlEvents:UIControlEventTouchUpInside];
    }else if ([_select isEqualToString:@"3"]) {
        [_refchBtn addTarget:self action:@selector(refrechShare) forControlEvents:UIControlEventTouchUpInside];
    }else if ([_select isEqualToString:@"2"]) {
        [_refchBtn addTarget:self action:@selector(refrechShare) forControlEvents:UIControlEventTouchUpInside];
    }
    if ([_select isEqualToString:@""]) {
        [_refchBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal  ];
    }
    else{
        [_refchBtn setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0] forState:UIControlStateNormal  ];

    }
//    [[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0]]
    [cell addSubview:self.refchBtn];
    _refchBtn.layer.borderWidth=1;
    _refchBtn.layer.cornerRadius=4;
    _refchBtn.titleLabel.font=[UIFont systemFontOfSize:13 weight:9];
    _refchBtn.layer.borderColor=[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0].CGColor;
    [_refchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(120);
        make.right.mas_equalTo(-84);
        make.size.mas_equalTo(CGSizeMake(60, 26));
    }];
    
    _shareBtn =[[UIButton alloc]init];
    [_shareBtn setTitle:@"分享" forState:UIControlStateNormal];
    if ([_select isEqualToString:@""]) {
        _shareBtn.hidden=YES;
    }
    [_shareBtn setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0] forState:UIControlStateNormal];
    [cell addSubview:self.shareBtn];
    _shareBtn.layer.borderWidth=1;
    _shareBtn.layer.cornerRadius=4;
    [_shareBtn addTarget:self action:@selector(aaaaaa) forControlEvents:UIControlEventTouchUpInside];
    _shareBtn.titleLabel.font=[UIFont systemFontOfSize:13 weight:9];
    _shareBtn.layer.borderColor=[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0].CGColor;
    [_shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(120);
        make.right.mas_equalTo(-154);
        make.size.mas_equalTo(CGSizeMake(60, 26));
    }];
    ETProductModel* model=[ETProductModel mj_objectWithKeyValues:[_products objectAtIndex:indexPath.row]];
    if (![_select isEqualToString:@""]) {
        if (![model.tradStatus isEqualToString:@"0"]) {
            _refchBtn.hidden=YES;
            _shareBtn.hidden=YES;
        }
    }
    return cell;
    
//    ETMETableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
//    cell=[[ETMETableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
//    return cell;
}

- (void)deledingdan {
//    [self delfav123];
}

- (void)refrechShare {
    [self.view addSubview:self.maskTheView1];
    if (_lab) {
        [_lab removeFromSuperview];
        [self.view addSubview:self.shareView1];
        [self shareViewController1];
    }
    
}


//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
//}
- (void)aaaa:(UIButton*)sender {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:nil
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction * action) {
                                                             //响应事件
                                                             NSLog(@"action = %@", action);
                                                         }];
    UIAlertAction* deleteAction = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive
                                                         handler:^(UIAlertAction * action) {
                                                             //响应事件
                                                             [self delfav:sender];
                                                             NSLog(@"action = %@", action);
                                                             [_tableView reloadData];
                                                            
                                                         }];
    [alert addAction:cancelAction];
    [alert addAction:deleteAction];
    [self presentViewController:alert animated:YES completion:nil];
//     [self.tableView reloadData];
}


- (void)aaaaaa {
    [self.view addSubview:self.maskTheView];
    [self.view addSubview:self.shareView];
}
//出售，服务，求购删除
-(void)delfav:(UIButton*)sender
{
    NSDictionary *dict =[_products objectAtIndex:sender.tag];
    ETProductModel* p=[ETProductModel mj_objectWithKeyValues:dict];
    long long a=[p.releaseId longLongValue];
    NSDictionary *params = @{
                             @"releaseId" : @(a)
                             };
    NSData *data =    [NSJSONSerialization dataWithJSONObject:params options:NSUTF8StringEncoding error:nil];
    
    [HttpTool put:[NSString stringWithFormat:@"release/resultDel"] params:params success:^(NSDictionary *response) {
        //        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"");
        [MBProgressHUD showMBProgressHud:self.view withText:@"删除成功" withTime:1];
//        [_tableView reloadData];
        [self PostUI:_select];
    } failure:^(NSError *error) {
        NSLog(@"");
        
    }];
}
//订单删除
-(void)delfav123:(UIButton*)sender
{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:nil
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction * action) {
                                                             //响应事件
                                                             NSLog(@"action = %@", action);
                                                         }];
    UIAlertAction* deleteAction = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive
                                                         handler:^(UIAlertAction * action) {
                                                             //响应事件
                                                             [self delOrder:sender];
                                                             NSLog(@"action = %@", action);
                                                             [_tableView reloadData];
                                                             
                                                         }];
    [alert addAction:cancelAction];
    [alert addAction:deleteAction];
    [self presentViewController:alert animated:YES completion:nil];
}
//订单删除
-(void)delOrder:(UIButton*)sender
{
    NSDictionary *dict =[_products objectAtIndex:sender.tag];
    ETProductModel* p=[ETProductModel mj_objectWithKeyValues:dict];
    long long a=[p.releaseOrderId longLongValue];
    NSDictionary *params = @{
                             @"id" : @(a)
                             };
    NSData *data =    [NSJSONSerialization dataWithJSONObject:params options:NSUTF8StringEncoding error:nil];
    
    [HttpTool put:[NSString stringWithFormat:@"release/OrderDel"] params:params success:^(NSDictionary *response) {
        //        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"");
        
        [MBProgressHUD showMBProgressHud:self.view withText:@"删除成功" withTime:1];
        [self PostUI:@""];
    } failure:^(NSError *error) {
        NSLog(@"");
        
    }];
}
#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0: // 转发到会话
            [[WXApiManagerShare sharedManager] sendLinkContent:[[NSURL URLWithString:[NSString stringWithFormat:@"%@",_share]] absoluteString]
                                                         Title:self.title
                                                   Description:@"分享一个链接"
                                                       AtScene:WXSceneSession];
            break;
        case 1: //分享到朋友圈
            [[WXApiManagerShare sharedManager] sendLinkContent:[[NSURL URLWithString:[NSString stringWithFormat:@"%@",_share]] absoluteString]
                                                         Title:self.title
                                                   Description:@"分享一个链接"
                                                       AtScene:WXSceneTimeline];
            break;
        default:
            break;
    }
}

- (void)delfav1 {
    NSDictionary *dict =[_products objectAtIndex:0];
    ETProductModel* p=[ETProductModel mj_objectWithKeyValues:dict];
    long long a=[p.releaseId longLongValue];
    NSUserDefaults* user=[NSUserDefaults standardUserDefaults];
    NSString* token=[user objectForKey:@"token"];
    NSDictionary *params = @{
                             @"id" : @(a)
                             };
    NSData *data =    [NSJSONSerialization dataWithJSONObject:params options:NSUTF8StringEncoding error:nil];
    
    [HttpTool get:[NSString stringWithFormat:@"user/shareReleaseById"] params:params success:^(NSDictionary *response) {
        _share=response[@"data"];
        //        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:nil];
         [_tableView reloadData];
        if (_select1==0) {
            
            [[WXApiManagerShare sharedManager] sendLinkContent:[[NSURL URLWithString:[NSString stringWithFormat:@"%@",_share]] absoluteString]
                                                         Title:self.title
                                                   Description:@"分享一个链接"
                                                       AtScene:WXSceneSession];
        }
        if (_select1==1) {
            
            [[WXApiManagerShare sharedManager] sendLinkContent:[[NSURL URLWithString:[NSString stringWithFormat:@"%@",_share]] absoluteString]
                                                         Title:self.title
                                                   Description:@"分享一个链接"
                                                       AtScene:WXSceneTimeline];
        }
        NSLog(@"");
       
    } failure:^(NSError *error) {
        NSLog(@"");
        
    }];
}
#pragma mark - 出售全部订单

- (void)PostUI2 {
    NSDictionary *dict =[_products objectAtIndex:0];
    ETProductModel* p=[ETProductModel mj_objectWithKeyValues:dict];
    long long a=[p.releaseId longLongValue];
    NSDictionary*params = @{
                             @"releaseId" :@(a),
                             };
    
    [HttpTool get:[NSString stringWithFormat:@"release/refresh"] params:params success:^(id responseObj) {
        NSLog(@"====================刷新成功");
        NSString *str=responseObj[@"code"];
        if ([str isEqualToString:@"0"]) {
               [MBProgressHUD showMBProgressHud:self.view withText:@"刷新成功" withTime:1];
        }else {
            [MBProgressHUD showMBProgressHud:self.view withText:@"刷新失败，请充值刷新次数" withTime:1];
        }
        int r= [_mineview.numLab.text intValue];
        r--;
        if (r<0) {
            UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提示" message:@"不能再刷新" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            
            [alter show];
            return;
        }
        _mineview.numLab.text=[NSString stringWithFormat:@"%i",r];
        //        NSLog(@"");
       [_tableView reloadData];
        [self PostuserinfoUI];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)putjumpWeb:(UIButton *)sender {
    ETPutViewController*putVC=[ETPutViewController new];
    putVC.block = ^{
        [_mineview postUI];
    };
    UIBarButtonItem *backItem = [UIBarButtonItem new];
    backItem.title = @"";
    self.navigationItem.backBarButtonItem = backItem;
    [self.navigationController pushViewController:putVC animated:YES];
}


-(void)imgjumpWeb:(UIImageView *)sender
{
    
}

- (void)jumpWebVC:(UIButton*)sender
{
    ETViphuiyuanViewController *webVC = [ETViphuiyuanViewController new];
//    ETVIPViewController* webVC=[ETVIPViewController new];
    UIBarButtonItem *backItem = [UIBarButtonItem new];
    backItem.title = @"";
    self.navigationItem.backBarButtonItem = backItem;
    [self.navigationController pushViewController:webVC animated:YES];
}
- (void)jumpWebVC1:(UIButton*)sender
{
    ETAuthenticateViewController *webVC = [ETAuthenticateViewController new];
    UIBarButtonItem *backItem = [UIBarButtonItem new];
    backItem.title = @"";
    self.navigationItem.backBarButtonItem = backItem;
    [self.navigationController pushViewController:webVC animated:YES];
}

- (void)jumpWebVC2:(UIButton*)sender
{
    ETStoreUpViewController *webVC = [ETStoreUpViewController new];
    UIBarButtonItem *backItem = [UIBarButtonItem new];
    backItem.title = @"";
    self.navigationItem.backBarButtonItem = backItem;
    [self.navigationController pushViewController:webVC animated:YES];
}

- (void)jumpWebVC3:(UIButton*)sender
{
    ETAccountViewController *webVC = [ETAccountViewController new];
    UIBarButtonItem *backItem = [UIBarButtonItem new];
    backItem.title = @"";
    self.navigationItem.backBarButtonItem = backItem;
    [self.navigationController pushViewController:webVC animated:YES];
}

- (void)jumpWebVC4:(UIButton *)sender {
    ETFrequencyViewController *etfre=[[ETFrequencyViewController alloc]init];
    [self.navigationController pushViewController:etfre animated:YES];
    
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
        _checked=info.isChecked;
        if ([_checked isEqualToString:@"5"]) {
            MCPageViewViewController*pageVC=[[MCPageViewViewController alloc]init];
            UIBarButtonItem *backItem = [UIBarButtonItem new];
            backItem.title = @"";
            self.navigationItem.backBarButtonItem = backItem;
            [self.navigationController pushViewController:pageVC animated:YES];
            return;
        }else{
            
            [MBProgressHUD showMBProgressHud:self.view withText:@"您还未进行企业法人认证，快去认证吧！" withTime:1];
            return;
        }
        NSLog(@"");
        //        [_tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
- (void)PostuserinfoUI {
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
        _checked=info.isChecked;
//        if ([_checked isEqualToString:@"5"]) {
//            MCPageViewViewController*pageVC=[[MCPageViewViewController alloc]init];
//            UIBarButtonItem *backItem = [UIBarButtonItem new];
//            backItem.title = @"";
//            self.navigationItem.backBarButtonItem = backItem;
//            [self.navigationController pushViewController:pageVC animated:YES];
//            return;
//        }else{
//
//
//        }
        NSLog(@"");
        //        [_tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)jumpWebVC5:(UIButton *)sender {
    [self PostUI];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
    
   ETMETableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    // 2
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    // 3点击没有颜色改变
    cell.selected = NO;
    
    NSDictionary *dict =[_products objectAtIndex:indexPath.row];
    ETProductModel* p=[ETProductModel mj_objectWithKeyValues:dict];
    if (!p.releaseOrderId) {
         if ([_select isEqualToString:@"1"]) {
             //出售
            NSDictionary *dict =[_products objectAtIndex:indexPath.row];
             ETSaleDetailController *vc = [ETSaleDetailController saleDetailController:dict];
             vc.product = [ETProductModel mj_objectWithKeyValues:dict];
             [self.navigationController pushViewController:vc animated:YES];
             
         }else if ([_select isEqualToString:@"3"]) {
             //服务
             NSDictionary *dict =[_products objectAtIndex:indexPath.row];
             ETServiceDetailController * detail=[ETServiceDetailController serviceDetailController:dict];
             detail.product = [ETProductModel mj_objectWithKeyValues:dict];
             [self.navigationController pushViewController:detail animated:YES];
             
         }else if ([_select isEqualToString:@"2"]) {
             //求购
             ETPoctoryqgViewController *detail=[ETPoctoryqgViewController new];
             NSDictionary *dict =[_products objectAtIndex:indexPath.row];
             detail.releaseId = dict[@"releaseId"];
             detail.product = [ETProductModel mj_objectWithKeyValues:dict];
             [self.navigationController pushViewController:detail animated:YES];
         }
    }
    else
        [self PostCountUI:p];
}
-(void)gopay:(UIButton*)sender
{
    NSDictionary *dict =[_products objectAtIndex:sender.tag];

    ETProductModel* p=[ETProductModel mj_objectWithKeyValues:dict];
    [self PostCountUI:p];
}
#pragma mark - 获取分期计数
- (void)PostCountUI:(ETProductModel*)p {
    NSMutableDictionary* dic=[NSMutableDictionary new];
    NSDictionary *params = @{
                             @"releaseId": p.releaseOrderId
                             };
    
    [HttpTool get:[NSString stringWithFormat:@"pay/findOrderByReleaseId"] params:params success:^(id responseObj) {
        _counts=[NSMutableArray new];
        NSDictionary* a=responseObj[@"data"];
        for (NSDictionary* prod in responseObj[@"data"]) {
            ETProductModel* temp=[ETProductModel mj_objectWithKeyValues:prod];
            [_counts addObject:temp];
        }
        NSLog(@"");
        ETPaymentStagesVC *payVC=[ETPaymentStagesVC paymentStagesVC:_counts.count];
        payVC.product=p;
        payVC.finalPrice= p.price;
        payVC.releaseOrderId=p.releaseOrderId;
        [self.navigationController pushViewController:payVC animated:YES];
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

#pragma mark - 支付成功后通知刷新页面
- (void)requestRefreshMine {
    [_mineview postUI];
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
