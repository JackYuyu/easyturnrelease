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
#import "ETViphuiyuanModel.h"
@interface ETPaymentStagesVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tab;

@property (nonatomic) NSInteger stagesCount;
@property (nonatomic, strong) NSMutableArray *products;

@property (nonatomic,strong) UIView * maskTheView;
@property (nonatomic,strong) UIView * shareView;
@property (nonatomic,strong)UILabel *lab1;
@property (nonatomic,strong)UIButton *surebtn;

@property (nonatomic,strong) UIView * maskTheView1;
@property (nonatomic,strong) UIView * shareView1;
@property (nonatomic,strong)UILabel *lab2;
@property (nonatomic,strong)UIButton *surebtn1;
#define kOrderId @"OrderId"
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
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestPayResult) name:Request_PayResult object:nil];
    
    self.title=@"交易详情";
    self.view.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    [self.view addSubview:self.tab];
    [self PostUI];
    NSUserDefaults* user=[NSUserDefaults standardUserDefaults];
    NSString* b=[user objectForKey:@"uid"];
    if ([_product.userId isEqualToString:b]) {
    UIView* view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 44)];
    [view setBackgroundColor:kACColorWhite];
    UIButton* btn=[UIButton new];
    [btn setTitle:@"确认交易状态" forState:UIControlStateNormal];
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
    [self shareView];
    [self shareViewController];
    [self shareView1];
    [self shareViewController1];
    
    if ([_product.tradStatus isEqualToString:@"3"]) {
        if ([_product.userId isEqualToString:b]) {
            UIView* view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 44)];
            [view setBackgroundColor:kACColorWhite];
            UIButton* btn=[UIButton new];
            [btn setTitle:@"确认完成交易" forState:UIControlStateNormal];
            btn.titleLabel.font=[UIFont systemFontOfSize:14];
            btn.layer.cornerRadius = 10;
            btn.backgroundColor=[UIColor colorWithRed:20/255.0 green:138/255.0 blue:236/255.0 alpha:1.0];
            [btn addTarget:self action:@selector(alert) forControlEvents:UIControlEventTouchUpInside];
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
        [btn setTitle:@"买家确认完成" forState:UIControlStateNormal];
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
    
    if ([_product.tradStatus isEqualToString:@"4"]) {
        if ([_product.userId isEqualToString:b]) {
            UIView* view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 44)];
            [view setBackgroundColor:kACColorWhite];
            UIButton* btn=[UIButton new];
            [btn setTitle:@"等待买家发起完成" forState:UIControlStateNormal];
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
        [btn setTitle:@"买家交易完成" forState:UIControlStateNormal];
        btn.titleLabel.font=[UIFont systemFontOfSize:14];
        btn.layer.cornerRadius = 10;
        btn.backgroundColor=[UIColor colorWithRed:20/255.0 green:138/255.0 blue:236/255.0 alpha:1.0];
        [btn addTarget:self action:@selector(alert1) forControlEvents:UIControlEventTouchUpInside];
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
-(void)alert{
    [self.view addSubview:self.maskTheView];
    [self.view addSubview:self.shareView];
    _lab1.text=@"请保证相关服务质量以及相关流转资源的真实性，只做提供信息交流平台，不承担任何风险.";
}
-(void)alert1{
    [self.view addSubview:self.maskTheView1];
    [self.view addSubview:self.shareView1];
    _lab2.text=@"请保证相关服务质量以及相关流转资源的真实性，只做提供信息交流平台，不承担任何风险.";
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
            [MBProgressHUD showMBProgressHud:self.view withText:@"确认成功" withTime:2];
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
        //
        if ([_product.userId isEqualToString:b])
            cell.btnPay.hidden=YES;
        else
            cell.btnPay.hidden=NO;
        //
        if ([_product.tradStatus isEqualToString:@"1"]) {
            cell.btnPay.hidden = YES;
        }else{
            cell.btnPay.hidden = NO;
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }
}

