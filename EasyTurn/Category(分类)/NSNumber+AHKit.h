//
//  NSNumber+AHKit.h
//  AHKit
//
//  Created by Sun Honglin on 17/2/8.
//  Copyright © 2017年 AutoHome. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (AHKit)

/** 转string字符串 */
- (NSString *)stringNumber;
/** 兼容web字符串和number传错 */
- (NSInteger)length;
/** 兼容web字符串和number传错 */
- (BOOL)isEqualToString:(NSString *)aString;

/**
 小数四舍五入方法

 @param value 处理前的值
 @param scale 保留的位数
 @return 处理后的值(注意: 保留位数的时候不补位)
 */
+ (NSNumber *)ak_numberWithFloat:(float)value scale:(short)scale;

/**
 小数四舍五入方法

 @param scale 保留的位数
 @return 处理后的值(注意: 保留位数的时候不补位)
 */
- (NSNumber *)ak_handleNumberWithScale:(short)scale;

@end
