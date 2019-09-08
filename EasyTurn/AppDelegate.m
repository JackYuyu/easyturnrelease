//
//  AppDelegate.m
//  EasyTurn
//
//  Created by 程立 on 2019/7/18.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import "AppDelegate.h"
#import "ETBphoneViewController.h"
#import "MainViewController.h"
#import "ETLoginViewController.h"
#import "WXApi.h"
#import <AlipaySDK/AlipaySDK.h>
#import "JPUSHService.h"
#import <AdSupport/AdSupport.h>
#import <JJException.h>
#import "ETWxPhoneViewController.h"
#import "MsgInfo.h"
#import "SSPayUtils.h"
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
@interface AppDelegate ()<WXApiDelegate,JPUSHRegisterDelegate>
//@property (nonatomic,assign) int review;
@property (nonatomic,strong) ETLoginViewController * loginVC;
@property (nonatomic,strong) NSString* openid;
@property (nonatomic,strong) NSString* nickname;
@property (nonatomic,strong) NSString* head;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [JJException configExceptionCategory:JJExceptionGuardAll];
//        [JJException startGuardException];
    [self review];
    //[[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    [WXApi registerApp:@"wx6aa68fa297ad59ee"];
    
    EMOptions *options = [EMOptions optionsWithAppkey:@"1196190727046562#yzvip"];
    options.apnsCertName = @"yzqylzpt";
    [[EMClient sharedClient] initializeSDKWithOptions:options];
//    [self huanxin];
    [self configJpush:launchOptions];

    //设置根控制器
    [self appConfigProvider];
    //统一设置导航栏
    [self setUpNavigationBar];
    //启动页延时
    [NSThread sleepForTimeInterval:2];
    if ([SSCacheManager isInstallorUpdate]) {
        //新安装用户
        [self loginViewController];

    }else{
        UserInfoModel *userInfoModel = [UserInfoModel loadUserInfoModel];
        if (userInfoModel.token) {
            //跳转首页
            [self mainViewController];
            [self huanxin:application];
        }else{
            //跳转登录页面
            NSUserDefaults* user=[NSUserDefaults standardUserDefaults];
            NSString* token=[user objectForKey:@"token"];
            if (!token) {
                [self loginViewController];
            }else
            {
                [self mainViewController];
                [self huanxin:application];
            }
        }
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccessNotification) name:LOGINSELECTCENTERINDEX object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginOutNotification) name:LOGINOFFSELECTCENTERINDEX object:nil];
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    
//    if (version >= 8.0) {
//        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
//        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
//        [application registerForRemoteNotifications];
//    }
    
    
    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options {
    //调用第三方支付后,保存支付状态值
    [SSPayUtils shareUser].State = @"end";
    //支付宝钱包快登授权返回 authCode
    if ([url.host isEqualToString:@"safepay"]) {
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url
                                                  standbyCallback:^(NSDictionary *resultDic){
                                                      AMLog(@"result = %@",resultDic);
          //跳转支付宝钱包进行支付，处理支付结果
          [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
              AMLog(@"result = %@",resultDic);
              [[ACToastView toastView:YES]showLoadingCircleViewWithStatus:@"正在支付中"];
              dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                  [[NSNotificationCenter defaultCenter]postNotificationName:Request_PayResult object:nil];
              });
              
              if ([resultDic[@"resultStatus"] isEqualToString:@"9000"]) {
                  
                  
              }else if ([resultDic[@"resultStatus"] isEqualToString:@"8000"]) {
                  AMLog(@"正在处理中");
                  
              } else if ([resultDic[@"resultStatus"] isEqualToString:@"6001"]) {
                  AMLog(@"用户中途取消支付");
                  
              } else if ([resultDic[@"resultStatus"] isEqualToString:@"6002"]) {
                  AMLog(@"网络故障支付失败");
                  
              } else if ([resultDic[@"resultStatus"] isEqualToString:@"4000"]) {
                  AMLog(@"支付失败");
                  
              }
              
          }];
      }];
    return YES;
        //支付宝钱包快登授权返回 authCode
    }else if ([url.host isEqualToString:@"platformapi"]){
        [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
            
        }];
        return YES;
        //微信支付回调
    }else if ([url.host isEqualToString:@"pay"]) {
        
        return [WXApi handleOpenURL:url delegate:self];
        
    }else if ([options[UIApplicationOpenURLOptionsSourceApplicationKey] isEqualToString:@"com.tencent.xin"] && [url.absoluteString containsString:@"pay"]) {
        
        return [WXApi handleOpenURL:url delegate:self];
        
    }else if ([url.scheme isEqualToString:@"wx6aa68fa297ad59ee"])
    {
        return  [WXApi handleOpenURL:url delegate:(id<WXApiDelegate>)self];
    }
    
    return YES;
}

