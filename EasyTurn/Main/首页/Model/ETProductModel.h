//
//  ETProductModel.h
//  EasyTurn
//
//  Created by 程立 on 2019/7/28.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

//#import <Foundation/Foundation.h>
#import "UserInfoModel.h"
#import "NSObject+BGModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ETProductModel : NSObject
@property (nonatomic, copy) NSString *baesId;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *management;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *auth;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *share;
@property (nonatomic, copy) NSString *imageList;
@property (nonatomic, copy) NSString *cityName;
@property (nonatomic, copy) NSString *business;
@property (nonatomic, copy) NSString *releaseId;
@property (nonatomic, copy) NSString *detail;
@property (nonatomic, copy) NSString *releaseTime;
@property (nonatomic, copy) NSString *releaseTypeId;
@property (nonatomic, copy) NSString *serviceId;
@property (nonatomic, copy) NSString *selectId;
@property (nonatomic, copy) NSString *taxId;
@property (nonatomic, copy) NSString *linkmanName;
@property (nonatomic, copy) NSString *linkmanMobil;
@property (nonatomic, copy) NSString *asset;
@property (nonatomic, copy) NSString *information;

//详情
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, strong) NSDictionary *dictInfo;

//详情
@property (nonatomic, strong) UserInfoModel *userInfo;
@property (nonatomic, copy) NSString *isCollect;

//订单
@property (nonatomic, copy) NSString *releaseOrderId;
@property (nonatomic, copy) NSString *orderid;
@property (nonatomic, copy) NSString *tradStatus;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *LongId;


//提现
@property (nonatomic,copy) NSNumber *amout;
@property (nonatomic,copy) NSString *payeeAccount;
@property (nonatomic,copy) NSString *payerRealName;
@property (nonatomic,copy) NSString *payerShowName;
@property (nonatomic,copy) NSString *remark;
//账单记录
@property (nonatomic, copy) NSString *payTime;
@property (nonatomic, copy) NSString *images;
//touser
@property (nonatomic, copy) NSString *touser;
//
@property (nonatomic,copy) NSString* createDate;
@end

NS_ASSUME_NONNULL_END
