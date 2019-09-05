//
//  STApiHelper.m
//  Stone
//
//  Created by song on 2018/7/16.
//  Copyright © 2018年 song. All rights reserved.
//

#import "STApiHelper.h"
@implementation STApiHelper

+ (NSString *)urlWithHost:(NSString *)host path:(NSString *)path file:(NSString *)file {
    return [NSString stringWithFormat:@"%@%@%@", host, path ? path : @"", file ? file : @""];
}

+ (NSDictionary *)signNeedOptionParams:(NSDictionary *)params {
    
    NSString *token = [UserInfoModel loadUserInfoModel].token;
//    NSUserDefaults* user = [NSUserDefaults standardUserDefaults];
//    NSString* token = [user objectForKey:@"token"];
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionaryWithDictionary:params];
    [mutableDict setValue:token forKey:@"token"];
    return mutableDict;
}


//时间戳
+ (NSString *)timeInterval {
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[date timeIntervalSince1970]; // *1000 是精确到毫秒，不乘就是精确到秒
    NSMutableString *appId = [NSMutableString stringWithFormat:@"%.0f", a]; //转为字符型
    return appId;
}
@end
