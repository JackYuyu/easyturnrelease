//
//  ETPayaymentViewController.m
//  EasyTurn
//
//  Created by 王翔 on 2019/7/31.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import "ETPayaymentViewController.h"
#import "WXApiRequestHandler.h"
#import "WXApiManager.h"
#import "WechatAuthSDK.h"
#import "WXApiObject.h"
#import <AlipaySDK/AlipaySDK.h>
#import "APOrderInfo.h"
#import "APAuthInfo.h"
#import "APRSASigner.h"
#import "ETPaymentStagesVC.h"
@interface ETPayaymentViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (nonatomic,strong) UITableView*tab;
@property (nonatomic,strong) UIButton *btn;
@property (nonatomic,strong) UIButton *payBtn;
@property (nonatomic,strong) UIButton *stagingBtn;
@property (nonatomic,strong) UIButton *phasesBtn;
@property (nonatomic,strong) UIButton *stagestagingBtn;
@property (nonatomic,strong) UIButton *payoffBtn;
@property (nonatomic,assign) int btnTag;
@property (nonatomic,strong) NSString* stagePrice;//分期价格
@property (nonatomic,strong) NSString* stagePrice1;
@property (nonatomic,strong) NSString* stagePrice2;

@end

@implementation ETPayaymentViewController

