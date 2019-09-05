//
//  ETLoginViewController.m
//  EasyTurn
//
//  Created by 程立 on 2019/7/18.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import "ETLoginViewController.h"
#import "ETRegisterViewController.h"
#import "UIButton+AHKit.h"
#import "WXApi.h"
#import "ETHomeViewController.h"
#import "MainViewController.h"
#import "ETBphoneViewController.h"
static NSInteger  kPhoneTextFieldTag = 5678;
static NSInteger  kQQThirdLoginTag = 1000;
static NSInteger  kWeixinThirdLoginTag = 1001;
static NSInteger  kWeiboThirdLoginTag = 1002;

typedef NS_ENUM(NSUInteger, ETLoginViewControllerType) {
    ///验证码登录
    ETLoginViewControllerTypeNOPassword,
    ///用户密码登录
    ETLoginViewControllerTypePassword
};

@interface ETLoginViewController ()<UITextFieldDelegate,WXApiDelegate>
@property (nonatomic, strong) UIImageView *imagevLogo;
@property (nonatomic, strong) UITextField *tfUserName;
@property (nonatomic, strong) UITextField *tfPassWord;
@property (nonatomic, strong) UIButton *btnForgetPassword;
@property (nonatomic, strong) UIButton *btnSecurityCode;
@property (nonatomic, strong) UIButton *btnLogin;
@property (nonatomic, strong) UIButton *btnSecurityCodeLogin;
@property (nonatomic, strong) UIButton *btnRegister;
//@property (nonatomic, strong) UILabel *laThirdParty;
//@property (nonatomic, strong) UIButton *btnWechat;
@property (nonatomic, strong) UILabel *labPhoneErrorMessage;
@property (nonatomic, assign) ETLoginViewControllerType pageType;

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, assign) int messageVerify;

@end

@implementation ETLoginViewController

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden=YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    if ([url.host isEqualToString:@"oauth"]){//微信登录
        return [WXApi handleOpenURL:url delegate:self];
    }
    return YES;
    //if ([url.host isEqualToString:@"safepay"]) {}//支付宝用这个
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _pageType = ETLoginViewControllerTypePassword;
    _pageType = ETLoginViewControllerTypeNOPassword;

    [self createSubViewsAndConstraints];
    _messageVerify=1;
}

