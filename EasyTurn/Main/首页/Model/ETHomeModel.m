//
//  ETHomeModel.m
//  EasyTurn
//
//  Created by 程立 on 2019/7/19.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import "ETHomeModel.h"

@implementation ETHomeModel
+ (void)requestGetIndexBannerSuccess:(STBaseModelRequestSuccess)success failure:(STBaseModelRequestFailure)failure {
    
    NSString *url = [STApiHelper urlWithHost:devHost_Http_App path:@"/banner" file:@"/getIndexBanner"];
    NSDictionary *mDic = [STApiHelper signNeedOptionParams:nil];
    [self POSTWithUrl:url param:mDic success:success failure:failure];
}



+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"adList" : @"AdListModel"
             };
}

@end

@implementation AdListModel

@end
