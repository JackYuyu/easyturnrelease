//
//  ETAPViewController.m
//  EasyTurn
//
//  Created by 王翔 on 2019/7/30.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import "ETAPViewController.h"
#import <AlipaySDK/AlipaySDK.h>
@interface ETAPViewController ()

@end

@implementation ETAPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    
    
    [[AlipaySDK defaultService] payOrder:@"此处是从后台拿到的订单签名信息"  fromScheme:@"这里边填写第三步配置的URL Scheme" callback:^(NSDictionary *resultDic) {
        NSLog(@"=====%@",resultDic);
        if ([resultDic[@"resultStatus"]intValue] == 9000) {
            NSLog(@"成功");
        } else {
            NSLog(@"失败");
        }
    }];
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
