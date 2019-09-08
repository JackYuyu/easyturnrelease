//
//  ETEnterpriseServicesViewDataModel.h
//  EasyTurn
//
//  Created by 程立 on 2019/9/7.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString * const BusinessServicesKey = @"工商服务";
static NSString * const FinanceTaxKey = @"财税服务";
static NSString * const AdministrativeLicensingServicesKey = @"行政许可服务";
static NSString * const FinanceServicesKey = @"金融服务";
static NSString * const QualificationServicesKey = @"资质服务";
static NSString * const IntellectualPropertyServicesKey = @"知产服务";
static NSString * const LawServicesKey = @"法律服务";
static NSString * const IntegratedServicesKey = @"综合服务";

NS_ASSUME_NONNULL_BEGIN
@class ETEnterpriseServicesViewModel;
@interface ETEnterpriseServicesViewDataModel : NSObject
@property (nonatomic, strong) NSArray<ETEnterpriseServicesViewModel *> *arrEnterpriseServicesViewData;
// 设立
@property (nonatomic, strong) ETEnterpriseServicesViewModel *establishment;
// 变更
@property (nonatomic, strong) ETEnterpriseServicesViewModel *change;
// 工商管理下的 股权出质 和 其它
@property (nonatomic, strong) ETEnterpriseServicesViewModel *businessother;
// 其它类型
@property (nonatomic, strong) ETEnterpriseServicesViewModel *other;

+ (ETEnterpriseServicesViewDataModel *)loadDataSourceETEnterpriseServicesViewDataModel;
+ (ETEnterpriseServicesViewDataModel *)loadDataSourceETEnterpriseServicesViewDataModelWithServiceTypeKey:(NSString *)serviceTypeKey purchaseMattersKey:(NSString *)purchaseMattersKey arrOldData:(NSArray<ETEnterpriseServicesViewModel *> *)arrOldData;
+ (ETEnterpriseServicesViewDataModel *)loadDataSourceETEnterpriseServicesViewDataModelWithServiceTypeKey:(NSString *)serviceTypeKey arrOldData:(NSArray<ETEnterpriseServicesViewModel *> *)arrOldData;
// 输入服务类型的key 然后返回求购事项的数据
+ (NSArray<NSString *> *)arrContentListPurchaseMattersWithKey:(NSString *)serviceTypeKey;
//+ (ETEnterpriseServicesViewDataModel *)loadDataSourceETEnterpriseServicesViewDataModelWithArrOldData:(NSArray<ETEnterpriseServicesViewModel *> *)arrOldData;
@end

NS_ASSUME_NONNULL_END