- (UITableView *)tab {
    if (!_tab) {
        _tab=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height) style:UITableViewStyleGrouped];
        _tab.delegate=self;
        _tab.dataSource=self;
        _tab.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0,0,0,0.01)];
        _tab.sectionFooterHeight = 0;
        _tab.sectionHeaderHeight = 10;
    }
    return _tab;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"支付方式";
    _btnTag=1;
    [self.view addSubview:self.tab];
    [self payBtn];
    _payoffBtn=[[UIButton alloc]init];
    _payoffBtn.layer.cornerRadius = 10;
    _payoffBtn.backgroundColor=[UIColor colorWithRed:20/255.0 green:138/255.0 blue:236/255.0 alpha:1.0];
    [_payoffBtn addTarget:self action:@selector(payOffAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_payoffBtn];
//    dispatch_async(dispatch_get_main_queue(), ^{
//
//    });
//

    
}
#pragma mark - 预支付微信
- (void)PostUI {
    NSMutableDictionary* dic=[NSMutableDictionary new];
    NSDictionary *params = @{
                             @"id" : @(6),
                             @"price" : _finalPrice,
                             @"productId" : _releaseId,
                             @"type" : @(2)
                             
                             };
    [HttpTool get:[NSString stringWithFormat:@"pay/prePay"] params:params success:^(id responseObj) {
        
        NSString* a=responseObj[@"data"][@"result"];
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:[a dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
        //
        NSDictionary* d=[jsonDict copy];
        [self wechatPay:d];
        NSLog(@"");
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
#pragma mark - 预支付支付宝
- (void)payOrder:(NSString *)orderStr fromScheme:(NSString *)schemeStr callback:(CompletionBlock)completionBlock {
    NSMutableDictionary* dic=[NSMutableDictionary new];
    NSDictionary *params = @{
                             @"id" : @(6),
                             @"price" : _finalPrice,
                             @"productId" : _releaseId,
                             @"type" : @(1)
                             
                             };
    [HttpTool get:[NSString stringWithFormat:@"pay/prePay"] params:params success:^(id responseObj) {
        
        NSString* a=responseObj[@"data"][@"result"];
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:[a dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
        //
        NSDictionary* d=[jsonDict copy];
        [self wechatPay:d];
        NSLog(@"");
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
-(void)wechatPay:(NSDictionary*)d
{
    [self.navigationController popViewControllerAnimated:NO];
    //    NSDictionary* d=[NSDictionary new];
    //    [[WXApiObject shareInstance]WXApiPayWithParam:d];
    NSString *res = [WXApiRequestHandler jumpToBizPay:d];
    if( ![@"" isEqual:res] ){
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"支付失败" message:res delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alter show];
    }
}
- (void)payBtnController {
    _payBtn =[[UIButton alloc]init];
    [_payBtn setTitle:@"去支付" forState:UIControlStateNormal];
    _payBtn.layer.cornerRadius = 6;
    _payBtn.backgroundColor=[UIColor colorWithRed:20/255.0 green:138/255.0 blue:236/255.0 alpha:1.0];
    [self.view addSubview:_payBtn];
    [_payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (514);
        make.left.mas_equalTo (51);
        make.right.mas_equalTo (-51);
        make.size.mas_equalTo (CGSizeMake(268,39));
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0) {
        return 2;
    }else if (section==1) {
        if (_btnTag==1) {
            return 1;
        }else if (_btnTag==2) {
            return 3;
        }else if (_btnTag==3) {
            return 4;
        }
    }
    return YES;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            UILabel *label = [[UILabel alloc] init];
            label.numberOfLines = 0;
            NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"最终价格："attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 13],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
            
            label.attributedText = string;
            label.textAlignment = NSTextAlignmentLeft;
            label.alpha = 1.0;
            [cell addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(21);
                make.left.mas_equalTo(14);
                make.size.mas_equalTo(CGSizeMake(74, 21));
            }];
            
            UILabel *label1 = [[UILabel alloc] init];
            label1.numberOfLines = 0;
            NSMutableAttributedString *string1 = [[NSMutableAttributedString alloc] initWithString:_finalPrice attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Medium" size: 13],NSForegroundColorAttributeName: [UIColor colorWithRed:248/255.0 green:124/255.0 blue:43/255.0 alpha:1.0]}];
            label1.attributedText = string1;
            label1.textAlignment = NSTextAlignmentLeft;
            label1.alpha = 1.0;
            [cell addSubview:label1];
            [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(16);
                make.right.mas_equalTo(-15);
                make.size.mas_equalTo(CGSizeMake(73, 21));
            }];
        }else if (indexPath.row==1) {
            UILabel *label = [[UILabel alloc] init];
            label.numberOfLines = 0;
            NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"分期方式"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 13],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
            
            label.attributedText = string;
            label.textAlignment = NSTextAlignmentLeft;
            label.alpha = 1.0;
            [cell addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(11);
                make.left.mas_equalTo(15);
                make.size.mas_equalTo(CGSizeMake(74, 21));
            }];
            
            _stagingBtn=[[UIButton alloc]init];
            _stagingBtn.backgroundColor=[UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
            [_stagingBtn setTitle:@"不分期" forState:UIControlStateNormal];
            _stagingBtn.layer.cornerRadius = 4;
            [_stagingBtn setTag:100];
            [_stagingBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [_stagingBtn setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
            _stagingBtn.titleLabel.font=[UIFont systemFontOfSize:15];
            [_stagingBtn addTarget:self action:@selector(stagingBtnCOntroller:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:self.stagingBtn];
            [_stagingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(41);
                make.left.mas_equalTo(15);
                make.size.mas_equalTo(CGSizeMake(168, 59));
            }];
            
            _phasesBtn=[[UIButton alloc]init];
            _phasesBtn.backgroundColor=[UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
            [_phasesBtn setTitle:@"2期" forState:UIControlStateNormal];
            _phasesBtn.layer.cornerRadius = 4;
            _phasesBtn.tag=101;
            [_phasesBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [_phasesBtn setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
            _phasesBtn.titleLabel.font=[UIFont systemFontOfSize:15];
            [_phasesBtn addTarget:self action:@selector(stagingBtnCOntroller:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:self.phasesBtn];
            
            [_phasesBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(41);
                make.right.mas_equalTo(-15);
                make.size.mas_equalTo(CGSizeMake(168, 59));
            }];
            
            _stagestagingBtn=[[UIButton alloc]init];
            _stagestagingBtn.backgroundColor=[UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
            _stagestagingBtn.tag=102;
            [_stagestagingBtn setTitle:@"3期" forState:UIControlStateNormal];
            _stagestagingBtn.layer.cornerRadius = 4;
            [_stagestagingBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [_stagestagingBtn setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
            _stagestagingBtn.titleLabel.font=[UIFont systemFontOfSize:15];
            [_stagestagingBtn addTarget:self action:@selector(stagingBtnCOntroller:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:self.stagestagingBtn];
            [_stagestagingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(115);
                make.left.mas_equalTo(15);
                make.size.mas_equalTo(CGSizeMake(168, 59));
            }];
            
        }
    }else if (indexPath.section==1) {
        if (indexPath.row==0) {
            UILabel *label = [[UILabel alloc] init];
            label.numberOfLines = 0;
            NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"交易周期"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 13],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
            
            label.attributedText = string;
            label.textAlignment = NSTextAlignmentLeft;
            label.alpha = 1.0;
            [cell addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(21);
                make.left.mas_equalTo(14);
                make.size.mas_equalTo(CGSizeMake(74, 21));
            }];
        }else if (indexPath.row==1) {
            if (_btnTag==1) {
                UIImageView *remainderImg=[[UIImageView alloc]init];
                remainderImg.image=[UIImage imageNamed:@"我的_分组7"];
                [cell addSubview:remainderImg];
                [remainderImg mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(14);
                    make.left.mas_equalTo(15);
                    make.size.mas_equalTo(CGSizeMake(30, 30));
                }];
                
                UILabel *label = [[UILabel alloc] init];
                label.numberOfLines = 0;
                NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"账户余额（剩余：¥6000）"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 14],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
                label.attributedText = string;
                label.textAlignment = NSTextAlignmentLeft;
                label.alpha = 1.0;
                [cell addSubview:label];
                [label mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(19);
                    make.left.mas_equalTo(57);
                    make.size.mas_equalTo(CGSizeMake(180, 21));
                }];
                
                _btn=[[UIButton alloc]init];
                [_btn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
                [_btn setImage:[UIImage imageNamed:@"支付_分组 3"] forState:UIControlStateSelected];
                [_btn addTarget:self action:@selector(aaa) forControlEvents:UIControlEventTouchUpInside];
                [cell addSubview:self.btn];
                [_btn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo (20);
                    make.right.mas_equalTo(-13);
                    make.size.mas_equalTo(CGSizeMake(19, 19));
                }];
            }else if (_btnTag==2) {
                UILabel *label = [[UILabel alloc] init];
                label.numberOfLines = 0;
                NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"第一期，买家付金额"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 14],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
                label.attributedText = string;
                label.textAlignment = NSTextAlignmentLeft;
                label.alpha = 1.0;
                [cell addSubview:label];
                [label mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(14);
                    make.left.mas_equalTo(44);
                    make.size.mas_equalTo(CGSizeMake(135, 21));
                }];
                
                UITextField *label1 = [[UITextField alloc] init];
                label1.textColor=[UIColor colorWithRed:248/255.0 green:124/255.0 blue:43/255.0 alpha:1.0];
                label1.textAlignment = NSTextAlignmentLeft;
                label1.alpha = 1.0;
                label1.placeholder=@"输金额";
                label1.tag=0;
                label1.delegate=self;
                [cell addSubview:label1];
                [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(14);
                    make.left.mas_equalTo(185);
                    make.size.mas_equalTo(CGSizeMake(75, 21));
                }];
                
                UILabel *label2 = [[UILabel alloc] init];
                label2.numberOfLines = 0;
                NSMutableAttributedString *string2 = [[NSMutableAttributedString alloc] initWithString:@"未支付"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 12],NSForegroundColorAttributeName: [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0]}];
                label2.attributedText = string2;
                label2.textAlignment = NSTextAlignmentLeft;
                label2.alpha = 1.0;
                [cell addSubview:label2];
                [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(14);
                    make.right.mas_equalTo(-15);
                    make.size.mas_equalTo(CGSizeMake(40, 16));
                }];
            }else if (_btnTag==3) {
                UILabel *label = [[UILabel alloc] init];
                label.numberOfLines = 0;
                NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"第一期，买家付金额"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 14],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
                label.attributedText = string;
                label.textAlignment = NSTextAlignmentLeft;
                label.alpha = 1.0;
                [cell addSubview:label];
                [label mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(14);
                    make.left.mas_equalTo(44);
                    make.size.mas_equalTo(CGSizeMake(135, 21));
                }];
                
                UITextField *label1 = [[UITextField alloc] init];
                label1.textColor=[UIColor colorWithRed:248/255.0 green:124/255.0 blue:43/255.0 alpha:1.0];
                label1.textAlignment = NSTextAlignmentLeft;
                label1.alpha = 1.0;
                label1.placeholder=@"输金额";
                label1.tag=0;
                label1.delegate=self;
                [cell addSubview:label1];
                [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(14);
                    make.left.mas_equalTo(185);
                    make.size.mas_equalTo(CGSizeMake(75, 21));
                }];
                
                UILabel *label2 = [[UILabel alloc] init];
                label2.numberOfLines = 0;
                NSMutableAttributedString *string2 = [[NSMutableAttributedString alloc] initWithString:@"未支付"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 12],NSForegroundColorAttributeName: [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0]}];
                label2.attributedText = string2;
                label2.textAlignment = NSTextAlignmentLeft;
                label2.alpha = 1.0;
                [cell addSubview:label2];
                [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(14);
                    make.right.mas_equalTo(-15);
                    make.size.mas_equalTo(CGSizeMake(40, 16));
                }];
            }
            
        }else if (indexPath.row==2) {
            if (_btnTag==1) {
                UIImageView *remainderImg=[[UIImageView alloc]init];
                remainderImg.image=[UIImage imageNamed:@"支付_支付宝"];
                [cell addSubview:remainderImg];
                [remainderImg mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(14);
                    make.left.mas_equalTo(15);
                    make.size.mas_equalTo(CGSizeMake(30, 30));
                }];
                
                UILabel *label = [[UILabel alloc] init];
                label.numberOfLines = 0;
                NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"支付宝账户  （张**）"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 14],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
                label.attributedText = string;
                label.textAlignment = NSTextAlignmentLeft;
                label.alpha = 1.0;
                [cell addSubview:label];
                [label mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(19);
                    make.left.mas_equalTo(57);
                    make.size.mas_equalTo(CGSizeMake(180, 21));
                }];
                
                _btn=[[UIButton alloc]init];
                [_btn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
                [_btn setImage:[UIImage imageNamed:@"支付_分组 3"] forState:UIControlStateSelected];
                [_btn addTarget:self action:@selector(aaa) forControlEvents:UIControlEventTouchUpInside];
                [cell addSubview:self.btn];
                [_btn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo (20);
                    make.right.mas_equalTo(-13);
                    make.size.mas_equalTo(CGSizeMake(19, 19));
                }];
            }else if (_btnTag==2) {
                UILabel *label = [[UILabel alloc] init];
                label.numberOfLines = 0;
                NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"第二期，买家付金额"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 14],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
                label.attributedText = string;
                label.textAlignment = NSTextAlignmentLeft;
                label.alpha = 1.0;
                [cell addSubview:label];
                [label mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(14);
                    make.left.mas_equalTo(44);
                    make.size.mas_equalTo(CGSizeMake(135, 21));
                }];
                
                UITextField *label1 = [[UITextField alloc] init];
                label1.textColor=[UIColor colorWithRed:248/255.0 green:124/255.0 blue:43/255.0 alpha:1.0];
                label1.textAlignment = NSTextAlignmentLeft;
                label1.alpha = 1.0;
                label1.placeholder=@"输金额";
                label1.tag=1;
                label1.delegate=self;
                [cell addSubview:label1];
                [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(14);
                    make.left.mas_equalTo(185);
                    make.size.mas_equalTo(CGSizeMake(75, 21));
                }];
                
                UILabel *label2 = [[UILabel alloc] init];
                label2.numberOfLines = 0;
                NSMutableAttributedString *string2 = [[NSMutableAttributedString alloc] initWithString:@"未支付"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 12],NSForegroundColorAttributeName: [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0]}];
                label2.attributedText = string2;
                label2.textAlignment = NSTextAlignmentLeft;
                label2.alpha = 1.0;
                [cell addSubview:label2];
                [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(14);
                    make.right.mas_equalTo(-15);
                    make.size.mas_equalTo(CGSizeMake(40, 16));
                }];
            }else if (_btnTag==3) {
                UILabel *label = [[UILabel alloc] init];
                label.numberOfLines = 0;
                NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"第二期，买家付金额"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 14],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
                label.attributedText = string;
                label.textAlignment = NSTextAlignmentLeft;
                label.alpha = 1.0;
                [cell addSubview:label];
                [label mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(14);
                    make.left.mas_equalTo(44);
                    make.size.mas_equalTo(CGSizeMake(135, 21));
                }];
                
                UITextField *label1 = [[UITextField alloc] init];
                label1.textColor=[UIColor colorWithRed:248/255.0 green:124/255.0 blue:43/255.0 alpha:1.0];
                label1.textAlignment = NSTextAlignmentLeft;
                label1.alpha = 1.0;
                label1.placeholder=@"输金额";
                label1.tag=1;
                label1.delegate=self;
                [cell addSubview:label1];
                [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(14);
                    make.left.mas_equalTo(185);
                    make.size.mas_equalTo(CGSizeMake(75, 21));
                }];
                
                UILabel *label2 = [[UILabel alloc] init];
                label2.numberOfLines = 0;
                NSMutableAttributedString *string2 = [[NSMutableAttributedString alloc] initWithString:@"未支付"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 12],NSForegroundColorAttributeName: [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0]}];
                label2.attributedText = string2;
                label2.textAlignment = NSTextAlignmentLeft;
                label2.alpha = 1.0;
                [cell addSubview:label2];
                [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(14);
                    make.right.mas_equalTo(-15);
                    make.size.mas_equalTo(CGSizeMake(40, 16));
                }];
                
            }
            
        }else if (indexPath.row==3) {
            if (_btnTag==1) {
                UIImageView *remainderImg=[[UIImageView alloc]init];
                remainderImg.image=[UIImage imageNamed:@"支付_微信"];
                [cell addSubview:remainderImg];
                [remainderImg mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(14);
                    make.left.mas_equalTo(15);
                    make.size.mas_equalTo(CGSizeMake(30, 30));
                }];
                
                UILabel *label = [[UILabel alloc] init];
                label.numberOfLines = 0;
                NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"微信账户（张**）"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 14],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
                label.attributedText = string;
                label.textAlignment = NSTextAlignmentLeft;
                label.alpha = 1.0;
                [cell addSubview:label];
                [label mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(19);
                    make.left.mas_equalTo(57);
                    make.size.mas_equalTo(CGSizeMake(180, 21));
                }];
                
                _btn=[[UIButton alloc]init];
                [_btn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
                [_btn setImage:[UIImage imageNamed:@"支付_分组 3"] forState:UIControlStateSelected];
                [_btn addTarget:self action:@selector(aaa) forControlEvents:UIControlEventTouchUpInside];
                [cell addSubview:self.btn];
                [_btn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo (20);
                    make.right.mas_equalTo(-13);
                    make.size.mas_equalTo(CGSizeMake(19, 19));
                }];
            }else if (_btnTag==3) {
                UILabel *label = [[UILabel alloc] init];
                label.numberOfLines = 0;
                NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"第三期，买家付金额"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 14],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
                label.attributedText = string;
                label.textAlignment = NSTextAlignmentLeft;
                label.alpha = 1.0;
                [cell addSubview:label];
                [label mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(14);
                    make.left.mas_equalTo(44);
                    make.size.mas_equalTo(CGSizeMake(135, 21));
                }];
                
                UITextField *label1 = [[UITextField alloc] init];
                label1.textColor=[UIColor colorWithRed:248/255.0 green:124/255.0 blue:43/255.0 alpha:1.0];
                label1.textAlignment = NSTextAlignmentLeft;
                label1.alpha = 1.0;
                label1.placeholder=@"输金额";
                label1.tag=2;
                label1.delegate=self;
                [cell addSubview:label1];
                [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(14);
                    make.left.mas_equalTo(185);
                    make.size.mas_equalTo(CGSizeMake(75, 21));
                }];
                
                UILabel *label2 = [[UILabel alloc] init];
                label2.numberOfLines = 0;
                NSMutableAttributedString *string2 = [[NSMutableAttributedString alloc] initWithString:@"未支付"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 12],NSForegroundColorAttributeName: [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0]}];
                label2.attributedText = string2;
                label2.textAlignment = NSTextAlignmentLeft;
                label2.alpha = 1.0;
                [cell addSubview:label2];
                [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(14);
                    make.right.mas_equalTo(-15);
                    make.size.mas_equalTo(CGSizeMake(40, 16));
                }];
                
            }
        }
        
    }
    
    return cell;
}

