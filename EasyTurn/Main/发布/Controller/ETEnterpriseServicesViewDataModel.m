//
//  ETEnterpriseServicesViewDataModel.m
//  EasyTurn
//
//  Created by 程立 on 2019/9/7.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import "ETEnterpriseServicesViewDataModel.h"
#import "ETEnterpriseServicesViewModel.h"

static NSString * const establishmentKey = @"设立";
static NSString * const changeKey = @"变更";
static NSString * const equityPledgeKey = @"股权出质";
static NSString * const bussinessotherKey = @"其它";

@implementation ETEnterpriseServicesViewDataModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"arrEnterpriseServicesViewData" : [ETEnterpriseServicesViewModel class]};
}

+ (ETEnterpriseServicesViewDataModel *)loadDataSourceETEnterpriseServicesViewDataModel {
    NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"EnterpriseServicesViewData" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:sourcePath];
    if (!(data && [data isKindOfClass:[NSData class]])) return nil;
    
    NSError *error = nil;
    id jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    if ([jsonData isKindOfClass:[NSDictionary class]]) {
        NSDictionary *result = jsonData;
        if (!result) return  nil;
        ETEnterpriseServicesViewDataModel *mFilter = [ETEnterpriseServicesViewDataModel mj_objectWithKeyValues:result];
        ETEnterpriseServicesViewModel *mSection = mFilter.arrEnterpriseServicesViewData.firstObject;
        __block NSString *serviceTypeKey = nil;
        [mSection.list enumerateObjectsUsingBlock:^(ETEnterpriseServicesViewItemModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj.key isEqualToString:ServicesTypeKey]) {
                serviceTypeKey = obj.content;
                *stop = YES;
            }
        }];
        NSMutableArray *arrMuValues = [NSMutableArray array];
        [mSection.list enumerateObjectsUsingBlock:^(ETEnterpriseServicesViewItemModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj.key isEqualToString:PurchasingTypeKey]) {
                obj.arrListContent = [self arrContentListPurchaseMattersWithKey:serviceTypeKey];
                obj.content = obj.arrListContent.firstObject;
                obj.value = obj.arrListContent.firstObject;
            }
            [arrMuValues addObject:obj];
        }];
        mSection.list = arrMuValues;
        return mFilter;
    }
    return nil;
}

//+ (ETEnterpriseServicesViewDataModel *)loadDataSourceETEnterpriseServicesViewDataModelWithArrOldData:(NSArray<ETEnterpriseServicesViewModel *> *)arrOldData {
//
//}

