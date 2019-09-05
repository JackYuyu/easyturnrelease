//
//  ETRegisterViewController.m
//  EasyTurn
//
//  Created by 程立 on 2019/7/18.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import "ETRegisterViewController.h"
#import "UIButton+AHKit.h"
static NSInteger  kPhoneTextFieldTag = 5678;
@interface ETRegisterViewController ()
@property (nonatomic, strong) UIImageView *imagevLogo;
@property (nonatomic, strong) UITextField *tfUserName;
@property (nonatomic, strong) UITextField *tfSecurityCode;
@property (nonatomic, strong) UITextField *tfPassWord;
@property (nonatomic, strong) UITextField *tfInvitationCode;
@property (nonatomic, strong) UIButton *btnRegister;
@property (nonatomic, strong) UIButton *btnSelectedAgreement;
@property (nonatomic, strong) UIButton *btnUserAgreement;
@property (nonatomic, strong) UIButton *btnAgreement;
@property (nonatomic, strong) UIButton *btnPrivacy;
@property (nonatomic, strong) UIButton *btnSecurityCode;
@property (nonatomic, strong) UILabel *labPhoneErrorMessage;
@end

@implementation ETRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createSubViewsAndConstraints];
}

#pragma mark - Create Subviews
- (void)createSubViewsAndConstraints {
    
    self.view.backgroundColor = kACColorWhite;
    
    _imagevLogo = [[UIImageView alloc]init];
    _imagevLogo.image = [UIImage imageNamed:@"登录_logo"];
    [self.view addSubview:_imagevLogo];
    [_imagevLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(Screen_Height *(51 / 667.0));
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(87, 34));
    }];
    
    UIButton *btnLeftBack = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnLeftBack setImage:[UIImage imageNamed:@"nav_leftBack_Black"] forState:UIControlStateNormal];
    [btnLeftBack addTarget:self action:@selector(onClickLeftBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnLeftBack];
    [btnLeftBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.imagevLogo);
        make.left.mas_equalTo(16);
        make.size.mas_equalTo(CGSizeMake(8, 15));
    }];
    
    _tfUserName = [[UITextField alloc]init];
    _tfUserName.clearButtonMode = UITextFieldViewModeWhileEditing;
    _tfUserName.tag = kPhoneTextFieldTag;
    _tfUserName.textColor = kACColorBlackTypeface;
    _tfUserName.borderStyle = UITextBorderStyleNone;
    _tfUserName.placeholder = @"请输入手机号";
    [_tfUserName setValue:kACColorRGB(102, 102, 102) forKeyPath:@"_placeholderLabel.textColor"];
    [_tfUserName setValue:kFontSize(15) forKeyPath:@"_placeholderLabel.font"];
    _tfUserName.font = kFontSize(15);
    _tfUserName.keyboardType = UIKeyboardTypePhonePad;
    _tfUserName.textAlignment = NSTextAlignmentLeft;
    [_tfUserName addTarget:self action:@selector(textFieldValueChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:_tfUserName];
    [_tfUserName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imagevLogo.mas_bottom).offset(104);
        make.left.mas_equalTo(30);
        make.right.mas_equalTo(-130);
        make.height.mas_equalTo(31);
    }];
    
    
    UIView *vLineUserName = [[UIView alloc]init];
    vLineUserName.backgroundColor = kACColorRGB(242, 242, 242);
    [self.view addSubview:vLineUserName];
    [vLineUserName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.tfUserName.mas_bottom).offset(3);
        make.left.mas_equalTo(30);
        make.right.mas_equalTo(-30);
        make.height.mas_equalTo(1);
    }];
    
    _labPhoneErrorMessage = [[UILabel alloc] init];
    _labPhoneErrorMessage.text = @"请输入正确的手机号";
    _labPhoneErrorMessage.textColor = kACColorRed_R248_G88_B88_A1;
    _labPhoneErrorMessage.font = kFontSize(12);
    _labPhoneErrorMessage.numberOfLines = 1;
    _labPhoneErrorMessage.clipsToBounds = YES;
    [self.view addSubview:_labPhoneErrorMessage];
    [_labPhoneErrorMessage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30);
        make.height.mas_equalTo(0);
        make.right.equalTo(vLineUserName.mas_right);
        make.top.equalTo(vLineUserName.mas_bottom);
    }];
    
    _btnSecurityCode = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btnSecurityCode setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_btnSecurityCode setTitleColor:kACColorRGB(20, 138, 236) forState:UIControlStateNormal];
    _btnSecurityCode.titleLabel.font = kFontSize(12);
    [_btnSecurityCode addTarget:self action:@selector(sendcode) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnSecurityCode];
    [_btnSecurityCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.tfUserName);
        make.right.mas_equalTo(-30);
    }];
    
    _tfSecurityCode = [[UITextField alloc]init];
    _tfSecurityCode.clearButtonMode = UITextFieldViewModeWhileEditing;
    _tfSecurityCode.textColor = kACColorBlackTypeface;
    _tfSecurityCode.borderStyle = UITextBorderStyleNone;
    _tfSecurityCode.placeholder = @"请输入短信验证码";
    [_tfSecurityCode setValue:kACColorRGB(102, 102, 102) forKeyPath:@"_placeholderLabel.textColor"];
    [_tfSecurityCode setValue:kFontSize(15) forKeyPath:@"_placeholderLabel.font"];
    _tfSecurityCode.font = kFontSize(15);
    _tfSecurityCode.keyboardType = UIKeyboardTypePhonePad;
    _tfSecurityCode.textAlignment = NSTextAlignmentLeft;
    [_tfSecurityCode addTarget:self action:@selector(textFieldValueChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:_tfSecurityCode];
    [_tfSecurityCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labPhoneErrorMessage.mas_bottom).offset(20);
        make.left.mas_equalTo(30);
        make.right.mas_equalTo(-30);
        make.height.mas_equalTo(31);
    }];
    
    UIView *vLineSecurityCode = [[UIView alloc]init];
    vLineSecurityCode.backgroundColor = kACColorRGB(242, 242, 242);
    [self.view addSubview:vLineSecurityCode];
    [vLineSecurityCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.tfSecurityCode.mas_bottom).offset(3);
        make.left.mas_equalTo(30);
        make.right.mas_equalTo(-30);
        make.height.mas_equalTo(1);
    }];
    
    _tfPassWord = [[UITextField alloc]init];
    _tfPassWord.clearButtonMode = UITextFieldViewModeWhileEditing;
    _tfPassWord.textColor = kACColorBlackTypeface;
    _tfPassWord.borderStyle = UITextBorderStyleNone;
    _tfPassWord.placeholder = @"请输入密码";
    _tfPassWord.secureTextEntry=YES;
    [_tfPassWord setValue:kACColorRGB(102, 102, 102) forKeyPath:@"_placeholderLabel.textColor"];
    [_tfPassWord setValue:kFontSize(15) forKeyPath:@"_placeholderLabel.font"];
    _tfPassWord.font = kFontSize(15);
    _tfPassWord.keyboardType = UIKeyboardTypePhonePad;
    _tfPassWord.textAlignment = NSTextAlignmentLeft;
    [_tfPassWord addTarget:self action:@selector(textFieldValueChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:_tfPassWord];
    [_tfPassWord mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(vLineSecurityCode.mas_bottom).offset(20);
        make.left.mas_equalTo(30);
        make.right.mas_equalTo(-30);
        make.height.mas_equalTo(31);
    }];
    
    UIView *vLinePassWord = [[UIView alloc]init];
    vLinePassWord.backgroundColor = kACColorRGB(242, 242, 242);
    [self.view addSubview:vLinePassWord];
    [vLinePassWord mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.tfPassWord.mas_bottom).offset(3);
        make.left.mas_equalTo(30);
        make.right.mas_equalTo(-30);
        make.height.mas_equalTo(1);
    }];
    
    _tfInvitationCode = [[UITextField alloc]init];
    _tfInvitationCode.clearButtonMode = UITextFieldViewModeWhileEditing;
    _tfInvitationCode.textColor = kACColorBlackTypeface;
    _tfInvitationCode.borderStyle = UITextBorderStyleNone;
    _tfInvitationCode.placeholder = @"请输入邀请码（非必填）";
    [_tfInvitationCode setValue:kACColorRGB(102, 102, 102) forKeyPath:@"_placeholderLabel.textColor"];
    [_tfInvitationCode setValue:kFontSize(15) forKeyPath:@"_placeholderLabel.font"];
    _tfInvitationCode.font = kFontSize(15);
    _tfInvitationCode.keyboardType = UIKeyboardTypePhonePad;
    _tfInvitationCode.textAlignment = NSTextAlignmentLeft;
    [_tfInvitationCode addTarget:self action:@selector(textFieldValueChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:_tfInvitationCode];
    [_tfInvitationCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(vLinePassWord.mas_bottom).offset(20);
        make.left.mas_equalTo(30);
        make.right.mas_equalTo(-30);
        make.height.mas_equalTo(31);
    }];
    
    UIView *vInvitationCode = [[UIView alloc]init];
    vInvitationCode.backgroundColor = kACColorRGB(242, 242, 242);
    [self.view addSubview:vInvitationCode];
    [vInvitationCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.tfInvitationCode.mas_bottom).offset(3);
        make.left.mas_equalTo(30);
        make.right.mas_equalTo(-30);
        make.height.mas_equalTo(1);
    }];
    
    _btnRegister = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btnRegister addCornerRadiusWithRadius:4.0f];
    [_btnRegister setTitle:@"同意协议并注册" forState:UIControlStateNormal];
    [_btnRegister setTitleColor:kACColorRGB(102, 102, 102) forState:UIControlStateDisabled];
    [_btnRegister setTitleColor:kACColorWhite forState:UIControlStateNormal];
    _btnRegister.titleLabel.font = kFontSize(15);
    _btnRegister.enabled = NO;
    [_btnRegister ak_setImageBackgroundColor:kACColorRGBA(228, 228, 228, 1) forStatus:UIControlStateDisabled];
    [_btnRegister ak_setImageBackgroundColor:kACColorBlue_R20_G138_B236_A1 forStatus:UIControlStateNormal];
    [_btnRegister ak_setImageBackgroundColor:kACColorBlue_R20_G138_B236_A1 forStatus:UIControlStateHighlighted];
    [self.view addSubview:_btnRegister];
    [_btnRegister addTarget:self action:@selector(onRegister) forControlEvents:UIControlEventTouchUpInside];
    [_btnRegister mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(vInvitationCode.mas_bottom).offset(35);
        make.left.mas_equalTo(30);
        make.right.mas_equalTo(-30);
        make.height.mas_equalTo(50);
    }];
    
    _btnSelectedAgreement = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btnSelectedAgreement setImage:[UIImage imageNamed:@"注册_未选中"] forState:UIControlStateNormal];
    [_btnSelectedAgreement setImage:[UIImage imageNamed:@"注册_选中"] forState:UIControlStateSelected];
    [self.view addSubview:_btnSelectedAgreement];
    [_btnSelectedAgreement addTarget:self action:@selector(onClickSelectedAgreement:) forControlEvents:UIControlEventTouchUpInside];
    [_btnSelectedAgreement mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.btnRegister.mas_bottom).offset(34);
        make.left.mas_equalTo(30);
        make.size.mas_equalTo(CGSizeMake(13, 13));
    }];
    
    UILabel *laTitlefisrt = [[UILabel alloc]init];
    laTitlefisrt.text = @"已阅读并同意";
    laTitlefisrt.textColor = kACColorBlackTypeface;
    laTitlefisrt.font = kFontSize(12);
    [self.view addSubview:laTitlefisrt];
    [laTitlefisrt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.btnSelectedAgreement);
        make.left.equalTo(self.btnSelectedAgreement.mas_right).offset(4);
    }];

    _btnUserAgreement = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btnUserAgreement setTitle:@"《用户使用协议》" forState:UIControlStateNormal];
    [_btnUserAgreement.titleLabel setFont:kFontSize(12)];
    [_btnUserAgreement setTitleColor:kACColorRGB(20, 138, 236) forState:UIControlStateNormal];
    [_btnUserAgreement addTarget:self action:@selector(onClickAgreement) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnUserAgreement];

    CGFloat btnAgreementW = [SSJewelryCore sizeOfString:_btnUserAgreement.titleLabel.text fittingSize:CGSizeMake(CGFLOAT_MAX, _btnUserAgreement.titleLabel.font.lineHeight) font:_btnUserAgreement.titleLabel.font].width;

    [_btnUserAgreement mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(laTitlefisrt.mas_right);
        make.width.mas_equalTo(btnAgreementW);
        make.top.equalTo(laTitlefisrt.mas_top);
        make.bottom.equalTo(laTitlefisrt.mas_bottom);
    }];

    UILabel *laTitleLast = [[UILabel alloc]init];
    laTitleLast.text = @"及";
    laTitleLast.textColor = kACColorBlackTypeface;
    laTitleLast.font = kFontSize(12);
    [self.view addSubview:laTitleLast];
    [laTitleLast mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.btnUserAgreement);
        make.left.equalTo(self.btnUserAgreement.mas_right).offset(2);
    }];

    _btnAgreement = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btnAgreement setTitle:@"《隐私政策》" forState:UIControlStateNormal];
    [_btnAgreement.titleLabel setFont:kFontSize(12)];
    [_btnAgreement setTitleColor:kACColorRGB(20, 138, 236) forState:UIControlStateNormal];
    [_btnAgreement addTarget:self action:@selector(onClickAgreement) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnAgreement];
    CGFloat btnAgreementsW = [SSJewelryCore sizeOfString:_btnAgreement.titleLabel.text fittingSize:CGSizeMake(CGFLOAT_MAX, _btnAgreement.titleLabel.font.lineHeight) font:_btnAgreement.titleLabel.font].width;
    [_btnAgreement mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(laTitleLast.mas_right);
        make.width.mas_equalTo(btnAgreementsW);
        make.top.equalTo(laTitleLast.mas_top);
        make.bottom.equalTo(laTitleLast.mas_bottom);
    }];

    UILabel *laTitleDetails = [[UILabel alloc]init];
    laTitleDetails.numberOfLines = 0;
    laTitleDetails.text = @"如果您是企业员工，注册成功后，可在个人信息中，认证您的企业信息，完成企业认证。";
    laTitleDetails.textColor = kACColorRGB(102, 102, 102);
    laTitleDetails.font = kFontSize(12);
    [self.view addSubview:laTitleDetails];
    [laTitleDetails mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.btnAgreement.mas_bottom).offset(10);
        make.centerX.equalTo(self.view);
        make.left.mas_equalTo(30);
        make.right.mas_equalTo(-30);
    }];
}

