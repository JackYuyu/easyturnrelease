//
//  ETReleaseModel.m
//  EasyTurn
//
//  Created by 王翔 on 2019/9/8.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import "ETReleaseModel.h"

@implementation ETReleaseModel
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
    
    NSString *url = [STApiHelper urlWithHost:devHost_Http_App path:pathRelease file:@"/updateService"];
    
    NSDictionary *dicParams = @{
                                @"page" : @(page),
                                @"pageSize": @(pageSize),
                                @"releaseTypeId" : @(releaseTypeId)
                                };
    
    NSDictionary *mDic = [STApiHelper signNeedOptionParams:dicParams];
    [self POSTWithUrl:url param:mDic success:success failure:failure];
}
@end
