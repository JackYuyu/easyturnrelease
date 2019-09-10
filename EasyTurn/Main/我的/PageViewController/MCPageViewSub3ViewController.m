//
//  MCPageViewSub3ViewController.m
//  QQFoundation
//
//  Created by qinmuqiao on 2018/12/12.
//  Copyright © 2018年 慕纯. All rights reserved.
//

#import "MCPageViewSub3ViewController.h"
#import "ETAdimiTableViewCell.h"
#import "member.h"
#import "ETProductModel.h"
#import "ETPaymentStagesVC.h"
@interface MCPageViewSub3ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UIButton *ordersBtn;
@property (nonatomic,strong)UIButton *ordersBtn1;
@property (nonatomic,strong)UIButton *ordersBtn2;
@property (nonatomic,strong)UITableView *tab;
@property(nonatomic,strong)NSMutableArray* members;
@property(nonatomic,strong)NSMutableArray* counts;

@end

@implementation MCPageViewSub3ViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
- (UITableView *)tab {
    if (!_tab) {
        _tab=[[UITableView alloc]initWithFrame:CGRectMake(0, 30, Screen_Width, Screen_Height) style:UITableViewStylePlain];
        _tab.delegate=self;
        _tab.dataSource=self;
        _tab.rowHeight=150;
        _tab.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
        
        [_tab registerNib:[UINib nibWithNibName:@"ETAdimiTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    }
    return _tab;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _members.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ETAdimiTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    ETProductModel* m=[_members objectAtIndex:indexPath.row];
    [cell.userImg sd_setImageWithURL:[NSURL URLWithString:m.headImageUrl]];
    cell.comLab.text=m.title;
    cell.addressLab.text=m.cityName;
    cell.manyLab.text=m.price;
    cell.nameLab.text=m.username;
    
    cell.yifuLab.tag=indexPath.row;
    cell.deleLab.tag=indexPath.row;
    
    NSString* temp=m.tradStatus;
    
    if ([temp isEqualToString:@"1"]) {
        cell.payLab.text=@"已发起,等待卖家确认";
    }else if ([temp isEqualToString:@"2"]){
        cell.payLab.text=@"卖家已确认交易详情";
    }
    else if ([temp isEqualToString:@"3"]){
        cell.payLab.text=@"支付完成,等待卖家确认";
    }
    else if ([temp isEqualToString:@"4"]){
        cell.payLab.text=@"卖家发起交易完成,等待买家确认";
    }
    else if ([temp isEqualToString:@"5"]){
        cell.payLab.text=@"交易完成";

    }
    cell.block = ^(NSInteger pid) {
        ETProductModel* p=[_members objectAtIndex:pid];
        [self PostCountUI:p];
    };
    
    cell.block1 = ^(NSInteger pid) {
        [self delOrder:(pid)];
    };
//    [cell.yifuLab setTitle:@"" forState:UIControlStateNormal];

//    [cell.deleLab setTitle:@"" forState:UIControlStateNormal];

    return cell;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    UIView * screeView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 30)];
    screeView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:screeView];
    
    UILabel *screenLab =[[UILabel alloc]initWithFrame:CGRectMake(30,0 , 40, 20)];
    screenLab.text=@"筛选";
    screenLab.textColor=[UIColor colorWithRed:47/255.0 green:134/255.0 blue:251/255.0 alpha:1.0];
    screenLab.font=[UIFont systemFontOfSize:13];
    [screeView addSubview:screenLab];
    
    _ordersBtn=[[UIButton alloc]initWithFrame:CGRectMake(75, 2, 15, 15)];
    [_ordersBtn setImage:[UIImage imageNamed:@"注册_未选中"] forState:UIControlStateNormal];
    [_ordersBtn setImage:[UIImage imageNamed:@"订单管理_分组"] forState:UIControlStateSelected];
    _ordersBtn.selected=YES;
    _ordersBtn.tag=1;
    [_ordersBtn addTarget:self action:@selector(shaixuan:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_ordersBtn];
    
    
    UILabel *orderLab =[[UILabel alloc]initWithFrame:CGRectMake(95,0 , 60, 20)];
    orderLab.text=@"全部订单";
    orderLab.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    orderLab.font=[UIFont systemFontOfSize:13];
    [screeView addSubview:orderLab];
    
    _ordersBtn1=[[UIButton alloc]initWithFrame:CGRectMake(170, 2, 15, 15)];
    [_ordersBtn1 setImage:[UIImage imageNamed:@"注册_未选中"] forState:UIControlStateNormal];
    [_ordersBtn1 setImage:[UIImage imageNamed:@"订单管理_分组"] forState:UIControlStateSelected];
     _ordersBtn1.tag=2;
    [_ordersBtn1 addTarget:self action:@selector(shaixuan:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_ordersBtn1];
    
    
    UILabel *orderLab1 =[[UILabel alloc]initWithFrame:CGRectMake(190,0 , 50, 20)];
    orderLab1.text=@"已完成";
    orderLab1.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    orderLab1.font=[UIFont systemFontOfSize:13];
    [screeView addSubview:orderLab1];
    
    _ordersBtn2=[[UIButton alloc]initWithFrame:CGRectMake(250, 2, 15, 15)];
    [_ordersBtn2 setImage:[UIImage imageNamed:@"注册_未选中"] forState:UIControlStateNormal];
    [_ordersBtn2 setImage:[UIImage imageNamed:@"订单管理_分组"] forState:UIControlStateSelected];
     _ordersBtn2.tag=3;
    [_ordersBtn2 addTarget:self action:@selector(shaixuan:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_ordersBtn2];
    
    
    UILabel *orderLab2 =[[UILabel alloc]initWithFrame:CGRectMake(270,0 , 50, 20)];
    orderLab2.text=@"交易中";
    orderLab2.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    orderLab2.font=[UIFont systemFontOfSize:13];
    [screeView addSubview:orderLab2];
    [self.view addSubview:self.tab];
    [self PostCorpUI1:0];

}

- (void)shaixuan:(UIButton*)sender {
    if (sender.tag==1) {
        _ordersBtn.selected=YES;
        _ordersBtn1.selected=NO;
        _ordersBtn2.selected=NO;
      
    }else if (sender.tag==2) {
        _ordersBtn.selected=NO;
        _ordersBtn1.selected=YES;
        _ordersBtn2.selected=NO;
       
    }else if (sender.tag==3) {
        _ordersBtn.selected=NO;
        _ordersBtn1.selected=NO;
        _ordersBtn2.selected=YES;
    }
    [self PostCorpUI1:sender.tag-1];
}
#pragma mark - 订单列表
- (void)PostCorpUI1:(NSInteger)a {
    NSMutableDictionary* dic=[NSMutableDictionary new];
    UserInfoModel* info=[UserInfoModel loadUserInfoModel];
    NSDictionary *params = @{
                             @"tradStatus" : @(a)
                             };
    [HttpTool get:[NSString stringWithFormat:@"release/getFindAllReleaseList"] params:params success:^(id responseObj) {
        _members=[NSMutableArray new];
        //        NSDictionary* a=responseObj[@"data"];
        //        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:responseObj options:NSJSONReadingMutableLeaves error:nil];
        //        _comLab.text=responseObj[@"data"][@"companyName"];
        for (NSDictionary* prod in responseObj[@"data"]) {
            ETProductModel* m=[ETProductModel mj_objectWithKeyValues:prod];
            [_members addObject:m];
            
        }
        [_tab reloadData];
        NSLog(@"");
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

//订单删除
-(void)delOrder:(NSInteger)sender
{
//    NSDictionary *dict =[_products objectAtIndex:sender.tag];
    ETProductModel* p=[_members objectAtIndex:sender];
    long long a=[p.releaseOrderId longLongValue];
    NSDictionary *params = @{
                             @"id" : @(a)
                             };
    NSData *data =    [NSJSONSerialization dataWithJSONObject:params options:NSUTF8StringEncoding error:nil];
    
    [HttpTool put:[NSString stringWithFormat:@"release/OrderDel"] params:params success:^(NSDictionary *response) {
        //        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:nil];
        [MBProgressHUD showMBProgressHud:self.view withText:[MySingleton filterNull:response[@"msg"]] withTime:1.0];
        NSLog(@"");
        
        [MBProgressHUD showMBProgressHud:self.view withText:@"删除成功" withTime:1];
//        [self PostUI:@""];
    } failure:^(NSError *error) {
        NSLog(@"");
        
    }];
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
        [self.owner.navigationController pushViewController:payVC animated:YES];
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
@end
