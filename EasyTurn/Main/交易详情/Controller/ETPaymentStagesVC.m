//
//  ETPaymentStagesVC.m
//  EasyTurn
//
//  Created by 刘盖 on 2019/8/5.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import "ETPaymentStagesVC.h"
#import "ETPaymentStatesCell.h"
#import "ETProductModel.h"
@interface ETPaymentStagesVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tab;

@property (nonatomic) NSInteger stagesCount;
@property (nonatomic, strong) NSMutableArray *products;

@end

@implementation ETPaymentStagesVC

+ (instancetype)paymentStagesVC:(NSInteger)stagesCount{
    ETPaymentStagesVC *vc = [[self alloc] init];
    vc.stagesCount = stagesCount;
    return vc;
}
- (void)viewWillAppear:(BOOL)animated {
    [super.navigationController setNavigationBarHidden:NO animated:TRUE];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super.navigationController setNavigationBarHidden:NO animated:TRUE];
    
}

- (UITableView *) tab {
    if (!_tab) {
        _tab=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height) style:UITableViewStylePlain];
        _tab.delegate=self;
        _tab.dataSource=self;
        _tab.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tab.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
        _tab.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0,0,0,0.01)];
        _tab.sectionFooterHeight = 0;
        _tab.sectionHeaderHeight = 10;
        _tab.rowHeight=100;
        
    }
    return _tab;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"交易详情";
    self.view.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    [self.view addSubview:self.tab];
    [self PostUI];
    NSUserDefaults* user=[NSUserDefaults standardUserDefaults];
    NSString* b=[user objectForKey:@"uid"];
    if ([_product.userId isEqualToString:b]||[_product.releaseTypeId isEqualToString:@"2"]) {
    UIView* view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 44)];
    [view setBackgroundColor:kACColorWhite];
    UIButton* btn=[UIButton new];
    [btn setTitle:@"确认订单" forState:UIControlStateNormal];
        btn.titleLabel.font=[UIFont systemFontOfSize:14];
    btn.layer.cornerRadius = 10;
    btn.backgroundColor=[UIColor colorWithRed:20/255.0 green:138/255.0 blue:236/255.0 alpha:1.0];
    [btn addTarget:self action:@selector(PostSureUI) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(120);
        make.center.mas_equalTo(view);
    }];
    _tab.tableFooterView=view;
    }
    
    if ([_product.tradStatus isEqualToString:@"3"]) {
        if ([_product.userId isEqualToString:b]||[_product.releaseTypeId isEqualToString:@"2"]) {
            UIView* view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 44)];
            [view setBackgroundColor:kACColorWhite];
            UIButton* btn=[UIButton new];
            [btn setTitle:@"卖家交易完成" forState:UIControlStateNormal];
            btn.titleLabel.font=[UIFont systemFontOfSize:14];
            btn.layer.cornerRadius = 10;
            btn.backgroundColor=[UIColor colorWithRed:20/255.0 green:138/255.0 blue:236/255.0 alpha:1.0];
            [btn addTarget:self action:@selector(PostSellerFinishUI) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(120);
                make.center.mas_equalTo(view);
            }];
            _tab.tableFooterView=view;
        }
        else
        {
        UIView* view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 44)];
        [view setBackgroundColor:kACColorWhite];
        UIButton* btn=[UIButton new];
        [btn setTitle:@"等待卖家发起完成" forState:UIControlStateNormal];
        btn.titleLabel.font=[UIFont systemFontOfSize:14];
        btn.layer.cornerRadius = 10;
        btn.backgroundColor=[UIColor colorWithRed:20/255.0 green:138/255.0 blue:236/255.0 alpha:1.0];