- (void)stagingBtnCOntroller:(UIButton *)sender {
    //    User *user = _users[sender.tag];
    //    PhotoPickerController *photoPicker = [[PhotoPickerController alloc] init];
    //    photoPicker.user = user;
    //    [self.navigationController pushViewController:photoPicker animated:YES]
    if (sender.tag==100) {
        self.stagingBtn.selected = !self.stagingBtn.selected;
        self.stagingBtn=_stagingBtn;
        _btnTag=1;
        self.phasesBtn.selected=NO;
        self.stagestagingBtn.selected=NO;
        [self.stagingBtn setUserInteractionEnabled:NO];
        [self.phasesBtn setUserInteractionEnabled:YES];
        [self.stagestagingBtn setUserInteractionEnabled:YES];
    }else if (sender.tag==101) {
        self.phasesBtn.selected=!self.phasesBtn.selected;
        self.phasesBtn=_phasesBtn;
        _btnTag=2;
        self.stagingBtn.selected=NO;
        self.stagestagingBtn.selected=NO;
        [self.phasesBtn setUserInteractionEnabled:NO];
        [self.stagingBtn setUserInteractionEnabled:YES];
        [self.stagestagingBtn setUserInteractionEnabled:YES];
    }else if (sender.tag==102) {
        self.stagestagingBtn.selected=!self.stagestagingBtn.selected;
        self.stagestagingBtn=_stagestagingBtn;
        self.phasesBtn.selected=NO;
        _btnTag=3;
        self.stagingBtn.selected=NO;
        [self.stagestagingBtn setUserInteractionEnabled:NO];
        [self.phasesBtn setUserInteractionEnabled:YES];
        [self.stagingBtn setUserInteractionEnabled:YES];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self->_tab reloadData];
       
        if (sender.tag==100) {
            [_payoffBtn mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(501);
                make.left.mas_equalTo(51);
                make.right.mas_equalTo(-51);
                make.height.mas_equalTo(39);
            }];
        }else if (sender.tag==101) {
            [_payoffBtn mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(428);
                make.left.mas_equalTo(51);
                make.right.mas_equalTo(-51);
                make.height.mas_equalTo(39);
            }];
        }else if (sender.tag==102){
            [_payoffBtn mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(501);
                make.left.mas_equalTo(51);
                make.right.mas_equalTo(-51);
                make.height.mas_equalTo(39);
            }];
            
        }
        
        if (sender.tag==100) {
            [_payoffBtn setTitle:@"提交卖家确认" forState:UIControlStateNormal];
        }else if (sender.tag==101) {
            [_payoffBtn setTitle:@"提交卖家确认" forState:UIControlStateNormal];
        }else if (sender.tag==102) {
           
            [_payoffBtn setTitle:@"提交卖家确认" forState:UIControlStateNormal];
        }
