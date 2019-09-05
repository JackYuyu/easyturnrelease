//
//  NSString+AHKit.h
//  AHKIt_CarMaid
//
//  Created by zhangMo on 2016/12/19.
//  Copyright © 2016年 AutoHome. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (AHKit)

/** 
 * url 编码/解码
 */
- (NSString *)ak_encodeURL;
- (NSString *)ak_decodeURL;

/**
 * md5 编码
 */
- (NSString *)ak_md5;

/**
 * 3DES 加密
 */
- (NSString *)ak_encrypt3DES:(NSString *)key iv:(NSString *)iv;

/**
 * 3DES 解密
 */
- (NSString *)ak_decrypt3DES:(NSString *)key iv:(NSString *)iv;

/**
 3DES 加密

 @param secretKey 加密的 key
 @return 加密后的结果
 */
- (NSString *)ak_encrypt3DESWithSecretKey:(const void *)secretKey;

/**
 3DES 解密

 @param secretKey 解密的 key
 @return 解密后的结果
 */
- (NSString *)ak_decrypt3DESWithSecretKey:(const void *)secretKey;

/**
 * 字符串裁剪(去掉开头、结尾的空格和换行符)
 */
- (NSString *)ak_trim;

/**
 * 防止显示（null）
 */
- (NSString *)ak_dNull;
- (NSString *)ak_dNull:(NSString *)replace;

/** 
 * Json字符串转成字典
 */
- (NSDictionary *)ak_jsonToDictionary;

/**
 * 字符串替换
 */
- (NSString *)ak_replaceAllString:(NSString *)aBeReplacedString WithString:(NSString *)aReplacedString;

/**
 * 字符串中是否只包含汉字
 */
- (BOOL)ak_onlyHanZiCharacter;

/**
 * 手机号中间4位 **** 显示
 */
+ (NSString *)ak_getSecrectStringWithPhoneNumber:(NSString *)phoneNum;

/**
 * 数字三位分割
 */
+ (NSString *)ak_changeNumberFormat:(NSString *)num;

/**
 *  计算文本大小
 *  @param font 字体
 *  @return size
 */
- (CGSize)ak_sizeWithFontEX:(UIFont *)font;
- (CGSize)ak_sizeWithFontEX:(UIFont *)font constrainedToSize:(CGSize)size;
- (CGSize)ak_sizeWithFontEX:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode;

/**
 *  缓存文件大小
 */
- (unsigned long long)ak_fileSize;

/**
 *  NSDate 转成 NSString
 *  @param format  格式，如 @"yyyy-MM-dd HH:mm:ss"
 */
+ (NSString *)ak_stringFromDate:(NSDate *)date format:(NSString *)format;

/**
 *  对比当前时间
 *  @return @“刚刚” @“几小时前” @“几天前”
 */
+ (NSString *)ak_compareCurrentTime:(NSDate *)date;

/**
 *  计算相距今天的天数差
 */
+ (NSString *)ak_intervalSinceNow:(NSString *)string format:(NSString *)format;
- (NSString *)dateWithDifference;

/**
 *  获取字符串中首个汉字拼音的首字母(如果不是汉字, 则返回字符串中的首位)
 *  注意: 方法内会做 trim, 过滤字符串前后空格!
 */
- (NSString *)ak_firstUppercaseString;

/**
 *  获取字符串中所有字符的拼音(如果不是汉字, 则返回字符本身)
 *  注意: 方法内会做 trim, 过滤字符串前后空格!
 */
- (NSString *)ak_PinYinString;
/** nsinter字符串转number */
- (NSNumber *)numberString;
/** 验证是否手机号 */
- (BOOL)ak_validatePhone;
/** 隐藏手机号 */
- (NSString *)ak_hiddenPartNumber;
- (NSString *)stringValue;

/**
 * 复制到剪贴板
 */
- (void)ak_copyToPasteboard;
/**
 * 去除小数点后无效的 0 (如: 0.100 ---> 0.1)
 */
- (NSString *)ak_stringByTrimmingCharactersDeleteInvalidZeroAfterDecimalPoint;

/**
 处理数字增加(万 or 亿)单位的方法(例如: 10000 -> 1万)
 
 @param number 待处理数字
 @param scale 保留位数 (会自动处理小数点后的无效零 1.0万 -> 1万)
 @return 处理后的带单位的字符串
 */
+ (NSString *)ak_stringWithNumberAddUnitAutoDeleteInvalidZeroAfterDecimalPointWithNumber:(NSNumber *)number scale:(short)scale;

/**
 处理数字增加(万 or 亿)单位的方法(例如: 10000 -> @[@"1", @"万"])
 
 @param number 待处理数字
 @param scale 保留位数 (会自动处理小数点后的无效零 @[@"1.0", @"万"] -> @[@"1", @"万"])
 @return 处理后的字符串数组
 */
+ (NSArray<NSString *> *)ak_stringArrayWithNumberAddUnitAutoDeleteInvalidZeroAfterDecimalPointWithNumber:(NSNumber *)number scale:(short)scale;

@end