//        [btn addTarget:self action:@selector(PostSellerFinishUI) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(120);
            make.center.mas_equalTo(view);
        }];
        _tab.tableFooterView=view;
        }
    }
    
    if ([_product.tradStatus isEqualToString:@"4"]) {
        if ([_product.userId isEqualToString:b]||[_product.releaseTypeId isEqualToString:@"2"]) {
            UIView* view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 44)];
            [view setBackgroundColor:kACColorWhite];
            UIButton* btn=[UIButton new];
            [btn setTitle:@"等待买家发起完成" forState:UIControlStateNormal];
            btn.titleLabel.font=[UIFont systemFontOfSize:14];
            btn.layer.cornerRadius = 10;
            btn.backgroundColor=[UIColor colorWithRed:20/255.0 green:138/255.0 blue:236/255.0 alpha:1.0];
//            [btn addTarget:self action:@selector(PostFinishUI) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(120);
                make.center.mas_equalTo(view);
            }];
            _tab.tableFooterView=view;
        }
        else
        {
        UIView* view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 44)];
        [view setBackgroundColor:kACColorWhite];
        UIButton* btn=[UIButton new];
        [btn setTitle:@"买家交易完成" forState:UIControlStateNormal];
        btn.titleLabel.font=[UIFont systemFontOfSize:14];
        btn.layer.cornerRadius = 10;
        btn.backgroundColor=[UIColor colorWithRed:20/255.0 green:138/255.0 blue:236/255.0 alpha:1.0];
        [btn addTarget:self action:@selector(PostFinishUI) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(120);
            make.center.mas_equalTo(view);
        }];
        _tab.tableFooterView=view;
        }
    }
    if ([_product.tradStatus isEqualToString:@"5"]) {
        UIView* view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 44)];
        [view setBackgroundColor:kACColorWhite];
        UIButton* btn=[UIButton new];
        [btn setTitle:@"交易完成" forState:UIControlStateNormal];
        btn.titleLabel.font=[UIFont systemFontOfSize:14];
        btn.layer.cornerRadius = 10;
        btn.backgroundColor=[UIColor colorWithRed:20/255.0 green:138/255.0 blue:236/255.0 alpha:1.0];
        [btn addTarget:self action:@selector(PostFinish) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(120);
            make.center.mas_equalTo(view);
        }];
        _tab.tableFooterView=view;
    }
}
#pragma mark - 买家交易完成
- (void)PostFinishUI {
    NSDictionary *params = @{
                             @"releasesId": _releaseOrderId
                             };
    
    [HttpTool put:[NSString stringWithFormat:@"release/buyerInitiatesTransactionToComplete"] params:params success:^(NSDictionary *response) {
        //        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:nil];
        [MBProgressHUD showMBProgressHud:self.view withText:@"提交成功" withTime:1];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
        NSLog(@"");
    } failure:^(NSError *error) {
        NSLog(@"");
    }];
}
#pragma mark - 卖家交易完成
- (void)PostSellerFinishUI {
    NSDictionary *params = @{
                             @"releasesId": _releaseOrderId
                             };
    
    [HttpTool put:[NSString stringWithFormat:@"release/sellerInitiatesTransactionToComplete"] params:params success:^(NSDictionary *response) {
        //        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:nil];
        [MBProgressHUD showMBProgressHud:self.view withText:@"提交成功" withTime:1];
        NSLog(@"");
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
    } failure:^(NSError *error) {
        NSLog(@"");
    }];
}
#pragma mark - 交易完成
- (void)PostFinish {
//    NSDictionary *params = @{
//                             @"releasesId": _releaseOrderId
//                             };
//
//    [HttpTool put:[NSString stringWithFormat:@"release/sellerInitiatesTransactionToComplete"] params:params success:^(NSDictionary *response) {
//        //        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:nil];
//        NSLog(@"");
//    } failure:^(NSError *error) {
//        NSLog(@"");
//    }];
}
#pragma mark - 卖家确认订单
- (void)PostSureUI {
    NSDictionary *params = @{
                             @"releasesId": _releaseOrderId
                             };
    
    [HttpTool put:[NSString stringWithFormat:@"release/sellerInitiateATransaction"] params:params success:^(NSDictionary *response) {
        //        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:nil];
        [MBProgressHUD showMBProgressHud:self.view withText:@"提交成功" withTime:1];
        NSLog(@"");
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
    } failure:^(NSError *error) {
        NSLog(@"");
    }];
}
#pragma mark - 出售全部订单
- (void)PostUI {
    NSMutableDictionary* dic=[NSMutableDictionary new];
    NSDictionary *params = @{
                             @"releaseId": _releaseOrderId
                             };
    
    [HttpTool get:[NSString stringWithFormat:@"pay/findOrderByReleaseId"] params:params success:^(id responseObj) {
        _products=[NSMutableArray new];
        NSDictionary* a=responseObj[@"data"];
        for (NSDictionary* prod in responseObj[@"data"]) {
            ETProductModel* p=[ETProductModel mj_objectWithKeyValues:prod];
            [_products addObject:p];
        }
                NSLog(@"");
        [_tab reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==1) {
        return self.stagesCount+1;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==1) {
        if (indexPath.row > 0) {
            return [ETPaymentStatesPriceCell cellHeight];
        }
    }
    return [ETPaymentStatesCell cellHeight];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 2) {
        return 10;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 2) {
        return 1;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        NSString *title = @"";
        NSString *subTitle = @"";
        switch (indexPath.section) {
            case 0:
            {
                title = @"最终价格";
                subTitle = self.finalPrice;
            }
                break;
            case 1:
            {
                title = @"支付方式";
                subTitle = @"微信账户";
            }
                break;
            default:
            {
                NSString* temp = _product.tradStatus;
                
                UserInfoModel* user= [UserInfoModel loadUserInfoModel];
                if ([user.uid isEqualToString:_product.userId])
                {
                    title = @"确认状态";
                    subTitle = @"去确认";
                    if ([temp isEqualToString:@"1"]) {
                        subTitle=@"买家已确认";
                    }else if ([temp isEqualToString:@"2"]){
                        subTitle=@"等待买方支付";
                    }
                    else if ([temp isEqualToString:@"3"]){
                        subTitle=@"支付已完成";
                    }
                    else if ([temp isEqualToString:@"4"]){
                        subTitle=@"等待买家确认";
                    }
                    else if ([temp isEqualToString:@"5"]){
                        subTitle=@"交易完成";
                    }
                }
                else
                {
                title = @"确认状态";
                subTitle = @"卖家未确认";
                    if ([temp isEqualToString:@"1"]) {
                        subTitle=@"等待卖家确认";
                    }else if ([temp isEqualToString:@"2"]){
                        subTitle=@"卖家已确认";
                    }
                    else if ([temp isEqualToString:@"3"]){
                        subTitle=@"支付已完成";
                    }
                    else if ([temp isEqualToString:@"4"]){
                        subTitle=@"卖家已发起完成";
                    }
                    else if ([temp isEqualToString:@"5"]){
                        subTitle=@"交易完成";
                    }
                }
                //
                
            }
                break;
        }
        return [ETPaymentStatesCell paymentStatesCell:tableView title:title sub:subTitle indexPath:indexPath];
    }
    else{
        ETProductModel* p=[_products objectAtIndex:indexPath.row-1];
        ETPaymentStatesPriceCell* cell=[ETPaymentStatesPriceCell paymentStatesPriceCell:tableView price:[NSString stringWithFormat:@"%ld",[self.finalPrice integerValue]/3] indexPath:indexPath total:self.stagesCount order:p];
        NSUserDefaults* user=[NSUserDefaults standardUserDefaults];
        NSString* b=[user objectForKey:@"uid"];
        if ([_product.userId isEqualToString:b])
            cell.btnPay.hidden=YES;
        else
            cell.btnPay.hidden=NO;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }
}
@end