#pragma mark - 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    //调用第三方支付后,保存支付状态值
    [SSPayUtils shareUser].State = @"end";
    if ([url.host isEqualToString:@"safepay"]) {
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url
                                                  standbyCallback:^(NSDictionary *resultDic){
                                                      AMLog(@"result = %@",resultDic);
                                                      //跳转支付宝钱包进行支付，处理支付结果
                                                      [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
                                                          AMLog(@"result = %@",resultDic);
                                                          [[ACToastView toastView:YES]showLoading:@"正在支付中" cancel:nil];
                                                          dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                                              //                                                              [[ACToastView toastView]hide];
                                                              [[NSNotificationCenter defaultCenter]postNotificationName:Request_PayResult object:nil];
                                                          });
                                                          
                                                          if ([resultDic[@"resultStatus"] isEqualToString:@"9000"]) {
                                                              
                                                              
                                                          }else if ([resultDic[@"resultStatus"] isEqualToString:@"8000"]) {
                                                              AMLog(@"正在处理中");
                                                              
                                                          } else if ([resultDic[@"resultStatus"] isEqualToString:@"6001"]) {
                                                              AMLog(@"用户中途取消支付");
                                                              
                                                          } else if ([resultDic[@"resultStatus"] isEqualToString:@"6002"]) {
                                                              AMLog(@"网络故障支付失败");
                                                              
                                                          } else if ([resultDic[@"resultStatus"] isEqualToString:@"4000"]) {
                                                              AMLog(@"支付失败");
                                                              
                                                          }
                                                          
                                                      }];
                                                  }];
        return YES;
        //支付宝钱包快登授权返回 authCode
    }else if ([url.host isEqualToString:@"platformapi"]){
        [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
            AMLog(@"result = %@",resultDic);
            //            [[WTPayManager shareWTPayManager] handleAlipayResponse:resultDic];
        }];
        return YES;
    }else if ([sourceApplication isEqualToString:@"com.tencent.xin"] && [url.absoluteString containsString:@"pay"]){
        
        return [WXApi handleOpenURL:url delegate:self];
        //微信支付回调
    }else if ([url.host isEqualToString:@"pay"]) {
        
        return [WXApi handleOpenURL:url delegate:self];
        
    }
    return YES;
}


