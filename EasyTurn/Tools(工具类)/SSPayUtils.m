//
//  SSPayUtils.m
//  SSJewelry
//
//  Created by sszb on 2019/3/4.
//  Copyright © 2019 Song. All rights reserved.
//

#import "SSPayUtils.h"

@implementation SSPayUtils
static SSPayUtils * userManager = nil;

+(instancetype)allocWithZone:(struct _NSZone *)zone{
    static  dispatch_once_t once;
    dispatch_once(&once, ^{  //还有这里需要加&
        if (userManager == nil) {  //注意：这里不是if(userManager)
            userManager = [[super allocWithZone:zone] init];
            //为了保证属性的一致性，属性的初始化建议在这里执行
        }
    });
    return userManager;
}

+(SSPayUtils *)shareUser{
    return [[self alloc] init];
}
@end