///
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
        _shareView = [[UIView alloc]initWithFrame:CGRectMake(30, Screen_Height/2-100, Screen_Width-60,200)];
        //        _shareView.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
        _shareView.layer.cornerRadius=20;
        _shareView.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
        
    }
    return _shareView;
}
//添加提示框
- (void)shareViewController {
    UIImageView *returnImage=[[UIImageView alloc]initWithFrame:CGRectMake(20, 23, 50, 50)];
    returnImage.image=[UIImage imageNamed:@"dropdown_loading_01"];
    returnImage.userInteractionEnabled = YES;
    [_shareView addSubview:returnImage];
    
    UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(80, 25, Screen_Width, 45)];
    lab.text=@"平台温馨提示";
    lab.textColor=[UIColor blackColor];
    lab.font =[UIFont systemFontOfSize:20];
    [_shareView addSubview:lab];
    
    _lab1=[[UILabel alloc]initWithFrame:CGRectMake(20, 75, Screen_Width-90, 70)];
    
    _lab1.numberOfLines=0;
    _lab1.textColor=[UIColor blackColor];
    _lab1.font =[UIFont systemFontOfSize:14];
    [_shareView addSubview:_lab1];
    
    UIButton *returnbtn =[[UIButton alloc]initWithFrame:CGRectMake(_shareView.size.width-150, 155, 50, 21)];
    [returnbtn setTitle:@"关闭" forState:UIControlStateNormal];
    returnbtn.titleLabel.font=[UIFont systemFontOfSize:15];
    [returnbtn addTarget:self action:@selector(clickImage) forControlEvents:UIControlEventTouchUpInside];
    [returnbtn setTitleColor:[UIColor colorWithRed:243/255.0 green:22/255.0 blue:22/255.0 alpha:1.0] forState:UIControlStateNormal];
    [_shareView addSubview:returnbtn];
    
    UIButton *surebtn =[[UIButton alloc]initWithFrame:CGRectMake(_shareView.size.width-100, 155, 50, 21)];
    [surebtn setTitle:@"确定" forState:UIControlStateNormal];
    surebtn.titleLabel.font=[UIFont systemFontOfSize:15];
    [surebtn setTitleColor:[UIColor colorWithRed:243/255.0 green:22/255.0 blue:22/255.0 alpha:1.0] forState:UIControlStateNormal];
    [surebtn addTarget:self action:@selector(PostSellerFinishUI) forControlEvents:UIControlEventTouchUpInside];
    _surebtn=surebtn;
    [_shareView addSubview:surebtn];
    
}

- (void)clickImage {
    [self.maskTheView removeFromSuperview];
    [self.shareView removeFromSuperview];
}


///
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
    lab.text=@"平台温馨提示";
    lab.textColor=[UIColor blackColor];
    lab.font =[UIFont systemFontOfSize:20];
    [_shareView1 addSubview:lab];
    
    _lab2=[[UILabel alloc]initWithFrame:CGRectMake(20, 75, Screen_Width-90, 70)];
    
    _lab2.numberOfLines=0;
    _lab2.textColor=[UIColor blackColor];
    _lab2.font =[UIFont systemFontOfSize:14];
    [_shareView1 addSubview:_lab2];
    
    UIButton *returnbtn =[[UIButton alloc]initWithFrame:CGRectMake(_shareView1.size.width-150, 155, 50, 21)];
    [returnbtn setTitle:@"关闭" forState:UIControlStateNormal];
    returnbtn.titleLabel.font=[UIFont systemFontOfSize:15];
    [returnbtn addTarget:self action:@selector(clickImage1) forControlEvents:UIControlEventTouchUpInside];
    [returnbtn setTitleColor:[UIColor colorWithRed:243/255.0 green:22/255.0 blue:22/255.0 alpha:1.0] forState:UIControlStateNormal];
    [_shareView1 addSubview:returnbtn];
    
    UIButton *surebtn =[[UIButton alloc]initWithFrame:CGRectMake(_shareView1.size.width-100, 155, 50, 21)];
    [surebtn setTitle:@"确定" forState:UIControlStateNormal];
    surebtn.titleLabel.font=[UIFont systemFontOfSize:15];
    [surebtn setTitleColor:[UIColor colorWithRed:243/255.0 green:22/255.0 blue:22/255.0 alpha:1.0] forState:UIControlStateNormal];
    [surebtn addTarget:self action:@selector(PostFinishUI) forControlEvents:UIControlEventTouchUpInside];
    _surebtn1=surebtn;
    [_shareView1 addSubview:surebtn];
    
}

- (void)clickImage1 {
    [self.maskTheView1 removeFromSuperview];
    [self.shareView1 removeFromSuperview];
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
                    [[NSNotificationCenter defaultCenter]postNotificationName:Refresh_MineOrder object:nil];
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
