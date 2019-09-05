//
//  ETWxPhoneViewController.m
//  EasyTurn
//
//  Created by 程立 on 2019/8/13.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import "ETWxPhoneViewController.h"
#import "UIButton+AHKit.h"
#import "ETRegisterViewController.h"
#import "UIButton+AHKit.h"
#import "WXApi.h"
#import "ETHomeViewController.h"
#import "MainViewController.h"
#import "ETPassWordViewController.h"

static NSInteger  kPhoneTextFieldTag = 5678;
typedef NS_ENUM(NSUInteger, ETLoginViewControllerType) {
    ///验证码登录
    ETLoginViewControllerTypeNOPassword,
};
@interface ETWxPhoneViewController ()
@property (strong, nonatomic) UIWindow *window;
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
@property (nonatomic, assign) ETLoginViewControllerType pageType;
@end

@implementation ETWxPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=YES;
    [self createSubViewsAndConstraints];
    // Do any additional setup after loading the view.
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
    _tfUserName.placeholder = @"绑定手机号";
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
        make.top.equalTo(vLineSecurityCode.mas_bottom).offset(20);
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
        make.top.equalTo(vInvitationCode.mas_bottom).offset(20);
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
    
    _btnRegister = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btnRegister addCornerRadiusWithRadius:4.0f];
    [_btnRegister setTitle:@"绑定并登陆" forState:UIControlStateNormal];
    [_btnRegister setTitleColor:kACColorRGB(102, 102, 102) forState:UIControlStateDisabled];
    [_btnRegister setTitleColor:kACColorWhite forState:UIControlStateNormal];
    _btnRegister.titleLabel.font = kFontSize(15);
    _btnRegister.enabled = NO;
    [_btnRegister ak_setImageBackgroundColor:kACColorRGBA(228, 228, 228, 1) forStatus:UIControlStateDisabled];
    [_btnRegister ak_setImageBackgroundColor:kACColorBlue_R20_G138_B236_A1 forStatus:UIControlStateNormal];
    [_btnRegister ak_setImageBackgroundColor:kACColorBlue_R20_G138_B236_A1 forStatus:UIControlStateHighlighted];
    [self.view addSubview:_btnRegister];

        [_btnRegister addTarget:self action:@selector(onRegister) forControlEvents:UIControlEventTouchUpInside];
        _btnRegister.enabled=YES;
    [_btnRegister mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(vLinePassWord.mas_bottom).offset(35);
        make.left.mas_equalTo(30);
        make.right.mas_equalTo(-30);
        make.height.mas_equalTo(50);
    }];
    

}

-(void)onforget
{
    ETPassWordViewController* pass=[ETPassWordViewController new];
    [self.navigationController pushViewController:pass animated:YES];
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
                            [SSJewelryCore isValidateMobile:_tfUserName.text]&&_tfPassWord);
    
}

-(void)sendcode
{
    NSDictionary *params = @{
                             @"mobile" : _tfUserName.text,
                             @"type": @1
                             };
    [HttpTool get:[NSString stringWithFormat:@"user/sendCode"] params:params success:^(id responseObj) {
        NSLog(@"");
        [MBProgressHUD showMBProgressHud:self.view withText:@"发送验证码成功!" withTime:1];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}
#pragma mark - 绑定
- (void)onRegister {
    if(_pageType == ETLoginViewControllerTypeNOPassword) {
        [self requestLoginDataWithPhoneNum:_tfUserName.text WithSecurityCode:_tfSecurityCode.text WithType:2];
        
    }
    //    NSMutableDictionary* dic=[NSMutableDictionary new];
//    NSDictionary *params = @{
//                             @"mobile" : _tfUserName.text,
//                             @"code": _tfSecurityCode.text,
//                             @"yqm":_tfInvitationCode.text
//                             };
//    [HttpTool get:[NSString stringWithFormat:@"user/wxAddMobile"] params:params success:^(id responseObj) {
//        NSLog(@"");
//        if (![SSJewelryCore isValidClick]) {
//            return;
//        }
//        
//        return;
//        
//    } failure:^(NSError *error) {
//        NSLog(@"%@",error);
//    }];
}
#pragma mark - 请求网络登录
- (void)requestLoginDataWithPhoneNum:(NSString *)phoneNum WithSecurityCode:(NSString *)code WithType:(NSInteger )type {
    [[ACToastView toastView]showLoadingCircleViewWithStatus:@"正在加载中"];

    NSUserDefaults* user=[NSUserDefaults standardUserDefaults];
    NSString* a=[user objectForKey:@"openid"];
    NSDictionary *params = @{
                             @"mobile" : _tfUserName.text,
                             @"yzCode": _tfSecurityCode.text,
                             @"yqm":_tfInvitationCode.text,
                             @"code":a,
                             @"password":_tfPassWord.text
                             };
    [HttpTool get:[NSString stringWithFormat:@"user/wxAddMobile"] params:params success:^(id responseObj) {
        NSLog(@"");
        [[ACToastView toastView]hide];
//        NSUserDefaults* user=[NSUserDefaults standardUserDefaults];
        NSDictionary* a=responseObj[@"data"];
//                [user setObject:[a objectForKey:@"token"] forKey:@"token"];
//                [user setObject:[a objectForKey:@"uid"] forKey:@"uid"];
//        [user synchronize];
        if (self.block) {
            self.block();
            return;
        }
        [self.window.rootViewController removeFromParentViewController];
        MainViewController * mainvc = [[MainViewController alloc]init];
        SSNavigationController * naviRoot = [[SSNavigationController alloc] initWithRootViewController:mainvc];
        naviRoot.navigationBarHidden = NO;
        self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen]bounds]];
        [self.window setRootViewController:naviRoot];
        [self.window setBackgroundColor:kACColorWhite];
        [self.window makeKeyAndVisible];
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}


@end
