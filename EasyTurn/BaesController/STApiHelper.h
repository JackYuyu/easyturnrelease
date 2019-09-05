//
//  STApiHelper.h
//  Stone
//
//  Created by song on 2018/7/16.
//  Copyright © 2018年 song. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STApiHelper : NSObject

/**
 *  生成请求的url
 *
 *  @param host 域名
 *  @param path 文件路径
 *  @param file 文件名称
 *
 *  @return 拼接成完整的url
 */
+ (NSString *)urlWithHost:(NSString *)host path:(NSString *)path file:(NSString *)file;

/**
 该方法自动添加需要参数类型 defaut｜（userkey 或 udid）
 
 @param params 非公共参数的所有请求参数
 @return 签名完成的 NSDictionary
 */
+ (NSDictionary *)signNeedOptionParams:(NSDictionary *)params;
@end