#pragma mark - Create Subviews
- (void)createSubViewsAndConstraints {
  
    _imagevLogo = [[UIImageView alloc]init];
    _imagevLogo.image = [UIImage imageNamed:@"登录_logo"];
    [self.view addSubview:_imagevLogo];
    [_imagevLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(Screen_Height *(47 / 667.0));
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(87, 34));
    }];
    
    _tfUserName = [[UITextField alloc]init];
    _tfUserName.tag = kPhoneTextFieldTag;
    _tfUserName.textColor = kACColorBlackTypeface;
    _tfUserName.borderStyle = UITextBorderStyleNone;
    _tfUserName.clearButtonMode = UITextFieldViewModeWhileEditing;
    _tfUserName.placeholder = @"请输入手机号";
    [_tfUserName setValue:kACColorRGB(102, 102, 102) forKeyPath:@"_placeholderLabel.textColor"];
    [_tfUserName setValue:kFontSize(15) forKeyPath:@"_placeholderLabel.font"];
    _tfUserName.font = kFontSize(15);
    _tfUserName.keyboardType = UIKeyboardTypePhonePad;
    _tfUserName.textAlignment = NSTextAlignmentLeft;
    [_tfUserName addTarget:self action:@selector(textFieldValueChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:_tfUserName];
    [_tfUserName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imagevLogo.mas_bottom).offset(99);
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
    
    _tfPassWord = [[UITextField alloc]init];
    _tfPassWord.textColor = kACColorBlackTypeface;
    _tfPassWord.borderStyle = UITextBorderStyleNone;
    _tfPassWord.clearButtonMode = UITextFieldViewModeWhileEditing;
    _tfPassWord.placeholder = @"请输入密码";
    _tfPassWord.secureTextEntry=YES;
    [_tfPassWord setValue:kACColorRGB(102, 102, 102) forKeyPath:@"_placeholderLabel.textColor"];
    [_tfPassWord setValue:kFontSize(15) forKeyPath:@"_placeholderLabel.font"];
    _tfPassWord.font = kFontSize(15);
    _tfPassWord.keyboardType = UIKeyboardTypePhonePad;
    _tfPassWord.textAlignment = NSTextAlignmentLeft;
    _tfPassWord.secureTextEntry=YES;
    [_tfPassWord addTarget:self action:@selector(textFieldValueChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:_tfPassWord];
    [_tfPassWord mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labPhoneErrorMessage.mas_bottom).offset(20);
        make.left.mas_equalTo(30);
        make.right.mas_equalTo(-130);
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
    
    _btnForgetPassword = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btnForgetPassword setTitle:@"忘记密码" forState:UIControlStateNormal];
    [_btnForgetPassword setTitleColor:kACColorRGB(20, 138, 236) forState:UIControlStateNormal];
    _btnForgetPassword.titleLabel.font = kFontSize(12);
    [_btnForgetPassword addTarget:self action:@selector(forget) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnForgetPassword];
    [_btnForgetPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.tfPassWord);
        make.right.mas_equalTo(-30);
    }];
    
    _btnSecurityCode = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnSecurityCode.hidden = YES;
    [_btnSecurityCode setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_btnSecurityCode addTarget:self action:@selector(sendcode) forControlEvents:UIControlEventTouchUpInside];
    [_btnSecurityCode setTitleColor:kACColorRGB(20, 138, 236) forState:UIControlStateNormal];
    _btnSecurityCode.titleLabel.font = kFontSize(12);
    [self.view addSubview:_btnSecurityCode];
    [_btnSecurityCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.tfUserName);
        make.right.mas_equalTo(-30);
    }];
    

    _btnLogin = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnLogin.enabled = NO;
    [_btnLogin ak_setImageBackgroundColor:kACColorRGBA(228, 228, 228, 1) forStatus:UIControlStateDisabled];
    [_btnLogin ak_setImageBackgroundColor:kACColorBlue_R20_G138_B236_A1 forStatus:UIControlStateNormal];
    [_btnLogin ak_setImageBackgroundColor:kACColorBlue_R20_G138_B236_A1 forStatus:UIControlStateHighlighted];
    [_btnLogin addCornerRadiusWithRadius:4.0f];
    [_btnLogin setTitle:@"登录" forState:UIControlStateNormal];
    [_btnLogin setTitleColor:kACColorRGB(102, 102, 102) forState:UIControlStateDisabled];
    [_btnLogin setTitleColor:kACColorWhite forState:UIControlStateNormal];
    _btnLogin.titleLabel.font = kFontSize(15);
    [self.view addSubview:_btnLogin];
    [_btnLogin addTarget:self action:@selector(onCLickLogin) forControlEvents:UIControlEventTouchUpInside];
    [_btnLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(vLinePassWord.mas_bottom).offset(36);
        make.left.mas_equalTo(30);
        make.right.mas_equalTo(-30);
        make.height.mas_equalTo(50);
    }];
    
    _btnSecurityCodeLogin = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btnSecurityCodeLogin setTitle:@"短信验证码登录" forState:UIControlStateNormal];
    [_btnSecurityCodeLogin setTitleColor:kACColorBlackTypeface forState:UIControlStateNormal];
    _btnSecurityCodeLogin.titleLabel.font = kFontSize(15);
    [self.view addSubview:_btnSecurityCodeLogin];
    [_btnSecurityCodeLogin addTarget:self action:@selector(onCLickPushLogin) forControlEvents:UIControlEventTouchUpInside];
    [_btnSecurityCodeLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.btnLogin.mas_bottom).offset(30);
        make.left.mas_equalTo(30);
    }];
    
    _btnRegister = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btnRegister setTitle:@"注册" forState:UIControlStateNormal];
    [_btnRegister setTitleColor:kACColorBlackTypeface forState:UIControlStateNormal];
    _btnRegister.titleLabel.font = kFontSize(15);
    [self.view addSubview:_btnRegister];
    [_btnRegister addTarget:self action:@selector(onCLickPushRegister) forControlEvents:UIControlEventTouchUpInside];
    [_btnRegister mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.btnLogin.mas_bottom).offset(30);
        make.right.mas_equalTo(-29);
    }];
    
    _laThirdParty = [[UILabel alloc]init];
    _laThirdParty.text = @"第三方登录";
    _laThirdParty.textColor = kACColorRGB(102, 102, 102);
    _laThirdParty.font = kFontSize(12);
    [self.view addSubview:_laThirdParty];
    [_laThirdParty mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.btnLogin.mas_bottom).offset(98);
        make.height.mas_equalTo(12);
    }];
    
    _btnWechat = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btnWechat setImage:[UIImage imageNamed:@"登录_微信"] forState:UIControlStateNormal];
    [self.view addSubview:_btnWechat];
    [_btnWechat mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.laThirdParty.mas_bottom).offset(13);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    [_btnWechat addTarget:self action:@selector(weChat) forControlEvents:UIControlEventTouchUpInside];
    if ([MySingleton sharedMySingleton].review==0) {
        _laThirdParty.hidden=NO;
        _btnWechat.hidden=NO;
    }
    else{
    _laThirdParty.hidden=YES;
    _btnWechat.hidden=YES;
    }
}

