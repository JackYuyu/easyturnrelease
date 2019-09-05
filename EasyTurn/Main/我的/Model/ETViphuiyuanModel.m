//
//  ETViphuiyuanModel.m
//  EasyTurn
//
//  Created by 王翔 on 2019/9/1.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import "ETViphuiyuanModel.h"

@implementation ETViphuiyuanModel
/**
 查询支付结果
 @param orderId 订单编号
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)requestPayResultWithOrderId:(NSString *)orderId
                        WithSuccess:(STBaseModelRequestSuccess)success
                            failure:(STBaseModelRequestFailure)failure {
    
    NSString *url = [STApiHelper urlWithHost:devHost_Http_App path:pathPay file:@"/getPayResult"];
    
    NSDictionary *dicParams = @{
                                @"id" : orderId
                                };
    
    NSDictionary *mDic = [STApiHelper signNeedOptionParams:dicParams];
    [self POSTWithUrl:url param:mDic success:success failure:failure];
}
@end
