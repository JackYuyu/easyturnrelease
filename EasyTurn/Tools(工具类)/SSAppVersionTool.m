//
//  DCAppVersionTool.m
//  CDDStoreDemo
//
//  Created by 陈甸甸 on 2017/12/20.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "SSAppVersionTool.h"

@implementation SSAppVersionTool


// 获取保存的上一个版本信息
+ (NSString *)ss_GetLastOneAppVersion {
    
    return [[NSUserDefaults standardUserDefaults] stringForKey:@"AppVersion"];
}

// 保存新版本信息（偏好设置）
+ (void)ss_SaveNewAppVersion:(NSString *)version {
    
    [[NSUserDefaults standardUserDefaults] setObject:version forKey:@"AppVersion"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


@end
