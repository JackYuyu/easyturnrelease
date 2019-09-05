//
//  ETBuyPushViewController.m
//  EasyTurn
//
//  Created by 王翔 on 2019/7/31.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import "ETBuyPushViewController.h"
#import "ETPayaymentViewController.h"
@interface ETBuyPushViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (nonatomic,strong)UITableView *tab;
@property (nonatomic, copy) NSString *finalPrice;
@property (nonatomic,strong) UITextField *label1;

@end

@implementation ETBuyPushViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
- (UITableView *) tab {
    if (!_tab) {
        _tab=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height) style:UITableViewStyleGrouped];
        _tab.delegate=self;
        _tab.dataSource=self;
        _tab.bounces=NO;
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
    [self.view addSubview:self.tab];
////        [MBProgressHUD showMBProgressHud:self.view withText:@"易转只作为商品信息发布平台,建议交易双方私下签订转让协议或服务协议,易转不承担任何交易风险." withTime:2];
//    
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
//    
//    hud.userInteractionEnabled = YES;
//    
////    hud.backgroundColor = [UIColor clearColor];
//    
//    hud.animationType = MBProgressHUDAnimationZoomOut;
//    
//    hud.detailsLabelText = @"易转只作为商品信息发布平台,建议交易双方私下签订转让协议或服务协议,易转不承担任何交易风险.";
//    
//    hud.square = NO;
//    
//    hud.mode = MBProgressHUDModeCustomView;
//    int timeInt=3;
//    [hud hide:YES afterDelay:timeInt];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0) {
        return 6;
    }else if (section==1) {
        return 2;
    }
    return YES;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            UILabel *label = [[UILabel alloc] init];
            label.numberOfLines = 0;
            NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",self.product.title]attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 13],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
                                                 
                label.attributedText = string;
                label.textAlignment = NSTextAlignmentLeft;
                label.alpha = 1.0;
            [cell addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(15);
                make.left.mas_equalTo(15);
                make.right.mas_equalTo(-15);
                make.height.mas_equalTo(41);
            }];
        }else if (indexPath.row==1) {
            UILabel *label = [[UILabel alloc] init];
            label.numberOfLines = 0;
            label.text=[NSString stringWithFormat:@"注册时间：%@",self.product.releaseTime];
            label.font=[UIFont systemFontOfSize:13];
            label.textAlignment = NSTextAlignmentLeft;
            label.alpha = 1.0;
            [cell addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(15);
                make.left.mas_equalTo(15);
                make.size.mas_equalTo(CGSizeMake(200, 21));
            }];
        }else if (indexPath.row==2) {
            UILabel *label = [[UILabel alloc] init];
            label.numberOfLines = 0;
            label.text=[NSString stringWithFormat:@"注册地址：%@",self.product.cityName];
            label.font=[UIFont systemFontOfSize:13];
            label.textAlignment = NSTextAlignmentLeft;
            label.alpha = 1.0;
            [cell addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(15);
                make.left.mas_equalTo(15);
                make.size.mas_equalTo(CGSizeMake(165, 21));
            }];
        }else if (indexPath.row==3) {
            UILabel *label = [[UILabel alloc] init];
            label.numberOfLines = 0;
            NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"卖家电话：%@",self.product.linkmanMobil] attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 13],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
            
            label.attributedText = string;
            label.textAlignment = NSTextAlignmentLeft;
            label.alpha = 1.0;
            [cell addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(15);
                make.left.mas_equalTo(15);
                make.size.mas_equalTo(CGSizeMake(170, 21));
            }];
        }else if (indexPath.row==4) {
            UILabel *label = [[UILabel alloc] init];
            label.numberOfLines = 0;
            NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"最终定价："attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 13],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
            
            label.attributedText = string;
            label.textAlignment = NSTextAlignmentLeft;
            label.alpha = 1.0;
            [cell addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(21);
                make.left.mas_equalTo(14);
                make.size.mas_equalTo(CGSizeMake(74, 21));
            }];
            
            UIView *view = [[UIView alloc] init];
            view.layer.backgroundColor = [UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1.0].CGColor;
            view.layer.cornerRadius = 5;
            [cell addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(15);
                make.left.mas_equalTo(89);
                make.size.mas_equalTo(CGSizeMake(91, 34));
            }];
            
            _label1 = [[UITextField alloc] init];
            _label1.textAlignment = NSTextAlignmentLeft;
            _label1.alpha = 1.0;
            _label1.delegate=self;
            [view addSubview:_label1];
            [_label1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(6);
                make.left.mas_equalTo(9);
                make.right.mas_equalTo(-9);
                make.height.mas_equalTo(21);
            }];
        }else if (indexPath.row==5) {
            UILabel *label = [[UILabel alloc] init];
            label.numberOfLines = 0;
            
            NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"订单编号："attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 13],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
            
            NSString* orderid;
            if (_product.releaseOrderId) {
                orderid=[NSString stringWithFormat:@"订单编号：%@",_product.releaseOrderId];
                string = [[NSMutableAttributedString alloc] initWithString:orderid attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 13],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
            }
            
            label.attributedText = string;
            label.textAlignment = NSTextAlignmentLeft;
            label.alpha = 1.0;
            [cell addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(15);
                make.left.mas_equalTo(15);
                make.size.mas_equalTo(CGSizeMake(215, 21));
            }];
        }
    }else if (indexPath.section==1) {
        if (indexPath.row==0) {
            UILabel *label = [[UILabel alloc] init];
            label.numberOfLines = 0;
            NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"支付方式"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 13],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
            label.attributedText = string;
            label.textAlignment = NSTextAlignmentLeft;
            label.alpha = 1.0;
            [cell addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(16);
                make.left.mas_equalTo(15);
                make.size.mas_equalTo(CGSizeMake(60, 21));
            }];
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }else if (indexPath.row==1) {
            UILabel *label = [[UILabel alloc] init];
            label.numberOfLines = 0;
            NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"支付状态"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 13],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
            label.attributedText = string;
            label.textAlignment = NSTextAlignmentLeft;
            label.alpha = 1.0;
            [cell addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(16);
                make.left.mas_equalTo(15);
                make.size.mas_equalTo(CGSizeMake(60, 21));
            }];
            
            //
            NSString* temp = _product.tradStatus;
            NSString* sta;
            NSUserDefaults* user=[NSUserDefaults standardUserDefaults];
            NSString* b=[user objectForKey:@"uid"];
            if ([_product.userId isEqualToString:b]) {//卖家
                if ([temp isEqualToString:@"1"]) {
                    sta=@"买家已确认";
                }else if ([temp isEqualToString:@"2"]){
                    sta=@"等待买方支付";
                }
                else if ([temp isEqualToString:@"3"]){
                    sta=@"支付已完成";
                }
                else if ([temp isEqualToString:@"4"]){
                    sta=@"等待买家确认";
                }
                else if ([temp isEqualToString:@"5"]){
                    sta=@"交易完成";
                }
                else {
                    sta=@"无状态";
                }
            }
            else {
                if ([temp isEqualToString:@"1"]) {
                    sta=@"等待卖家确认";
                }else if ([temp isEqualToString:@"2"]){
                    sta=@"卖家已确认";
                }
                else if ([temp isEqualToString:@"3"]){
                    sta=@"支付已完成";
                }
                else if ([temp isEqualToString:@"4"]){
                    sta=@"卖家已发起完成";
                }
                else if ([temp isEqualToString:@"5"]){
                    sta=@"交易完成";
                }
                else {
                    sta=@"无状态";
                }
            }
            UILabel *label1 = [[UILabel alloc] init];
            label1.frame = CGRectMake(590,990,130,37);
            label1.numberOfLines = 0;
            NSMutableAttributedString *string1 = [[NSMutableAttributedString alloc] initWithString:sta attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 13],NSForegroundColorAttributeName: [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0]}];
            label1.attributedText = string1;
            label1.textAlignment = NSTextAlignmentLeft;
            label1.alpha = 1.0;
            [cell addSubview:label1];
            [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(24);
                make.right.mas_equalTo(-15);
                make.size.mas_equalTo(CGSizeMake(65, 18));
            }];
        }
    }
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
        return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [_tab deselectRowAtIndexPath:indexPath animated:YES];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    // 2
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    // 3点击没有颜色改变
    cell.selected = NO;
    if (indexPath.section==1) {
        if (indexPath.row==0) {
            if ([_label1.text isEqualToString:@""] ) {
               [MBProgressHUD showMBProgressHud:self.view withText:@"请确认最终定价" withTime:1];
            }else {
            ETPayaymentViewController *payVC=[[ETPayaymentViewController alloc]init];
            payVC.product=_product;
            payVC.finalPrice=_finalPrice?_finalPrice:@"";
            payVC.releaseId=_releaseId;
            [self.navigationController pushViewController:payVC animated:YES];
            }
        }
    }
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString* price=[textField.text stringByAppendingString:string];
    _finalPrice=price;
    NSLog(@"结束编辑");
    return YES;
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
