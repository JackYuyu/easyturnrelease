//
//  ETAboutViewController.m
//  EasyTurn
//
//  Created by 王翔 on 2019/7/23.
//  Copyright © 2019年 EasyTurn. All rights reserved.
//

#import "ETAboutViewController.h"

@interface ETAboutViewController ()
@property(nonatomic,strong)UIImageView *yizhuanImg;
@property(nonatomic,strong)UILabel *editionLab;
@property(nonatomic,strong)UIButton *editionButton;
@property(nonatomic,strong)UIButton *agreementBtn;
@property(nonatomic,strong)UILabel *comLab;
@property(nonatomic,strong)UILabel *rightLab;
@property(nonatomic,strong)UILabel *renewLab;
@property(nonatomic,strong)UIImageView *triangleImg;
@end

@implementation ETAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self PostUI];
    [self judgeNeedVersionUpdate];
    // Do any additional setup after loading the view.
    self.title=@"关于易转";
    self.view.backgroundColor=[UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    [self.view addSubview:self.yizhuanImg];
    [self.view addSubview:self.editionLab];
    [self.view addSubview:self.editionButton];
    [self.view addSubview:self.agreementBtn];
    [self.view addSubview:self.comLab];
    [self.view addSubview:self.rightLab];
    [self.editionButton addSubview:self.renewLab];
    [self.editionButton addSubview:self.triangleImg];
    [self.yizhuanImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(86);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(160, 59));
    }];
    
    [self.editionLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.yizhuanImg.mas_bottom).offset(16);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(79, 24));
    }];
    
    [self.editionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(224);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(49);
    }];
    
    [self.agreementBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.editionButton.mas_bottom).offset(82);
        make.left.mas_equalTo(52);
        make.right.mas_equalTo(-52);
        make.height.mas_equalTo(18);
    }];
    
    [self.comLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.agreementBtn.mas_bottom).offset(11);
        make.left.mas_equalTo(129);
        make.right.mas_equalTo(-129);
        make.height.mas_equalTo(18);
    }];
    
    [self.rightLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.comLab.mas_bottom);
        make.left.mas_equalTo(39);
        make.right.mas_equalTo(-39);
        make.height.mas_equalTo(18);
    }];
    
    [self.renewLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(14);
        make.left.mas_equalTo(14);
        make.size.mas_equalTo(CGSizeMake(65, 21));
    }];
    
    [self.triangleImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(14);
        make.right.mas_equalTo(-12);
        make.size.mas_equalTo(CGSizeMake(10, 20));
    }];
    
}

- (UIImageView *)yizhuanImg {
    if (!_yizhuanImg) {
        _yizhuanImg = [[UIImageView alloc] init];
        _yizhuanImg.image = [UIImage imageNamed:@"易转logo-1"];
    }
    return _yizhuanImg;
}

- (UILabel *)editionLab {
    if (!_editionLab) {
        _editionLab = [[UILabel alloc] init];
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        CFShow((__bridge CFTypeRef)(infoDictionary));
        NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
        _editionLab.text = [NSString stringWithFormat:@"易转%@",app_Version];
        _editionLab.textColor = [UIColor blackColor];
    }
    return _editionLab;
}

- (void)shareAppVersionAlert {
    
       
    
         if(![self judgeNeedVersionUpdate])  return ;
    
        //App内info.plist文件里面版本号
    
        NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    
        NSString *appVersion = infoDict[@"CFBundleShortVersionString"];
    
        NSString *bundleId   = infoDict[@"CFBundleIdentifier"];
    
        NSString *urlString =  [NSString stringWithFormat:@"https://itunes.apple.com/cn/lookup?id=1474345893"];
    
        NSURL *urlStr = [NSURL URLWithString:urlString];
    
        //创建请求体
    
        NSURLRequest *urlRequest = [NSURLRequest requestWithURL:urlStr];
    
        [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        
                if (connectionError) {
            
                        //            NSLog(@"connectionError->%@", connectionError.localizedDescription);
            
                        return ;
            
                    }
        
                NSError *error;
        
                NSDictionary *resultsDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        
                NSLog(@"resultsDict +++:%@", resultsDict);
        
                if (error) {
            
                        //            NSLog(@"error->%@", error.localizedDescription);
            
                        return;
            
                    }
        
                NSArray *sourceArray = resultsDict[@"results"];
        
                if (sourceArray.count >= 1) {
            
                        //AppStore内最新App的版本号
            
                        NSDictionary *sourceDict = sourceArray[0];
            
                        NSString *newVersion = sourceDict[@"version"];
            
                        NSLog(@"newVersion:%@",newVersion);
            
                       
            
                        if ([newVersion floatValue]*1000>[appVersion floatValue]*1000)
                
                            {
                    
                                    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"提示:\n您的App不是最新版本，请问是否更新" message:@"" preferredStyle:UIAlertControllerStyleAlert];
                    
                                    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"暂不更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        
                                            //                    [alertVc dismissViewControllerAnimated:YES completion:nil];
                        
                                        }];
                    
                                    [alertVc addAction:action1];
                    
                                    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"去更新" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                        
                                            //跳转到AppStore，该App下载界面
                        
                                            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:sourceDict[@"trackViewUrl"]]];
                        
                                        }];
                    
                                    [alertVc addAction:action2];
                    
                                    [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:alertVc animated:YES completion:nil];
                    
                                }
            
                    }
        
            }];
    
}