-(void)huanxin:(UIApplication*)application {
    NSDictionary *params = @{
                             };
    [HttpTool get:[NSString stringWithFormat:@"user/getJimUser"] params:params success:^(id responseObj) {
        if ([responseObj[@"data"] isKindOfClass:[NSNull class]]) {
            return;
        }
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
                                                
                                                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                                                    dispatch_async(dispatch_get_main_queue(), ^{
                                                        [[EMClient sharedClient].chatManager loadAllConversationsFromDB];
                                                        
                                                    });
                                                    });
                                                //iOS8 注册APNS
                                                if ([application respondsToSelector:@selector(registerForRemoteNotifications)]) {
                                                    [application registerForRemoteNotifications];
                                                    UIUserNotificationType notificationTypes = UIUserNotificationTypeBadge |
                                                    UIUserNotificationTypeSound |
                                                    UIUserNotificationTypeAlert;
                                                    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:notificationTypes categories:nil];
                                                    [application registerUserNotificationSettings:settings];
                                                }
                                                else{
                                                    UIRemoteNotificationType notificationTypes = UIRemoteNotificationTypeBadge |
                                                    UIRemoteNotificationTypeSound |
                                                    UIRemoteNotificationTypeAlert;
                                                    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:notificationTypes];
                                                }
                                            } else {
                                                NSLog(@"登录失败");
                                            }
                                        }];
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
-(void)review
{
    NSDictionary *params = @{
                             };
    [HttpTool get:[NSString stringWithFormat:@"buy/getWxIsOpen"] params:params success:^(id responseObj) {
        _review=[responseObj[@"data"] intValue];
        _review=0;
        [MySingleton sharedMySingleton].review=_review;
        if (_review!=1) {
            _loginVC.laThirdParty.hidden=NO;
            _loginVC.btnWechat.hidden=NO;
        }
//        if ([SSCacheManager isInstallorUpdate]) {
//            //新安装用户
//            [self loginViewController];
//
//        }else{
//            UserInfoModel *userInfoModel = [UserInfoModel loadUserInfoModel];
//            if (userInfoModel.token) {
//                //跳转首页
//                [self mainViewController];
//                [self huanxin];
//            }else{
//                //跳转登录页面
//                NSUserDefaults* user=[NSUserDefaults standardUserDefaults];
//                NSString* token=[user objectForKey:@"token"];
//                if (!token) {
//                    [self loginViewController];
//                }else
//                {
//                    [self mainViewController];
//                    [self huanxin];
//                }
//            }
//        }
        NSLog(@"");
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

//微信回调代理
- (void)onResp:(BaseResp *)resp{

    // =============== 获得的微信登录授权回调 ============
    if ([resp isKindOfClass:[SendAuthResp class]])  {
        NSLog(@"******************获得的微信登录授权******************");

        SendAuthResp *aresp = (SendAuthResp *)resp;
        if (aresp.errCode != 0 ) {
            dispatch_async(dispatch_get_main_queue(), ^{
//                [self showError:@"微信授权失败"];
                NSLog(@"微信授权失败");
            });
            return;
        }
        //授权成功获取 OpenId
        //    授权成功获取 OpenId
        NSString *code = aresp.code;
        NSLog(@"%@",code);
//        [self getWeiXinOpenId:code];


        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        NSString *accessUrlStr = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=wx6aa68fa297ad59ee&secret=a297f2affb4467edc1984eead3c04c48&code=%@&grant_type=authorization_code", code];
        NSLog(@"===%@",accessUrlStr);

        // 设置请求格式
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        // 设置返回格式
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        // 返回数据解析类型
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html",@"text/plain" ,nil];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        manager.requestSerializer.timeoutInterval = 60;

        [manager GET:accessUrlStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {

        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            //数据解析
            NSMutableDictionary*resDict = (NSMutableDictionary *)[responseObject mj_JSONObject];
            NSLog(@"请求access的response = %@", resDict);
            NSDictionary *accessDict = [NSDictionary dictionaryWithDictionary:resDict];
            NSString *accessToken = [accessDict objectForKey:@"access_token"];
            NSString *openID = [accessDict objectForKey:@"openid"];
            NSString *refreshToken = [accessDict objectForKey:@"refresh_token"];
            // 本地持久化，以便access_token的使用、刷新或者持续
            if (accessToken && ![accessToken isEqualToString:@""] && openID && ![openID isEqualToString:@""]) {
                [[NSUserDefaults standardUserDefaults] setObject:accessToken forKey:@"access_token"];
                [[NSUserDefaults standardUserDefaults] setObject:openID forKey:@"openid"];
                [[NSUserDefaults standardUserDefaults] setObject:refreshToken forKey:@"refresh_token"];
                [[NSUserDefaults standardUserDefaults] synchronize]; // 命令直接同步到文件里，来避免数据的丢失
            }
            [self wechatLoginByRequestForUserInfo:code];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"获取access_token时出错 = %@", error);
        }];

    }

    //启动微信支付的response
    NSString *payResoult = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
    if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
//        [[ACToastView toastView:YES]showLoadingCircleViewWithStatus:@"正在支付中"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter]postNotificationName:Request_PayResult object:nil];
        });
        switch (resp.errCode) {
            case 0:
                payResoult = @"支付结果：成功！";
                AMLog(@"支付结果：成功！");
                break;
            case -1:
                payResoult = @"支付结果：失败！";
                AMLog(@"支付结果：失败！");
 
                break;
            case -2:
                payResoult = @"用户已经退出支付！";
                AMLog(@"支付结果：用户已经退出支付！");
 
                break;
            default:
                payResoult = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];

                break;
        }
    }
    if([resp isKindOfClass:[SendMessageToWXResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
        switch (resp.errCode) {
            case 0:
                [MBProgressHUD showMBProgressHud:[UIApplication sharedApplication].keyWindow.rootViewController.view withText:@"分享成功" withTime:2];
                break;
            case 1:
                [MBProgressHUD showMBProgressHud:[UIApplication sharedApplication].keyWindow.rootViewController.view withText:@"分享失败" withTime:2];
                break;
                
            default:
                break;
        }
        ;
    }
}

//- (void) onResp:(BaseResp*)resp {

//}


// 获取用户个人信息（UnionID机制）
- (void)wechatLoginByRequestForUserInfo:(NSString*)code {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *accessToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"access_token"];
    NSString *openID = [[NSUserDefaults standardUserDefaults] objectForKey:@"openid"];
    NSString *userUrlStr = [NSString stringWithFormat:@"%@/userinfo?access_token=%@&openid=%@", @"https://api.weixin.qq.com/sns", accessToken, openID];
    // 请求用户数据
    // 设置请求格式
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    // 设置返回格式
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 返回数据解析类型
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html",@"text/plain" ,nil];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.requestSerializer.timeoutInterval = 60;
    [manager GET:userUrlStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //数据解析
        NSMutableDictionary*resDict = (NSMutableDictionary *)[responseObject mj_JSONObject];
        NSLog(@"请求用户信息的response = %@", resDict);
        //

            //    NSMutableDictionary* dic=[NSMutableDictionary new];
        NSString* head=[resDict objectForKey:@"headimgurl"];

        self.openid=openID;
        self.nickname=[resDict objectForKey:@"nickname"];
        self.head=head;
        [self wxfunc];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"获取用户信息时出错 = %@", error);
    }];
}
-(void)wxfunc
{
    //微信是否存在
    NSDictionary *params1 = @{
                              @"code":self.openid
                              };
    [HttpTool get:[NSString stringWithFormat:@"user/listWxCode"] params:params1 success:^(id responseObj) {
        NSLog(@"");
        if ( [MySingleton filterNull:responseObj[@"data"]])//有微信号
        {
        NSDictionary* a=responseObj[@"data"];
        if ([a objectForKey:@"wxCode"]) {
            if (![MySingleton filterNull:[a objectForKey:@"mobile"]]) {//没电话
                ETWxPhoneViewController *bphone=[[ETWxPhoneViewController alloc]init];
                bphone.block = ^{
                    NSDictionary *params = @{
                                             @"code":self.openid,
                                             @"username" : self.nickname,
                                             @"headImageUrl" : self.head
                                             };
                    [HttpTool get:[NSString stringWithFormat:@"user/wxLogin"] params:params success:^(id responseObj) {
                        NSLog(@"");
                        NSDictionary* a=responseObj[@"data"];
                        if ([[a objectForKey:@"isDel"] isEqualToString:@"1001"]) {
                        }
                        else
                        {
                            NSUserDefaults* user=[NSUserDefaults standardUserDefaults];
                            [user setObject:[a objectForKey:@"token"] forKey:@"token"];
                            [user setObject:[a objectForKey:@"uid"] forKey:@"uid"];
                            [user synchronize];
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
                    
                };
                SSNavigationController * naviRoot = [[SSNavigationController alloc] initWithRootViewController:bphone];
                naviRoot.navigationBarHidden = NO;
                self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen]bounds]];
                [self.window setRootViewController:naviRoot];
                [self.window setBackgroundColor:kACColorWhite];
                [self.window makeKeyAndVisible];
                
            }
            else
            {
                NSDictionary *params = @{
                                         @"code":self.openid,
                                         @"username" : self.nickname,
                                         @"headImageUrl" : self.head
                                         };
                [HttpTool get:[NSString stringWithFormat:@"user/wxLogin"] params:params success:^(id responseObj) {
                    NSLog(@"");
                    NSDictionary* a=responseObj[@"data"];
                    if ([[a objectForKey:@"isDel"] isEqualToString:@"1001"]) {
                    }
                    else
                    {
                        NSUserDefaults* user=[NSUserDefaults standardUserDefaults];
                        [user setObject:[a objectForKey:@"token"] forKey:@"token"];
                        [user setObject:[a objectForKey:@"uid"] forKey:@"uid"];
                        [user synchronize];
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
//                [self mainViewController];
            }
        }
        }
        else//没有微信号
        {
            NSDictionary *params = @{
                                     @"code":self.openid,
                                     @"username" : self.nickname,
                                     @"headImageUrl" : self.head
                                     };
            [HttpTool get:[NSString stringWithFormat:@"user/wxLogin"] params:params success:^(id responseObj) {
                NSLog(@"");
                NSDictionary* a=responseObj[@"data"];

                //                if (_review==1 ) {
                //                    [self mainViewController];
                //                }
                if ([[a objectForKey:@"isDel"] isEqualToString:@"1001"]) {
                    [self mainViewController1];
                }
                else
                {
                    NSUserDefaults* user=[NSUserDefaults standardUserDefaults];
                    [user setObject:[a objectForKey:@"token"] forKey:@"token"];
                    [user setObject:[a objectForKey:@"uid"] forKey:@"uid"];
                    [user synchronize];
                    [self mainViewController];
                    
                }
                
                //                ETBphoneViewController *vc = [[ETBphoneViewController alloc] init];vc.hidesBottomBarWhenPushed = YES;[nav pushViewController:vc animated:YES];
                
            } failure:^(NSError *error) {
                NSLog(@"%@",error);
            }];
        }
    } failure:^(NSError *error) {
        //        NSLog(@"%@",error);
    }];
    
    
}
#pragma mark - 版本配置管理
- (void)appConfigProvider {
    //判断当前版本号与app存储的版本号相等
    NSString *strAppVersion = [[SSCacheManager sharedCacheManagerForApp] currentConfigVersion];
    //首次安装APP
    if (strAppVersion == nil && strAppVersion.length == 0) {
        //保存app版本号
        [[SSCacheManager sharedCacheManagerForApp] setConfigVersion:APP_VERSION];
        //保存首次安装状态
        [SSCacheManager setIsInstallorUpdate:YES];
    }else{
        //更新APP
        if (![APP_VERSION isEqualToString:strAppVersion]) {
            //保存app版本号
            [[SSCacheManager sharedCacheManagerForApp] setConfigVersion:APP_VERSION];
            //保存首次安装状态
            [SSCacheManager setIsInstallorUpdate:NO];
        }else{
            //保存:不是首次安装
            [SSCacheManager setIsInstallorUpdate:NO];
        }
    }
}
#pragma mark - 主页面
- (void)mainViewController {
    [self.window.rootViewController removeFromParentViewController];

    
        MainViewController * mainvc = [[MainViewController alloc]init];
        SSNavigationController * naviRoot = [[SSNavigationController alloc] initWithRootViewController:mainvc];
        naviRoot.navigationBarHidden = NO;
        self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen]bounds]];
        [self.window setRootViewController:naviRoot];
        [self.window setBackgroundColor:kACColorWhite];
        [self.window makeKeyAndVisible];
}
#pragma mark - 主页面
- (void)mainViewController1 {
    [self.window.rootViewController removeFromParentViewController];
    
    ETWxPhoneViewController *bphone=[[ETWxPhoneViewController alloc]init];

    
    bphone.block = ^{
        NSDictionary *params = @{
                                 @"code":self.openid,
                                 @"username" : self.nickname,
                                 @"headImageUrl" : self.head
                                 };
        [HttpTool get:[NSString stringWithFormat:@"user/wxLogin"] params:params success:^(id responseObj) {
            NSLog(@"");
            NSDictionary* a=responseObj[@"data"];
            if ([[a objectForKey:@"isDel"] isEqualToString:@"1001"]) {
            }
            else
            {
                NSUserDefaults* user=[NSUserDefaults standardUserDefaults];
                [user setObject:[a objectForKey:@"token"] forKey:@"token"];
                [user setObject:[a objectForKey:@"uid"] forKey:@"uid"];
                [user synchronize];
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
        
    };
    
    
    SSNavigationController * naviRoot = [[SSNavigationController alloc] initWithRootViewController:bphone];
    naviRoot.navigationBarHidden = NO;
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen]bounds]];
    [self.window setRootViewController:naviRoot];
    [self.window setBackgroundColor:kACColorWhite];
    [self.window makeKeyAndVisible];
//    MainViewController * mainvc = [[MainViewController alloc]init];
//    SSNavigationController * naviRoot = [[SSNavigationController alloc] initWithRootViewController:mainvc];
//    naviRoot.navigationBarHidden = NO;
//    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen]bounds]];
//    [self.window setRootViewController:naviRoot];
//    [self.window setBackgroundColor:kACColorWhite];
//    [self.window makeKeyAndVisible];
}





    


