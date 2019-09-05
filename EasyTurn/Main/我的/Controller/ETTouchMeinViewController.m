//
//  ETTouchMeinViewController.m
//  EasyTurn
//
//  Created by 王翔 on 2019/7/23.
//  Copyright © 2019年 EasyTurn. All rights reserved.
//

#import "ETTouchMeinViewController.h"

@interface ETTouchMeinViewController ()
@property(nonatomic,strong)UITextField *textField1;
@property(nonatomic,strong)UITextField *textField2;
@property(nonatomic,strong)UITextField *textField3;
@property(nonatomic,strong)UIButton *touchBtn;
@end

@implementation ETTouchMeinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"联系我们";
    self.view.backgroundColor=[UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    [self.view addSubview:self.textField1];
    [self.view addSubview:self.textField2];
    [self.view addSubview:self.textField3];
    [self.view addSubview:self.touchBtn];
    [_textField1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(148);
    }];
    
    [_textField2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(178);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(49);
    }];
    
    [_textField3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(242);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(49);
    }];
    
    [_touchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(320);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(48);
    }];
    [self PostUI];
}

- (UITextField *)textField1
{
    if (!_textField1) {
        _textField1=[[UITextField alloc]init];
        _textField1.layer.cornerRadius=5;
//        _textField1.textAlignment = UITextAlignmentLeft;
        _textField1.contentVerticalAlignment =UIControlContentHorizontalAlignmentLeft ;
        _textField1.placeholder=@"请输入您好反馈的信息";
        _textField1.backgroundColor=[UIColor whiteColor];
    }
    return _textField1;
}

- (UITextField *)textField2
{
    if (!_textField2) {
        _textField2=[[UITextField alloc]init];
        _textField2.layer.cornerRadius=5;
        //        _textField1.textAlignment = UITextAlignmentLeft;
        _textField2.contentVerticalAlignment =UIControlContentVerticalAlignmentCenter ;
        _textField2.placeholder=@"请输入您的昵称";
        _textField2.backgroundColor=[UIColor whiteColor];
    }
    return _textField2;
}

- (UITextField *)textField3
{
    if (!_textField3) {
        _textField3=[[UITextField alloc]init];
        _textField3.layer.cornerRadius=5;
        //        _textField1.textAlignment = UITextAlignmentLeft;
        _textField3.contentVerticalAlignment =UIControlContentVerticalAlignmentCenter ;
        _textField3.placeholder=@"请输入您的联系方式";
        _textField3.keyboardType=UIKeyboardTypeDecimalPad;
        _textField3.backgroundColor=[UIColor whiteColor];
    }
    return _textField3;
}

- (UIButton *)touchBtn
{
    if (!_touchBtn) {
        _touchBtn=[[UIButton alloc]init];
        [_touchBtn setTitle:@"提交" forState:UIControlStateNormal];
        _touchBtn.backgroundColor=[UIColor colorWithRed:47/255.0 green:134/255.0 blue:251/255.0 alpha:1.0];
        _touchBtn.layer.cornerRadius = 5;
        _touchBtn.tag=1;
        [_touchBtn addTarget:self action:@selector(diaoyong:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _touchBtn;
}

- (void)diaoyong:(UIButton*)sender{
     [self PostUI:@"1"];
    if ([_textField1.text isEqualToString:@""] ||
        [_textField2.text isEqualToString:@""] ||
        [_textField3.text isEqualToString:@""]
        ) {
        
        [MBProgressHUD showMBProgressHud:self.view withText:@"亲，内容不能为空哦！" withTime:1];
        
    }else{
          [MBProgressHUD showMBProgressHud:self.view withText:@"提交成功" withTime:1];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
    }
  
    
}
//- (void)topTextFieldView
//{
//    _textField1=[[UITextField alloc]init];
//    _textField1.backgroundColor=[UIColor whiteColor];
//
//    _textField2=[[UITextField alloc]init];
//    _textField2.backgroundColor=[UIColor whiteColor];
//
//    _textField3=[[UITextField alloc]init];
//    _textField3.backgroundColor=[UIColor whiteColor];
//}
#pragma mark - 用户信息
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
        //        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString: "attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 13],NSForegroundColorAttributeName: [UIColor colorWithRed:218/255.0 green:218/255.0 blue:218/255.0 alpha:1.0]}];
        //        _companyLab.attributedText = string;
        //            ETProductModel* p=[ETProductModel mj_objectWithKeyValues:prod];
        //            [_products addObject:p];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)PostUI:(NSString*)head {
    NSDictionary *params = @{
                             @"content" :_textField1.text,
                             @"mobile":_textField3.text,
                             @"name":_textField2.text
                             };
    NSData *data =    [NSJSONSerialization dataWithJSONObject:params options:NSUTF8StringEncoding error:nil];
    
    [HttpTool post:[NSString stringWithFormat:@"feedback/add"] params:params success:^(NSDictionary *response) {
    } failure:^(NSError *error) {
    }];
}


@end