#pragma mark - 返回按钮
- (void)onClickLeftBack {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 同意协议
- (void)onClickSelectedAgreement:(UIButton *)sender {
    sender.selected = !sender.selected;
//    sender.selected = YES;
//    if (sender.selected == YES) {
//        sender.selected = NO;
//    }else{
//        sender.selected = YES;
//    }
    [self textFieldValueChanged:_tfPassWord];
}

#pragma 手机号和验证码输入框改变时调用
- (void)textFieldValueChanged:(UITextField *)textField {
    
    if (textField.tag == kPhoneTextFieldTag) {
        if (textField.text.length < 11) {
            _btnSecurityCode.enabled = NO;
        } else {
            //判断手机号大于11位就截取11位
            if (textField.text.length > 11) {
                textField.text = [textField.text substringToIndex:11];
            }
            //判断用户输入的是否是手机号
            BOOL isValidateMobile = [SSJewelryCore isValidateMobile:textField.text];
            //错误提示lable高度
            CGFloat labPhoneErrorMessageHeight = isValidateMobile ? 0.f : 20;
            [_labPhoneErrorMessage mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(labPhoneErrorMessageHeight);
            }];
            _btnSecurityCode.enabled = isValidateMobile;
        }
    }
    
    _btnRegister.enabled = (_tfUserName.text &&
                            _tfUserName.text.length &&
                            [SSJewelryCore isValidateMobile:_tfUserName.text] &&
                            _tfPassWord.text &&
                            _tfPassWord.text.length &&
                            _btnSelectedAgreement.selected == YES);
    
}

-(void)sendcode
{
    NSDictionary *params = @{
                             @"mobile" : _tfUserName.text,
                             @"type": @(4)
                             };
    [HttpTool get:[NSString stringWithFormat:@"user/sendCode"] params:params success:^(id responseObj) {
        NSLog(@"");
        [MBProgressHUD showMBProgressHud:self.view withText:@"发送验证码成功!" withTime:1];
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}
#pragma mark - 注册
- (void)onRegister {
//    NSMutableDictionary* dic=[NSMutableDictionary new];
        NSDictionary *params = @{
                                 @"mobile" : _tfUserName.text,
                                 @"password": _tfPassWord.text,
                                 @"code": _tfSecurityCode.text
                                 };
    [HttpTool get:[NSString stringWithFormat:@"user/register"] params:params success:^(id responseObj) {
        NSLog(@"");
        if ([responseObj[@"msg"] isEqualToString:@"请求成功"]) {
            [self.navigationController popViewControllerAnimated:YES];
        }
        else
        {
            [MBProgressHUD showMBProgressHud:self.view withText:@"注册失败" withTime:1.0];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}


@end