#pragma mark - 登录页面
- (void)loginViewController {
    [self.window.rootViewController removeFromParentViewController];
    ETLoginViewController * loginvc = [[ETLoginViewController alloc]init];
    _loginVC=loginvc;
    SSNavigationController *naviRoot = [[SSNavigationController alloc] initWithRootViewController:loginvc];
    naviRoot.navigationBarHidden = YES;
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen]bounds]];
    [self.window setRootViewController:naviRoot];
    [self.window setBackgroundColor:kACColorWhite];
    [self.window makeKeyAndVisible];
    
}

- (void)setUpNavigationBar {
    // 设置是 广泛使用WRNavigationBar，还是局部使用WRNavigationBar，目前默认是广泛使用
    [WRNavigationBar wr_widely];
    [WRNavigationBar wr_setBlacklist:@[@"SpecialController",
                                       @"TZPhotoPickerController",
                                       @"TZGifPhotoPreviewController",
                                       @"TZAlbumPickerController",
                                       @"TZPhotoPreviewController",
                                       @"TZVideoPlayerController",
                                       @"TZImagePickerController"]];
    // 设置导航栏默认的背景颜色
    [WRNavigationBar wr_setDefaultNavBarBarTintColor:kACColorBlue_Theme];
    // 设置导航栏所有按钮的默认颜色
    [WRNavigationBar wr_setDefaultNavBarTintColor:kACColorBlackTypeface];
    // 设置导航栏标题默认颜色
    [WRNavigationBar wr_setDefaultNavBarTitleColor:kACColorWhite];
    // 统一设置状态栏样式
    [WRNavigationBar wr_setDefaultStatusBarStyle:UIStatusBarStyleLightContent];
    // 如果需要设置导航栏底部分割线隐藏，可以在这里统一设置
    [WRNavigationBar wr_setDefaultNavBarShadowImageHidden:YES];
}


