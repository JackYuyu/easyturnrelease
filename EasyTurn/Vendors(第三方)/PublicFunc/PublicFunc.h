//
//  PublicFunc.h
//  DaDaAutoLease
//
//  Created by august on 14-9-19.
//  Copyright (c) 2014年 Logicsolutions.Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

@interface PublicFunc : NSObject

+ (PublicFunc *)shareInstance;

//判断手机号码是否有效
+ (BOOL)isValidPhone:(NSString*)value;
//只能是数字或字母
+ (BOOL)isValidPasswordFormat:(NSString*)value;
//carl
+ (BOOL)matchString:(NSString *)aString withRegular:(NSString *)regular error:(NSError **)error;

+ (MBProgressHUD *)MBhud:(NSString *)labelText view:(UIView *)view;

+ (MBProgressHUD *)MBWaitHud:(NSString *)labelText view:(UIView *)view;

+ (MBProgressHUD *)MBCompleteHud:(NSString *)labelText view:(UIView *)view Success:(BOOL)suceess;

+ (NSString*)getPreferredLanguage;

+ (CGSize)content:(NSString *)content font:(UIFont *)font maxSize:(CGSize)maxSize alignment:(NSTextAlignment)alignment linebreak:(NSLineBreakMode)lineBreak;

//动态计算字符串高度
+ (CGFloat) textHeightFromString:(NSString *)textStr width:(CGFloat)width fontsize:(CGFloat)Size;

//动态计算字符串宽度
+ (CGFloat)textWidthFromString:(NSString *)textStr height:(CGFloat)height fontsize:(CGFloat)Size;

+ (UIImage *)imageWithColor:(UIColor *)color;

+ (UIButton *)setButtonContentCenter:(UIButton *)btn heightSpace:(CGFloat)space;

+ (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size;

//创建button
+ (UIButton *)creatButtonWithFrame:(CGRect)frame
                            target:(id)target
                               sel:(SEL)sel
                               tag:(NSInteger)tag
                             image:(NSString *)name
                             title:(NSString *)title
                          distance:(NSInteger)distance
                         titleFont:(NSInteger)font;

+ (NSString* )returnCurrentDay;

//获取当前的时间
+(NSString*)getCurrentTime;

//获取当前时间戳
+(NSString *)getNowTimeTimestamp;

//获取当前的时间，精确到分钟
+(NSString*)getCurrentMinuteTime;

//获取当前的时间，精确到秒
+(NSString*)getCurrentSecondTime;

//判断内容是否全部为空格 yes 全部为空格 no 不是
+ (BOOL)isEmpty:(NSString *)str;

//计算一个月的总天数
+ (NSInteger)daysInthisMonth:(NSDate *)date;

+ (NSString *)subStringFromString:(NSString *)wholeString start:(NSString *)startString end:(NSString *)endString;

+ (NSString* )returnLastDay;

/**
 十进制转换十六进制
 
 @param decimal 十进制数
 @return 十六进制数
 */
+ (NSString *)getHexByDecimal:(NSInteger)decimal;

+ (NSNumber *)numberHexString:(NSString *)aHexString;

+ (BOOL)isEmailAddress:(NSString *)email;

+ (NSString *)md5:(NSString *)str;

//字典转json格式字符串：
+ (NSString*)dictionaryToJson:(NSDictionary *)dic;

//获取相应月数的日期
+(NSDate *)getPriousorLaterDateFromDate:(NSDate *)date withMonth:(int)month;

+ (NSString *)returenNewArray:(NSArray *)BWW;

+ (BOOL)stringContainsEmoji:(NSString *)string;

//计算两个日期之间的天数
+ (NSInteger) calcDaysFromBegin:(NSDate *)beginDate end:(NSDate *)endDate;

+(NSString*) getLocalAppVersion;

+ (BOOL)validateNumberByRegExp:(NSString *)string;

+(NSData*)stringToByte:(NSString*)string;

+ (NSInteger)getSumOfDaysInMonth:(NSString *)year month:(NSString *)month;

+ (NSString *)STLocalizedString:(NSString *)String;

+ (NSString *)timespToUTCFormat:(NSString *)timesp;

+ (NSString *)instructionToFormat:(NSString *)string;

//将可能存在model数组或字典转化为普通数组
+ (id)arrayOrDicWithObject:(id)origin;

+ (NSString *)timespToUTCSSSFormat:(NSString *)timesp;
    
+ (NSString *)translateTimestampFormat:(NSString *)realtime;

//中文汉字转为阿拉伯数字
+ (NSString *)arabicNumberalsFromChineseNumberals:(NSString *)arabic;

//英文汉字转为阿拉伯数字
+ (NSString *)arabicNumberalsFromEnglishNumberals:(NSString *)arabic;

//正则判断是否为阿拉伯数字
+ (BOOL)isNumText:(NSString *)str;

@end

