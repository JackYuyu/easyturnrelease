//
//  DCAppVersionTool.h
//  CDDStoreDemo
//
//  Created by 陈甸甸 on 2017/12/20.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface SSAppVersionTool : NSObject

/**
 *  获取之前保存的版本
 *
 *  @return NSString类型的AppVersion
 */
+ (NSString *)ss_GetLastOneAppVersion;
/**
 *  保存新版本
 */
+ (void)ss_SaveNewAppVersion:(NSString *)version;


@end