#pragma mark - 登录成功通知
- (void)loginSuccessNotification {
    
    [self mainViewController];
    
}

#pragma mark - 退出登录通知
- (void)loginOutNotification {
    
    [self loginViewController];
}

- (void)applicationWillResignActive:(UIApplication *)application {

}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    [[EMClient sharedClient] applicationDidEnterBackground:application];

}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    [[EMClient sharedClient] applicationWillEnterForeground:application];

}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    if ([[SSPayUtils shareUser].State isEqualToString:@"begin"]) {
        //支付流程结束
        [SSPayUtils shareUser].State = @"end";
        [[ACToastView toastView:YES]showLoading:@"正在支付中" cancel:nil];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //如果没有收到支付回调
            [[NSNotificationCenter defaultCenter]postNotificationName:Request_PayResult object:nil];
        });
    }
}


- (void)applicationWillTerminate:(UIApplication *)application {
   
}

-(void)configJpush:(NSDictionary*)launchOptions
{
    NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    
    // 3.0.0及以后版本注册可以这样写，也可以继续用旧的注册方式
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    //如不需要使用IDFA，advertisingIdentifier 可为nil
    [JPUSHService setupWithOption:launchOptions appKey:appKey
                          channel:channel
                 apsForProduction:isProduction
            advertisingIdentifier:advertisingId];
    
    //2.1.9版本新增获取registration id block接口。
    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
        if(resCode == 0){
            NSLog(@"registrationID获取成功：%@",registrationID);
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:registrationID forKey:@"regid"];
            [defaults synchronize];
            //测试推送代码
            //            UIAlertController * alertCon = [UIAlertController alertControllerWithTitle:@"registrationID" message:registrationID preferredStyle:UIAlertControllerStyleAlert];
            //            UIAlertAction * action = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //            }];
            //            [alertCon addAction:action];
            //            UIWindow * window = [[[UIApplication sharedApplication] windows] lastObject];
            //            [window.rootViewController presentViewController:alertCon animated:YES completion:nil];
        }
        else{
            NSLog(@"registrationID获取失败，code：%d",resCode);
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            NSString* password = [defaults objectForKey:@"regid"];
            if (password) {
            }
        }
    }];
}

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    NSLog(@"%@", [NSString stringWithFormat:@"Device Token: %@", deviceToken]);
    [JPUSHService registerDeviceToken:deviceToken];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[EMClient sharedClient] bindDeviceToken:deviceToken];
    });
}