//         [_payoffBtn setTitle:[NSString stringWithFormat:@"%d",sender.tag] forState:UIControlStateNormal];
    });
}

- (void)payOffAction{
//    if (_btnTag > 1) {
//        ETPaymentStagesVC *payVC=[ETPaymentStagesVC paymentStagesVC:_btnTag];
//        payVC.product=_product;
//        payVC.finalPrice= @"15000";
//        payVC.releaseId=_releaseId;
//        [self.navigationController pushViewController:payVC animated:YES];
//    }
    if (_btnTag==1) {
        [self PostStageUI];
    }
    if(_btnTag==2)
        [self PostStage2UI];
    if (_btnTag==3) {
        [self PostStage3UI];
    }
    _payoffBtn.enabled=NO;
    [_payoffBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString* price=[textField.text stringByAppendingString:string];
    if (textField.tag==0) {
        _stagePrice=price;
    }
    else if (textField.tag==1) {
        _stagePrice1=price;
    }
    else if (textField.tag==2) {
        _stagePrice2=price;
    }
    _finalPrice=price;
    NSLog(@"结束编辑");
    return YES;
    
}

#pragma mark - 不分期
- (void)PostStageUI {
    NSMutableDictionary* dic=[NSMutableDictionary new];
    float payment=[_finalPrice floatValue]/2;
    NSArray* priceArr=@[_finalPrice];
    NSDictionary *params = @{
                             @"id" : @(6),
                             @"price" : priceArr,
                             @"productId" : _releaseId,
                             @"type" : @(2)
                             
                             };
    [HttpTool get:[NSString stringWithFormat:@"pay/prePay"] params:params success:^(id responseObj) {
        
        NSString* a=responseObj[@"data"][@"result"];
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:[a dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
        //
        NSDictionary* d=[jsonDict copy];
        NSLog(@"");
        [MBProgressHUD showMBProgressHud:self.view withText:@"提交成功" withTime:1];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
#pragma mark - 分期二期
- (void)PostStage2UI {
    NSMutableDictionary* dic=[NSMutableDictionary new];
    float payment=[_finalPrice floatValue]/2;
    NSArray* priceArr=@[_stagePrice,_stagePrice1];
    NSDictionary *params = @{
                             @"id" : @(8),
                             @"price" : priceArr,
                             @"productId" : _releaseId,
                             @"type" : @(2)
                             
                             };
    [HttpTool get:[NSString stringWithFormat:@"pay/prePay"] params:params success:^(id responseObj) {
        
        NSString* a=responseObj[@"data"][@"result"];
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:[a dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
        //
        NSDictionary* d=[jsonDict copy];
        NSLog(@"");
        [MBProgressHUD showMBProgressHud:self.view withText:@"提交成功" withTime:1];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

#pragma mark - 分期三期
- (void)PostStage3UI {
    NSMutableDictionary* dic=[NSMutableDictionary new];
    float payment=[_finalPrice floatValue]/3;
    NSArray* priceArr=@[_stagePrice,_stagePrice1,_stagePrice2];
    NSDictionary *params = @{
                             @"id" : @(9),
                             @"price" : priceArr,
                             @"productId" : _releaseId,
                             @"type" : @(2)
                             
                             };
    [HttpTool get:[NSString stringWithFormat:@"pay/prePay"] params:params success:^(id responseObj) {
        
        NSString* a=responseObj[@"data"][@"result"];
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:[a dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
        //
        NSDictionary* d=[jsonDict copy];
        NSLog(@"");
        [MBProgressHUD showMBProgressHud:self.view withText:@"提交成功" withTime:1];

    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
- (void)aaa {
    if (_btn.selected==YES) {
        _btn.selected=NO;
    }else {
        _btn.selected=YES;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [_tab deselectRowAtIndexPath:indexPath animated:YES];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    // 2
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    // 3点击没有颜色改变
    cell.selected = NO;
    //    if (indexPath.section==1) {
    //        if (indexPath.row==0) {
    //            ETPayaymentViewController *payVC=[[ETPayaymentViewController alloc]init];
    //            [self.navigationController pushViewController:payVC animated:YES];
    //        }
    //    }
    
# pragma mark ---支付宝
    
    if (indexPath.section==1) {
        if (indexPath.row==2) {
//            APOrderInfo* order = [APOrderInfo new];
//            // NOTE: app_id设置
//            NSString *appid = @"2019052665415366";
//            order.app_id = appid;
//
//            // NOTE: 支付接口名称
//            order.method = @"alipay.trade.app.pay";
//
//            // NOTE: 参数编码格式
//            order.charset = @"UTF-8";
//
//            // NOTE: 当前时间点
//            NSDateFormatter* formatter = [NSDateFormatter new];
//            [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//            order.timestamp = [formatter stringFromDate:[NSDate date]];
//
//            // NOTE: 支付版本
//            order.version = @"1.0";
//            NSString *rsa2PrivateKey = @"MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCi1f2zFmPgjfOnw+d7kVCwgkHtf+CumRxkKRsNSBWktPQB/A0qdHuHfF5RoSWOzrtBHSzCDZjatgyPgoo2uhxAVB4bxrTLOIGULlsbxCC0rUEigNwSPssyn7zJLsUlXUfmxMMW26OUQ7s5sk8HWT7pDZi2jL6nUnyTbzLJO7//UgFrOe1Ngl7Fm+pwc8O7wHLqm+QX+uKs4hZ9JALW6SXGcEGzfmSH7kscVnM9DYuhQakn3gVhrbUq4GQj2bMl6B6KPlZR4OIPFlAJ87O9R6nAhThR3fJ+D9a55GgPgxbk9/Tiz3fOfte6r0wTwF3Skhl5F1fvWPNWEiO8BLtaSmqRAgMBAAECggEBAJINWfZtmLvq1qadIl1E45jN3JBHaKFyF3MHI4pwI2mOHGZDSxPPUpUdSgPxhBxo9K/cmS6cv4M8UlvN/GZF290fFbpYKgU085STV4i6C5PC6m8mIT4EMIGBoPTaDF4NItarmUhBTKFJdv6zHgs7Ux/54AWsi7zMUYxz6ptwCi/YUBWHt/+cVSYTSeN+Uve936KpPEste+QnUTO3qmxkK+p1dVdH2R/HjmEB6nc4o5YBRboAs9xTkTpS/Buol+DrE4sWUn68MK0mXYSO/Khq+ZzBG0BOfLmLflHS8XkdZO6dTo0AeEEsJEURpt32Kb5G8FZKS8aLUlekSqqU1aYtLYECgYEA4MS+s0hhR434GDMMqgv4YNMCoxxZj76QoLkMTmTXQX1Kdk6hfX2KPGkFRuU+d4dyuRYhC5t5yqtte621pAxou6At0DDxS1XqAOid0Gko0oNowzNYdQzR3aJTP7NJw0H/Aip9VvBr9vUuADxv+dfYqerFmZ+nr40rZ5ojhsRak7kCgYEAuXY8mBECKpZBocO0H0c9GCBAs8oj27m0IaOMNhHdG12wWz9i/Bp1RtW9AdUgLxUBXKuruLI7oF3Bz7jL7EmJ44lQEzPMkVxaavANIHe85R+2FktcyHH/uOAGjl1Ti0bp8bVR8KQUcIb5qX6JI3GokftXbBEALv+HUpQ2F/E7qZkCgYAckaVTkF2dBLSGDucLLh5R4EAzj0Tq+mPTqfGgfTzG/C/cvb3U/4H0j7y1+Clqc/LnB6MHoKloU0XFNJ0jztf5ETEBh1cEJlVp7Ccy+ErSBxXnybzyk8CRFTLTo+w6P0c0dUYdKM3wQ9Wm/geVkBPf9RFMp3he3eiocHUXihmhMQKBgE0l8CLZwGrywi6GeGEigzmMAR5JEg2O/G2Z2PONDssZeAkdHxH795kVxGAExjSPqldgWjike8VD+yFrn/iUxrVOI285dvloz3v4i51b8cnmHRq9EsWXFmdTWabTD7O6NgsEACf4OUBuBWEKcAW8fADt6vnbQJZMWYByguYGxWjRAoGBANxwqks45sPGzH6pi56hHD8jsVpUetZRhhc3Awr8814EQ6ULd9y10+fBGEVo3b2u/6P3n65CGkIpKKzYijDPiLX/crVKj+1eF9RsqPbX+uR2iALeptREQl5/DBWh1S8i254cfskzzlUYzdicuvooZBl3Dfe4kN+riYl2cXSnIs1s";
//
//            NSString *rsaPrivateKey = nil;
//            // NOTE: sign_type 根据商户设置的私钥来决定
//            order.sign_type = (rsa2PrivateKey.length > 1)?@"RSA2":@"RSA";
//
//            // NOTE: 商品数据
//            order.biz_content = [APBizContent new];
//            order.biz_content.body = @"我是测试数据";
//            order.biz_content.subject = @"1";
//            order.biz_content.out_trade_no = [self generateTradeNO]; //订单ID（由商家自行制定）
//            order.biz_content.timeout_express = @"30m"; //超时时间设置
//            order.biz_content.total_amount = [NSString stringWithFormat:@"%.2f", 0.01]; //商品价格
//
//            //将商品信息拼接成字符串
//            NSString *orderInfo = [order orderInfoEncoded:NO];
//            NSString *orderInfoEncoded = [order orderInfoEncoded:YES];
//            NSLog(@"orderSpec = %@",orderInfo);
//
//            // NOTE: 获取私钥并将商户信息签名，外部商户的加签过程请务必放在服务端，防止公私钥数据泄露；
//            //       需要遵循RSA签名规范，并将签名字符串base64编码和UrlEncode
//            //                id<DataSigner> signer =CreateRSADataSigner(privateKey);
//            NSString *signedString = nil;
//            APRSASigner* signer = [[APRSASigner alloc] initWithPrivateKey:((rsa2PrivateKey.length > 1)?rsa2PrivateKey:rsaPrivateKey)];
//            if ((rsa2PrivateKey.length > 1)) {
//                signedString = [signer signString:orderInfo withRSA2:YES];
//            } else {
//                signedString = [signer signString:orderInfo withRSA2:NO];
//            }
//
//
//
//            // NOTE: 如果加签成功，则继续执行支付
//            if (signedString!= nil) {
//                //应用注册scheme,在AliSDKDemo-Info.plist定义URL types
//                NSString *appScheme = @"alisdkdemo";
//
//                // NOTE: 将签名成功字符串格式化为订单字符串,请严格按照该格式
//                NSString *orderString = [NSString stringWithFormat:@"%@&sign=%@",
//                                         orderInfoEncoded, signedString];
//
//                // NOTE: 调用支付结果开始支付
//                [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
//                    NSLog(@"reslut = %@",resultDic);
//                }];
//            }
            
        }else if (indexPath.row==3) {
//            [self PostUI];
        }
    }
    
}
#pragma mark   ==============产生随机订单号==============
- (NSString *)generateTradeNO
{
    static int kNumber = 15;
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand((unsigned)time(0));
    for (int i = 0; i < kNumber; i++)
    {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            return 50;
        }else if (indexPath.row==1) {
            return 180;
        }
    }else if (indexPath.section==1) {
        return 50;
        
    }
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
