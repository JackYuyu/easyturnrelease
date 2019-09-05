//
//  SSPayUtils.h
//  SSJewelry
//
//  Created by sszb on 2019/3/4.
//  Copyright © 2019 Song. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SSPayUtils : NSObject

// 确认订单-----从支付宝或者微信直接返回
// 1是支付成功 2是支付失败 3是点击左上角返回
@property (nonatomic, copy) NSString *State;
@property (nonatomic, copy) NSString *introduce;
@property (nonatomic, copy) NSString *registrationID;
+ (SSPayUtils *)shareUser;
@end

NS_ASSUME_NONNULL_END