- (void)application:(UIApplication *)application
didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1
- (void)application:(UIApplication *)application
didRegisterUserNotificationSettings:
(UIUserNotificationSettings *)notificationSettings {
    [application registerForRemoteNotifications];
}

// Called when your app has been activated by the user selecting an action from
// a local notification.
// A nil action identifier indicates the default action.
// You should call the completion handler as soon as you've finished handling
// the action.
- (void)application:(UIApplication *)application
handleActionWithIdentifier:(NSString *)identifier
forLocalNotification:(UILocalNotification *)notification
  completionHandler:(void (^)())completionHandler {
}

// Called when your app has been activated by the user selecting an action from
// a remote notification.
// A nil action identifier indicates the default action.
// You should call the completion handler as soon as you've finished handling
// the action.
- (void)application:(UIApplication *)application
handleActionWithIdentifier:(NSString *)identifier
forRemoteNotification:(NSDictionary *)userInfo
  completionHandler:(void (^)())completionHandler {
}
#endif

- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [JPUSHService handleRemoteNotification:userInfo];
//    NSLog(@"iOS6及以下系统，收到通知:%@", [self logDic:userInfo]);
    //    [rootViewController addNotificationCount];
}

- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo
fetchCompletionHandler:
(void (^)(UIBackgroundFetchResult))completionHandler {
    [JPUSHService handleRemoteNotification:userInfo];
//    NSLog(@"iOS7及以上系统，收到通知:%@", [self logDic:userInfo]);
    
    if ([[UIDevice currentDevice].systemVersion floatValue]<10.0 || application.applicationState>0) {
        //        [rootViewController addNotificationCount];
    }
    
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application
didReceiveLocalNotification:(UILocalNotification *)notification {
    [JPUSHService showLocalNotificationAtFront:notification identifierKey:nil];
}

#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#pragma mark- JPUSHRegisterDelegate
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    NSDictionary * userInfo = notification.request.content.userInfo;
    
    UNNotificationRequest *request = notification.request; // 收到推送的请求
    UNNotificationContent *content = request.content; // 收到推送的消息内容
    
    NSNumber *badge = content.badge;  // 推送消息的角标
    NSString *body = content.body;    // 推送消息体
    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    NSString *title = content.title;  // 推送消息的标题
    
    EaseMessageModel* msg=[EaseMessageModel new];
    msg.text=content.title;
    msg.address=content.body;
    NSDate* d=[NSDate date];
    NSDateFormatter *dateFormattershow = [[NSDateFormatter alloc] init];
    [dateFormattershow setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *strDate = [dateFormattershow stringFromDate:d];
    msg.timestr=strDate;
    [msg bg_saveOrUpdate];
    NSInteger iconbadge=[UIApplication sharedApplication].applicationIconBadgeNumber+1;
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:iconbadge];
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        NSLog(@"iOS10 前台收到远程通知:%@", userInfo);
        
        //        [rootViewController addNotificationCount];
        //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"收到任务" message:body delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        //        [alert show];
        
    }
    else {
        // 判断为本地通知
        NSLog(@"iOS10 前台收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@\n}",body,title,subtitle,badge,sound,userInfo);
    }
    completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以设置
}

- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    UNNotificationRequest *request = response.notification.request; // 收到推送的请求
    UNNotificationContent *content = request.content; // 收到推送的消息内容
    
    NSNumber *badge = content.badge;  // 推送消息的角标
    NSString *body = content.body;    // 推送消息体
    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    NSString *title = content.title;  // 推送消息的标题
    
    EaseMessageModel* msg=[EaseMessageModel new];
    msg.text=content.title;
    msg.address=content.body;
    [msg bg_saveOrUpdate];
    NSInteger iconbadge=[UIApplication sharedApplication].applicationIconBadgeNumber+1;
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:iconbadge];
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        NSLog(@"iOS10 收到远程通知:%@", userInfo);
        //        [rootViewController addNotificationCount];
        
    }
    else {
        // 判断为本地通知
        NSLog(@"iOS10 收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@\n}",body,title,subtitle,badge,sound,userInfo);
    }
    
    completionHandler();  // 系统要求执行这个方法
}
#endif


@end
