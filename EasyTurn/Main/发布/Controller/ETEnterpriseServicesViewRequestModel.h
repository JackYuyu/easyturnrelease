//
//  ETEnterpriseServicesViewRequestModel.h
//  EasyTurn
//
//  Created by 程立 on 2019/9/8.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ETEnterpriseServicesViewRequestModel : NSObject
/// 标题
@property (nonatomic, copy) NSString *title;
/// 详情 ~ //变更 内的字  基本详情
@property (nonatomic, copy) NSString *detail;
/// 1 工商服务 2 财税服务 3 行政许可服务 4 金融服务 5资质服务 6综合服务 7知产服务 8法律服务
@property (nonatomic, strong) NSNumber *serviceId;
/// 经营范围
@property (nonatomic, copy) NSString *business;
/// 发布类型 3发布服务
@property (nonatomic, strong) NSNumber *releaseTypeId;
// 求购区域
@property (nonatomic, strong) NSNumber *cityId;
@property (nonatomic, copy) NSString *cityName;
/// 纳税类型 1小规模 2 一般纳税
@property (nonatomic, strong) NSNumber *taxId;
/// 精准推送  0 关  1开
@property (nonatomic, strong) NSNumber *accuratePush;
/// 联系人姓名
@property (nonatomic, copy) NSString *linkmanName;
/// 联系人电话
@property (nonatomic, copy) NSString *linkmanMobil;
/// 注册资本
@property (nonatomic, copy) NSString *capital;
///求购事项
@property (nonatomic, copy) NSString *proceed;
/// 行业特点
@property (nonatomic, copy) NSString *industrial;
/// 银行开户(1.自开 2.代开)
@property (nonatomic, strong) NSNumber *bank;
///注册地址(1.自供 2.企服这提供);
@property (nonatomic, copy) NSString *regUrl;
///备注需求内容;
@property (nonatomic, copy) NSString *remarks;

+ (NSNumber *)serviceIdFromServiesKey:(NSString *)serviesKey;
+ (NSNumber *)taxIdFromTaxKey:(NSString *)taxKey;
+ (NSNumber *)bankFromBankKey:(NSString *)bankKey;
+ (NSNumber *)remarksFromRemarkKey:(NSString *)remarkKey;
@end

NS_ASSUME_NONNULL_END