//每天进行一次版本判断

- (BOOL)judgeNeedVersionUpdate {
    
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
        [formatter setDateFormat:@"yyyy-MM-dd"];
    
        //获取年-月-日
    
        NSString *dateString = [formatter stringFromDate:[NSDate date]];
    
        NSString *currentDate = [[NSUserDefaults standardUserDefaults] objectForKey:@"currentDate"];
    
        if ([currentDate isEqualToString:dateString]) {
         [MBProgressHUD showMBProgressHud:[UIApplication sharedApplication].keyWindow.rootViewController.view withText:@"当前已是最新版本!" withTime:2];
        [_editionLab setEnabled:NO];
                return NO;
        
            }
    
        [[NSUserDefaults standardUserDefaults] setObject:dateString forKey:@"currentDate"];
    
        return YES;
    
}


- (UIButton *)editionButton {
    if (!_editionButton) {
        _editionButton = [[UIButton alloc]init];
        _editionButton.backgroundColor = [UIColor whiteColor];
        [_editionButton addTarget:self action:@selector(edition) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _editionButton;
}

- (void)edition {
    [self shareAppVersionAlert];  
//    UIAlertController* alert = [UIAlertController alertControllerWithTitle:nil
//                                                                   message:@"版本升级"
//                                                            preferredStyle: UIAlertActionStyleCancel];
//
//    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"稍后下载" style:UIAlertActionStyleDefault
//                                                          handler:^(UIAlertAction * action) {
//                                                              //响应事件
//                                                              NSLog(@"action = %@", action);
//                                                          }];
//    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"立即更新" style:UIAlertActionStyleDefault
//                                                         handler:^(UIAlertAction * action) {
//                                                             //响应事件
//                                                             NSLog(@"action = %@", action);
//                                                             [self PostUI:cancelAction];
//
//                                                         }];
//
//    [alert addAction:defaultAction];
//    [alert addAction:cancelAction];
//    [self presentViewController:alert animated:YES completion:nil];
}

- (void)PostUI {
    NSMutableDictionary *dic = [NSMutableDictionary new];
    NSDictionary *params = @{
                             };
    
    [HttpTool get:[NSString stringWithFormat:@"app/update"] params:params success:^(id responseObj) {
        NSLog(@"------成功");
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (UIButton *)agreementBtn {
    if (!_agreementBtn) {
        _agreementBtn = [[UIButton alloc]init];
        //        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"《软件许可及服务协议》 和 《隐私保护指引》"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 13],NSForegroundColorAttributeName: [UIColor colorWithRed:47/255.0 green:134/255.0 blue:251/255.0 alpha:1.0]}];
        NSString*str = [[NSString alloc]initWithFormat:@"《软件许可及服务协议》 和 《隐私保护指引》"];
        [_agreementBtn setTitle:[NSString stringWithFormat:@"%@", str] forState:UIControlStateNormal];
        _agreementBtn.titleLabel.font=[UIFont systemFontOfSize:13];
        [_agreementBtn setTitleColor:[UIColor colorWithRed:47/255.0 green:134/255.0 blue:251/255.0 alpha:1.0] forState:UIControlStateNormal];
        _agreementBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _agreementBtn.alpha = 1.0;
    }
    return _agreementBtn;
}

- (UILabel *)comLab {
    if (!_comLab) {
        _comLab=[[UILabel alloc]init];
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"易转公司  版权所有"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 13],NSForegroundColorAttributeName: [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0]}];
        
        _comLab.attributedText = string;
        _comLab.textAlignment = NSTextAlignmentLeft;
        _comLab.alpha = 1.0;
    }
    return _comLab;
}

- (UILabel *)rightLab {
    if (!_rightLab) {
        _rightLab=[[UILabel alloc]init];
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"Copyright 2019 Copyright 2019 Copyright 2019 .."attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 13],NSForegroundColorAttributeName: [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0]}];
        
        _rightLab.attributedText = string;
        _rightLab.textAlignment = NSTextAlignmentLeft;
        _rightLab.alpha = 1.0;
    }
    return _rightLab;
}

- (UILabel *)renewLab {
    if (!_renewLab) {
        _renewLab=[[UILabel alloc]init];
        _renewLab.text=@"版本更新";
        _renewLab.textColor=[UIColor blackColor];
        _renewLab.font=[UIFont systemFontOfSize:15];
    }
    return _renewLab;
}

- (UIImageView *)triangleImg {
    if (!_triangleImg) {
        _triangleImg=[[UIImageView alloc]init];
        _triangleImg.image=[UIImage imageNamed:@"进入"];
    }
    return _triangleImg;
}
- (void)dealloc{
    NSLog(@"%@ --- dealloc", NSStringFromClass([self class]));
}

@end