+ (ETEnterpriseServicesViewDataModel *)loadDataSourceETEnterpriseServicesViewDataModelWithServiceTypeKey:(NSString *)serviceTypeKey purchaseMattersKey:(NSString *)purchaseMattersKey arrOldData:(NSArray<ETEnterpriseServicesViewModel *> *)arrOldData {
    ETEnterpriseServicesViewDataModel *mFilter = [self loadDataSourceETEnterpriseServicesViewDataModel];
    NSMutableArray *arrMuData = [NSMutableArray arrayWithArray:mFilter.arrEnterpriseServicesViewData];
    if ([purchaseMattersKey isEqualToString:establishmentKey]) {
        [arrMuData replaceObjectAtIndex:0 withObject:mFilter.establishment];
    } else if ([purchaseMattersKey isEqualToString:changeKey]) {
        [arrMuData replaceObjectAtIndex:0 withObject:mFilter.change];
    }  else if (([purchaseMattersKey isEqualToString:equityPledgeKey]) ||
                ([serviceTypeKey isEqualToString:BusinessServicesKey] && [purchaseMattersKey isEqualToString:bussinessotherKey])) {
        [arrMuData replaceObjectAtIndex:0 withObject:mFilter.businessother];
    } else {
        [arrMuData replaceObjectAtIndex:0 withObject:mFilter.other];
    }
    mFilter.arrEnterpriseServicesViewData = arrMuData;
    ETEnterpriseServicesViewModel *mSection = mFilter.arrEnterpriseServicesViewData.firstObject;
    ETEnterpriseServicesViewModel *mOldSection = arrOldData.firstObject;
    NSMutableArray *arrMuValues = [NSMutableArray array];
    [mSection.list enumerateObjectsUsingBlock:^(ETEnterpriseServicesViewItemModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        __block ETEnterpriseServicesViewItemModel *newObj = obj;
        [mOldSection.list enumerateObjectsUsingBlock:^(ETEnterpriseServicesViewItemModel * _Nonnull oldObj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj.key isEqualToString:oldObj.key]) {
                newObj = [ETEnterpriseServicesViewItemModel mj_objectWithKeyValues:[oldObj mj_keyValues]];
            }
        }];
        obj = newObj;
        if ([obj.key isEqualToString:PurchasingTypeKey]) {
            obj.arrListContent = [self arrContentListPurchaseMattersWithKey:serviceTypeKey];
            if ([obj.arrListContent containsObject:purchaseMattersKey]) {
                obj.content = purchaseMattersKey;
                obj.value = purchaseMattersKey;
            } else {
                obj.content = obj.arrListContent.firstObject;
                obj.value = obj.arrListContent.firstObject;
            }
            
        }
        [arrMuValues addObject:obj];
    }];
    mSection.list = arrMuValues;
    return mFilter;
}

+ (ETEnterpriseServicesViewDataModel *)loadDataSourceETEnterpriseServicesViewDataModelWithServiceTypeKey:(NSString *)serviceTypeKey arrOldData:(NSArray<ETEnterpriseServicesViewModel *> *)arrOldData {
    NSString *purchaseMattersKey = [self arrContentListPurchaseMattersWithKey:serviceTypeKey].firstObject;
    return [self loadDataSourceETEnterpriseServicesViewDataModelWithServiceTypeKey:serviceTypeKey purchaseMattersKey:purchaseMattersKey arrOldData:arrOldData];
}

+ (NSArray<NSString *> *)arrContentListPurchaseMattersWithKey:(NSString *)serviceTypeKey {
    NSArray *arrList = nil;
    if ([serviceTypeKey isEqualToString:BusinessServicesKey]) {
        arrList = @[establishmentKey, changeKey, @"股权出质", @"其它"];
    } else if ([serviceTypeKey isEqualToString:FinanceTaxKey]) {
        arrList = @[@"税务登记", @"纳税申报", @"代理记账", @"税务筹划", @"财税咨询", @"财务审计", @"一般纳税人认定", @"企业年报", @"核定残保金", @"社保", @"公积金", @"其它"];
    } else if ([serviceTypeKey isEqualToString:AdministrativeLicensingServicesKey]) {
        arrList = @[@"人力资源", @"高新技术企业认定", @"医疗器械经营许可证", @"制作许可证", @"电影拍摄许可证", @"卫生许可证", @"ICP", @"ISP", @"其它"];
    } else if ([serviceTypeKey isEqualToString:FinanceServicesKey]) {
        arrList = @[@"暂未开通", @"其它"];
    } else if ([serviceTypeKey isEqualToString:QualificationServicesKey]) {
        arrList = @[@"施工总承包资质", @"专业承包资质", @"其他建委资质"];
    } else if ([serviceTypeKey isEqualToString:IntellectualPropertyServicesKey]) {
        arrList = @[@"商标类服务", @"专业类服务", @"版权类服务", @"其它"];
    } else if ([serviceTypeKey isEqualToString:LawServicesKey]) {
        arrList = @[@"法律顾问", @"合同撰写", @"股权协议", @"公司章程", @"律师函", @"法律维权", @"合同再审", @"其它"];
    }  else if ([serviceTypeKey isEqualToString:IntegratedServicesKey]) {
        arrList = @[@"其它"];
    }
    
    return arrList;
}
@end