-(void)sendcode
{
    NSDictionary *params = @{
                             @"mobile" : _tfUserName.text,
                             @"code": _tfPassWord.text,
                             @"type": @(1)
                             };
    [HttpTool get:[NSString stringWithFormat:@"user/sendCode"] params:params success:^(id responseObj) {
        NSLog(@"");
        [MBProgressHUD showMBProgressHud:self.view withText:@"发送验证码成功!" withTime:1];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}
-(void)forget
{
    ETBphoneViewController *bphone=[[ETBphoneViewController alloc]init];
    bphone.fromForget=YES;
    [self.navigationController pushViewController:bphone animated:YES];
    
}
- (void)weChat {
    [self.view removeFromSuperview];
        SendAuthReq *req = [[SendAuthReq alloc] init];
    
        req.state = @"wx_oauth_authorization_state";//用于保持请求和回调的状态，授权请求或原样带回
        req.scope = @"snsapi_userinfo";//授权作用域：获取用户个人信息
        //唤起微信
        [WXApi sendReq:req];
        return;
}
- (void)onCLickPushRegister {
    ETRegisterViewController *vc = [[ETRegisterViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 切换登录方式
- (void)onCLickPushLogin {
    _messageVerify=2;
    if(_pageType == ETLoginViewControllerTypeNOPassword) {
        _pageType = ETLoginViewControllerTypeNOPassword;
        _tfPassWord.placeholder = @"请输入短信验证码";
        _tfPassWord.keyboardType = UIKeyboardTypePhonePad;
        _tfPassWord.secureTextEntry = NO;
        _tfPassWord.text = nil;
        _btnSecurityCode.hidden = NO;
        _btnForgetPassword.hidden = YES;
        
    }else if (_pageType == ETLoginViewControllerTypePassword){
        _pageType = ETLoginViewControllerTypePassword;
        _tfPassWord.placeholder = @"请输入密码";
        _tfPassWord.secureTextEntry=YES;
        _tfPassWord.keyboardType = UIKeyboardTypePhonePad;
        _tfPassWord.secureTextEntry = NO;
        _tfPassWord.text = nil;
        _btnSecurityCode.hidden = YES;
        _btnForgetPassword.hidden = NO;
    }
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
    
    _btnLogin.enabled = (_tfUserName.text &&
                         _tfUserName.text.length &&
                         [SSJewelryCore isValidateMobile:_tfUserName.text] &&
                         _tfPassWord.text &&
                         _tfPassWord.text.length);
    
}

#pragma mark - 登录
- (void)onCLickLogin {
    if (![SSJewelryCore isValidClick]) {
       
        return;
    }
    if(_pageType == ETLoginViewControllerTypeNOPassword) {
        [self requestLoginDataWithPhoneNum:_tfUserName.text WithSecurityCode:_tfPassWord.text WithType:1];
        
    }else if (_pageType == ETLoginViewControllerTypePassword){
        [self requestLoginDataWithPhoneNum:_tfUserName.text WithSecurityCode:_tfPassWord.text WithType:2];
      
    }
}

#pragma mark - 请求网络登录
- (void)requestLoginDataWithPhoneNum:(NSString *)phoneNum WithSecurityCode:(NSString *)code WithType:(NSInteger )type {
    [[ACToastView toastView]showLoadingCircleViewWithStatus:@"正在加载中"];

    
    NSDictionary *params = @{
                             @"mobile" : _tfUserName.text,
                             @"code": _tfPassWord.text,
                             @"type": @(_messageVerify)
                             };
    [HttpTool get:[NSString stringWithFormat:@"user/login"] params:params success:^(id responseObj) {
        [[ACToastView toastView]hide];
        if ([responseObj[@"msg"] isEqualToString:@"用户名或密码不正确"]) {
            [MBProgressHUD showMBProgressHud:self.view withText:@"账号或密码不正确" withTime:1];
            return;
        }
        if ([responseObj[@"msg"] isEqualToString:@"验证码不正确"]) {
            [MBProgressHUD showMBProgressHud:self.view withText:@"验证码不正确" withTime:1];
            return;
        }
        NSLog(@"");
        [MySingleton sharedMySingleton].token=responseObj[@"data"][@"token"];
        NSUserDefaults* user=[NSUserDefaults standardUserDefaults];
        NSDictionary* a=responseObj[@"data"];
        
        [user setObject:[a objectForKey:@"token"] forKey:@"token"];
        [user setObject:[a objectForKey:@"uid"] forKey:@"uid"];
        [user synchronize];
        [self.window.rootViewController removeFromParentViewController];
        MainViewController * mainvc = [[MainViewController alloc]init];
        SSNavigationController * naviRoot = [[SSNavigationController alloc] initWithRootViewController:mainvc];
        naviRoot.navigationBarHidden = NO;
        self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen]bounds]];
        [self.window setRootViewController:naviRoot];
        [self.window setBackgroundColor:kACColorWhite];
        [self.window makeKeyAndVisible];
        [self huanxin];
        EaseUserModel* model=[EaseUserModel new];
        model.nickname=[a objectForKey:@"name"];
        model.avatarURLPath=[a objectForKey:@"portrait"];
        model.buddy=[a objectForKey:@"uid"];
        [model bg_saveOrUpdate];
        [self PostuserinfoUI];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

-(void)huanxin
{
    NSDictionary *params = @{
                             };
    [HttpTool get:[NSString stringWithFormat:@"user/getJimUser"] params:params success:^(id responseObj) {
        NSLog(@"");
        NSUserDefaults* user=[NSUserDefaults standardUserDefaults];
        NSDictionary* a=responseObj[@"data"];
        [user setObject:[a objectForKey:@"auroraName"] forKey:@"huanxin"];
        [user synchronize];
        [[EMClient sharedClient] loginWithUsername:[a objectForKey:@"auroraName"]
                                          password:[a objectForKey:@"password"]
                                        completion:^(NSString *aUsername, EMError *aError) {
                                            if (!aError) {
                                                NSLog(@"登录成功");
                                            } else {
                                                NSLog(@"登录失败");
                                            }
                                        }];
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
- (void)PostuserinfoUI {
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
        [UserInfoModel saveUserInfoModel:info];

        NSLog(@"");
        //        [_tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
@end
