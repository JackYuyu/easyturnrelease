//
//  ETMyOrderVC.m
//  EasyTurn
//
//  Created by 程立 on 2019/9/6.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import "ETMyOrderVC.h"
#import "CFSegmentedControl.h"
#import "MyOrderCell.h"
#import "ETProductModel.h"
#import "ETPaymentStagesVC.h"
#import "ETBuyFinishViewController.h"
@interface ETMyOrderVC ()<UITableViewDataSource,UITableViewDelegate,CFSegmentedControlDataSource,CFSegmentedControlDelegate>
@property (nonatomic, strong) NSArray *segmentTitles;
@property (nonatomic, strong) CFSegmentedControl *segmentedControl;
@property (nonatomic,strong) NSMutableArray* productList;

@property (nonatomic,strong) NSMutableArray* checkList;
@property (nonatomic,strong) UITableView* tableView;
@property (nonatomic,assign) NSInteger selectIndex;
@property (nonatomic, strong) NSMutableArray *products;
//
@property(nonatomic, assign)NSInteger pageSize;
@property(nonatomic, assign)NSInteger pageIndex;
@property (nonatomic, strong) NSMutableArray *counts;


@end

@implementation ETMyOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestRefreshMineOrder) name:Refresh_MineOrder object:nil];
    
    self.navigationItem.title = @"我的订单";
    [self enableLeftBackWhiteButton];
    self.view.backgroundColor=[UIColor whiteColor];
    UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 40, self.view.bounds.size.width, self.view.bounds.size.height-TopHeight-40) style:UITableViewStyleGrouped];
    
    tableView.delegate=self;
    tableView.dataSource=self;
    //    tableView.editing=YES;
    _tableView=tableView;
    [self.view addSubview:tableView];
    
    [_tableView registerNib:[UINib nibWithNibName:@"MyOrderCell" bundle:nil] forCellReuseIdentifier:@"MyOrderCell"];

    _segmentTitles = @[@"全 部",@"进行中",@"已完成"];
    
    _segmentedControl = [[CFSegmentedControl alloc] initWithFrame:CGRectMake(Screen_Width/2 - (110 * [_segmentTitles count])/2, 0, 110 * [_segmentTitles count], 40)];
    _segmentedControl.delegate = self;
    _segmentedControl.dataSource = self;
    _segmentedControl.alpha = 1;
    [self.view addSubview:_segmentedControl];
    [self PostUI:@"0"];
}
#pragma mark -- SegmentedControlDelegate & datasource

- (NSArray *)getSegmentedControlTitles
{
    return _segmentTitles;
}

- (void)control:(CFSegmentedControl *)control didSelectAtIndex:(NSInteger)index
{
    if (index==0) {
        [self PostUI:@"0"];
    }
    if (index==1) {
        [self PostUI:@"2"];

    }
    else if (index==2) {
        [self PostUI:@"1"];

    }
    else if (index==3) {
    }
    else if (index==4) {
    }
    _selectIndex=index;
    NSLog(@"");
    //    [_bgScrollView setContentOffset:CGPointMake(Main_Screen_Width * index, 0) animated:YES];
}

//设置表格视图有多少行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _products.count;
}
//设置每行的UITableViewCell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyOrderCell * cell = [[NSBundle mainBundle]loadNibNamed:@"MyOrderCell" owner:self options:nil].firstObject;;
    
//    MyOrderCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MyOrderCell"];
//    if (!cell) {
//        cell =  [[NSBundle mainBundle]loadNibNamed:@"MyOrderCell" owner:self options:nil].firstObject;
//    }
    


    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    ETProductModel* p=[_products objectAtIndex:indexPath.section];
