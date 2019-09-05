//
//  ETNameViewController.m
//  EasyTurn
//
//  Created by 王翔 on 2019/8/3.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import "ETNameViewController.h"

@interface ETNameViewController () <UITextFieldDelegate>
@property (nonatomic,strong)UITextField *textField;
@end

@implementation ETNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.textField];
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(50);
    }];
    
}
- (UITextField *)textField {
    if (!_textField) {
        _textField=[[UITextField alloc]init];
        _textField.text=@"易转用户";
        _textField.clearButtonMode=UITextFieldViewModeWhileEditing;
        _textField.backgroundColor=[UIColor whiteColor];
    }
    return _textField;
}


@end
