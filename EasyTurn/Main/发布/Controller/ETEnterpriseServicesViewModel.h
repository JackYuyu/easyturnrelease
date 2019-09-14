//
//  ETEnterpriseServicesViewModel.h
//  EasyTurn
//
//  Created by 程立 on 2019/9/7.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *const ETEnterpriseServicesViewSectionFirst = @"ETEnterpriseServicesViewSectionFirst";
static NSString *const ETEnterpriseServicesViewSectionSecond = @"ETEnterpriseServicesViewSectionSecond";
static NSString *const ETEnterpriseServicesViewSectionThird = @"ETEnterpriseServicesViewSectionThird";

typedef NS_ENUM(NSUInteger, ETEnterpriseServicesViewItemModelType) {
    /// 标题 行业特点 注册资本 备注
    ETEnterpriseServicesViewItemModelTypeTitle = 1,
    // 服务类型 求购事项 税务类型
    ETEnterpriseServicesViewItemModelTypePopList = 2,
    /// 经营范围
    ETEnterpriseServicesViewItemModelTypeScopeBusiness = 3,
    /// 银行开户 注册地址
    ETEnterpriseServicesViewItemModelTypeSelect = 4,
    /// 求购地址
    ETEnterpriseServicesViewItemModelTypeAddress = 5,
    /// 精准推送平台祈福者
    ETEnterpriseServicesViewItemModelTypeSwitch = 6,
    /// 变更
    ETEnterpriseServicesViewItemModelTypeCheck = 7,
    /// 备注需求内容
    ETEnterpriseServicesViewItemModelTypeTextView = 8
};

//服务类型
static NSString * const ServicesTypeKey = @"serviceId";
// 求购事项
static NSString * const PurchasingTypeKey = @"proceed";
// 求购区域
static NSString * const PurchasingAreakey = @"PurchasingCity";

NS_ASSUME_NONNULL_BEGIN
@class ETEnterpriseServicesBusinessScopeModel;
@class ETEnterpriseServicesViewItemModel;
@interface ETEnterpriseServicesViewModel : NSObject

@property (nonatomic, copy) NSString *sectionType;
@property (nonatomic, strong) NSArray<ETEnterpriseServicesViewItemModel *> *list;
@end


@interface ETEnterpriseServicesViewItemModel : NSObject

@property (nonatomic, assign) ETEnterpriseServicesViewItemModelType cellType;
// 传递给服务器的字段和值
@property (nonatomic, copy) NSString *key;
@property (nonatomic, copy) NSString *value;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, strong) NSArray<NSString *> *arrListContent;
@property (nonatomic, assign) CGFloat cellheight;

#pragma mark - ETEnterpriseServicesViewItemModelTypePopList赋值字段
// 最大宽度
@property (nonatomic, assign) CGFloat popTableMaxWidth;
@property (nonatomic, strong) NSArray *updates;
#pragma mark - ETEnterpriseServicesViewItemModelTypeSelect赋值字段
@property (nonatomic, copy) NSString *selectFirst;
@property (nonatomic, copy) NSString *selectSecond;

#pragma mark - ETEnterpriseServicesViewItemModelTypeCheck赋值字段
@property (nonatomic, assign) BOOL isSelected;
#pragma mark - ETEnterpriseServicesViewItemModelTypeScopeBusiness
@property (nonatomic, strong) NSArray<ETEnterpriseServicesBusinessScopeModel *> *businessScopeList;
@property (nonatomic, assign) NSInteger reloadSection;
#pragma mark - ETEnterpriseServicesViewItemModelTypeSwitch && ETEnterpriseServicesViewItemModelTypeScopeBusiness
@property (nonatomic, assign) BOOL isOpen;
@end

NS_ASSUME_NONNULL_END
