//
//  ETMineViewModel.m
//  EasyTurn
//
//  Created by 王翔 on 2019/9/4.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import "ETMineViewModel.h"

@implementation ETMineViewModel
/**
 查询个人信息
 @param uid     个人id
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)requestUserInfoWithUid:(NSString *)uid
                    WithSuccess:(STBaseModelRequestSuccess)success
                        failure:(STBaseModelRequestFailure)failure {
    
    NSString *url = [STApiHelper urlWithHost:devHost_Http_App path:pathUser file:@"/info"];
    
    NSDictionary *dicParams = @{
                                @"uid" : uid
                                };
    
    NSDictionary *mDic = [STApiHelper signNeedOptionParams:dicParams];
    [self POSTWithUrl:url param:mDic success:success failure:failure];
}

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
                             failure:(STBaseModelRequestFailure)failure {
    
    NSString *url = [STApiHelper urlWithHost:devHost_Http_App path:pathRelease file:@"/orders"];
    
    NSDictionary *dicParams = @{
                                @"page" : @(page),
                                @"pageSize": @(pageSize),
                                @"releaseTypeId" : @(releaseTypeId)
                                };
    
    NSDictionary *mDic = [STApiHelper signNeedOptionParams:dicParams];
    [self POSTWithUrl:url param:mDic success:success failure:failure];
}

/**
 签到
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)requestSignWithSuccess:(STBaseModelRequestSuccess)success
                       failure:(STBaseModelRequestFailure)failure {
    
    NSString *url = [STApiHelper urlWithHost:devHost_Http_App path:pathUser file:@"/sign"];
    
    NSDictionary *mDic = [STApiHelper signNeedOptionParams:nil];
    [self POSTWithUrl:url param:mDic success:success failure:failure];
}


+ (NSDictionary *)objectClassInArray {
    return @{
             @"data" : @"UserInfosReleaseModel"
             };
}


@end

@implementation UserInfosModel

@end

@implementation ShareModel

@end

@implementation UserInfosReleaseModel

@end
