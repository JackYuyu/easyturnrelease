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
    }
    return _touchBtn;
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

@end
