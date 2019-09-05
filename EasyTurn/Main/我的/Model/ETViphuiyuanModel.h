//
//  ETViphuiyuanModel.h
//  EasyTurn
//
//  Created by 王翔 on 2019/9/1.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import "STBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ETViphuiyuanModel : STBaseModel
@property(nonatomic,copy)NSString *result;
/**
 查询支付结果
 @param orderId 订单编号
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)requestPayResultWithOrderId:(NSString *)orderId
                        WithSuccess:(STBaseModelRequestSuccess)success
                            failure:(STBaseModelRequestFailure)failure;
@end

NS_ASSUME_NONNULL_END
