//
//  ETMineViewModel.h
//  EasyTurn
//
//  Created by 王翔 on 2019/9/4.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import "STBaseModel.h"
@class UserInfosModel;
@class ShareModel;
@class UserInfosReleaseModel;
NS_ASSUME_NONNULL_BEGIN

@interface ETMineViewModel : STBaseModel
@property (nonatomic, strong) UserInfosModel *userInfo;
@property (nonatomic, strong) ShareModel *share;
@property (nonatomic, strong) NSArray <UserInfosReleaseModel *> *data;


/**
 查询个人信息
 @param uid     个人id
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)requestUserInfoWithUid:(NSString *)uid
                   WithSuccess:(STBaseModelRequestSuccess)success
                       failure:(STBaseModelRequestFailure)failure;

/**
 我的动态
 @param releaseTypeId 类型
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)requestUserOrderListWithPage:(NSInteger )page
                        WithPageSize:(NSInteger )pageSize
                       ReleaseTypeId:(NSInteger )releaseTypeId
                         WithSuccess:(STBaseModelRequestSuccess)success
                             failure:(STBaseModelRequestFailure)failure;

/**
 签到
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)requestSignWithSuccess:(STBaseModelRequestSuccess)success
                       failure:(STBaseModelRequestFailure)failure;


@end

@interface UserInfosModel : STBaseModel
@property (nonatomic, copy) NSString *portrait;
@property (nonatomic, copy) NSString *name;
///企服者
//@property (nonatomic, copy) NSString *name;
///0不是会员 1是会员
@property (nonatomic, copy) NSString *vip;
///会员到期时间
@property (nonatomic, copy) NSString *vipExpiryDate;
///0未认证 1认证
@property (nonatomic, copy) NSString *isChecked;
@property (nonatomic, copy) NSString *refreshCount;
@property (nonatomic, strong) NSString *invitationCodeUtilMe;
//0未签到 1已签到
@property (nonatomic, assign) NSInteger isSign;
@end

@interface ShareModel : STBaseModel
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *url;
@end

@interface UserInfosReleaseModel : STBaseModel
@property (nonatomic, copy) NSString *releaseId;
@property (nonatomic, copy) NSString *imageList;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *information;
@property (nonatomic, copy) NSString *cityName;
@property (nonatomic, copy) NSString *releaseTime;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *browse;
///0显示浏览次数 1等待卖家确认 2卖家已确认
@property (nonatomic, copy) NSString *tradStatus;
@property (nonatomic, copy) NSString *detail;
@property (nonatomic, copy) NSString *releaseTypeId;

@end

NS_ASSUME_NONNULL_END