//    NSInteger aa=indexPath.row;
    cell.title.text=p.title;
    cell.orderno.text=[NSString stringWithFormat:@"订单编号: %@",p.releaseOrderId];
    cell.date.text=[NSString stringWithFormat:@"购买时间: %@",p.releaseTime];
    cell.status.text=p.tradStatus;
    cell.paybtn.layer.borderWidth=0.5;
    cell.paybtn.layer.borderColor=[UIColor lightGrayColor].CGColor;
    cell.delbtn.layer.borderWidth=0.5;
    cell.delbtn.layer.borderColor=[UIColor lightGrayColor].CGColor;
    [cell.delbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

    NSUserDefaults* user=[NSUserDefaults standardUserDefaults];
    NSString* b=[user objectForKey:@"uid"];
    NSString* temp=p.tradStatus;
    if ([p.userId isEqualToString:b]) {//卖家
        if ([temp isEqualToString:@"1"]) {
            cell.status.text=@"已发起,等待卖家确认";
        }else if ([temp isEqualToString:@"2"]){
            cell.status.text=@"卖家已确认交易详情";
        }
        else if ([temp isEqualToString:@"3"]){
            cell.status.text=@"支付完成,等待卖家确认";
            cell.status.textColor=[UIColor greenColor];
        }
        else if ([temp isEqualToString:@"4"]){
            cell.status.text=@"卖家发起交易完成,等待买家确认";
        }
        else if ([temp isEqualToString:@"5"]){
            cell.status.text=@"交易完成";
            [cell.paybtn setTitle:@"已完成" forState:UIControlStateNormal];
            [cell.paybtn setBackgroundColor:[UIColor lightGrayColor]];
//            [cell.paybtn setTitle:[UIColor lightGrayColor] forState:UIControlStateNormal];
        }
    }
    else {
        if ([temp isEqualToString:@"1"]) {
            cell.status.text=@"已发起,等待卖家确认";
        }else if ([temp isEqualToString:@"2"]){
            cell.status.text=@"卖家已确认交易详情";
        }
        else if ([temp isEqualToString:@"3"]){
            cell.status.text=@"支付完成,等待卖家确认";
            cell.status.textColor=[UIColor greenColor];
        }
        else if ([temp isEqualToString:@"4"]){
            cell.status.text=@"卖家已发起完成";
        }
        else if ([temp isEqualToString:@"5"]){
            cell.status.text=@"交易完成";
            [cell.paybtn setTitle:@"已完成" forState:UIControlStateNormal];
            [cell.paybtn setBackgroundColor:[UIColor lightGrayColor]];
//            [cell.paybtn setTitle:[UIColor lightGrayColor] forState:UIControlStateNormal];
        }
    }
    
    
    
    cell.payprice.text=[NSString stringWithFormat:@"共支付: %@",p.price];
    NSMutableAttributedString *textColor = [[NSMutableAttributedString alloc]initWithString:cell.payprice.text];
    
    NSRange rangel = [[textColor string] rangeOfString:[cell.payprice.text substringWithRange:NSMakeRange(3, cell.payprice.text.length-3)]];
    
    [textColor addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:rangel];
    [cell.payprice setAttributedText:textColor];
    cell.paybtn.tag=indexPath.row;
    cell.delbtn.tag=indexPath.row;
    [cell.paybtn addTarget:self action:@selector(orderDetail:) forControlEvents:UIControlEventTouchUpInside];
    [cell.delbtn addTarget:self action:@selector(orderDel:) forControlEvents:UIControlEventTouchUpInside];

    return cell;
}
//设置行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 140;
}
//设置分区尾视图高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5.01;
}
//设置分区头视图高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
//设置分区的尾视图
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 5)];
    view.backgroundColor = kACColorBackgroundGray;
    return view;
}
//设置分区的头视图
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    
    return view;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ETProductModel* p=[_products objectAtIndex:indexPath.section];
    if ([p.tradStatus isEqualToString:@"5"]) {
        ETBuyFinishViewController* f=[ETBuyFinishViewController new];
        f.product=p;
        [self.navigationController pushViewController:f animated:YES];
    }
    else{
    [self PostCountUI:p];
    }
    
}
#pragma mark - 出售全部订单
- (void)PostUI:(NSString*)a {
    NSMutableDictionary* dic=[NSMutableDictionary new];
    NSDictionary *params = @{
                             @"status" : a
                             };
    
    [HttpTool get:[NSString stringWithFormat:@"releaseOrder/orders"] params:params success:^(id responseObj) {
        _products=[NSMutableArray new];
        NSDictionary* a=responseObj[@"data"];
        for (NSDictionary* prod in responseObj[@"data"]) {
            ETProductModel* p=[ETProductModel mj_objectWithKeyValues:prod];
            [_products addObject:p];
        }
        [_tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
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
        [self.navigationController pushViewController:payVC animated:YES];
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
-(void)orderDetail:(UIButton*)sender
{
    ETProductModel* p=[_products objectAtIndex:sender.tag];
    if ([p.tradStatus isEqualToString:@"5"]) {
        ETBuyFinishViewController* f=[ETBuyFinishViewController new];
        f.product=p;
        [self.navigationController pushViewController:f animated:YES];
    }
    else{
//    ETProductModel* p=[_products objectAtIndex:sender.tag];
    [self PostCountUI:p];
    }
}

//订单删除
-(void)orderDel:(UIButton*)sender
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

#pragma mark - 通知刷新页面
- (void)requestRefreshMineOrder {
    [self PostUI:@"0"];
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
