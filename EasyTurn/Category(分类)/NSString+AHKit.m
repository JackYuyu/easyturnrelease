//
//  NSString+AHKit.m
//  AHKIt_CarMaid
//
//  Created by zhangMo on 2016/12/19.
//  Copyright © 2016年 AutoHome. All rights reserved.
//

#import "NSString+AHKit.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
#import "NSNumber+AHKit.h"

@implementation NSString (AHKit)

- (NSString *)ak_encodeURL {
    NSString *newString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)self, NULL, CFSTR(":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`"), kCFStringEncodingUTF8 ));
    if (newString) {
        return newString;
    }
    return @"";
}

- (NSString *)ak_decodeURL {
    return [self stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *)ak_md5 {
    const char *cStr = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
        [hash appendFormat:@"%02X", result[i]];
    return [hash lowercaseString];
}

- (NSString *)ak_encrypt3DES:(NSString *)key iv:(NSString *)iv {
    NSData      *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    size_t      plainTextBufferSize = [data length];
    const void  *vplainText = (const void *)[data bytes];
    
    CCCryptorStatus ccStatus;
    uint8_t         *bufferPtr = NULL;
    size_t          bufferPtrSize = 0;
    size_t          movedBytes = 0;
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    bufferPtr = malloc(bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    
    const void  *vkey = (const void *)[key UTF8String];
    const void  *vinitVec = (const void *)[iv UTF8String];
    
    ccStatus = CCCrypt(kCCEncrypt,
                       kCCAlgorithm3DES,
                       kCCOptionPKCS7Padding,
                       vkey,
                       kCCKeySize3DES,
                       vinitVec,
                       vplainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    
//    NSData      *myData = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes];
//    NSString    *result = [AHBase64 encode:myData];
    NSString    *result = nil;
    
    free(bufferPtr);
    
    return result;
}

- (NSString *)ak_decrypt3DES:(NSString *)key iv:(NSString *)iv {
//    NSData      *encryptData = [AHBase64 decode:self];
    NSData      *encryptData = nil;
    size_t      plainTextBufferSize = [encryptData length];
    const void  *vplainText = [encryptData bytes];
    
    CCCryptorStatus ccStatus;
    uint8_t         *bufferPtr = NULL;
    size_t          bufferPtrSize = 0;
    size_t          movedBytes = 0;
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    bufferPtr = malloc(bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    
    const void  *vkey = (const void *)[key UTF8String];
    const void  *vinitVec = (const void *)[iv UTF8String];
    
    ccStatus = CCCrypt(kCCDecrypt,
                       kCCAlgorithm3DES,
                       kCCOptionPKCS7Padding,
                       vkey,
                       kCCKeySize3DES,
                       vinitVec,
                       vplainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    
    NSString *result = [[NSString alloc] initWithData:[NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes] encoding:NSUTF8StringEncoding];
    
    free(bufferPtr);
    
    return result;
}

- (NSString *)ak_encrypt3DESWithSecretKey:(const void *)secretKey {
    NSData *encryptData = [self dataUsingEncoding:NSUTF8StringEncoding];
    size_t plainTextBufferSize = [encryptData length];
    const void *vplainText = [encryptData bytes];
    
    CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    
    ccStatus = CCCrypt(kCCEncrypt,
                       kCCAlgorithm3DES,
                       kCCOptionPKCS7Padding | kCCOptionECBMode,
                       secretKey,
                       kCCKeySize3DES,
                       nil,
                       vplainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    
//    NSData *dataResult = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes];
//    NSString *strResult = [GTMBase64 stringByEncodingData:dataResult];
    NSString *strResult = nil;
    
    free(bufferPtr);
    
    return strResult;
}

- (NSString *)ak_decrypt3DESWithSecretKey:(const void *)secretKey {
//    NSData *decryptData = [GTMBase64 decodeData:[self dataUsingEncoding:NSUTF8StringEncoding]];
    NSData *decryptData = nil;
    size_t plainTextBufferSize = [decryptData length];
    const void *vplainText = [decryptData bytes];
    
    CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    
    ccStatus = CCCrypt(kCCDecrypt,
                       kCCAlgorithm3DES,
                       kCCOptionPKCS7Padding | kCCOptionECBMode,
                       secretKey,
                       kCCKeySize3DES,
                       nil,
                       vplainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    
    NSData *dataResult = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes];
    NSString *strResult = [[NSString alloc] initWithData:dataResult encoding:NSUTF8StringEncoding];
    
    free(bufferPtr);
    
    return strResult;
}

- (NSString *)ak_trim {
   return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)ak_dNull {
    return (self.length > 0 ? self : @"");
}

- (NSString *)ak_dNull:(NSString *)replace {
    return (self.length > 0 ? self :replace);
}

- (NSDictionary *)ak_jsonToDictionary {
    if ([NSJSONSerialization isValidJSONObject:self]) {
        return [NSJSONSerialization JSONObjectWithData:[self dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
    } else {
        return [NSDictionary dictionary];
    }
}

- (NSString *)ak_replaceAllString:(NSString *)aBeReplacedString
                    WithString:(NSString *)aReplacedString {
    NSMutableString *theString = [NSMutableString stringWithString:self];
    [theString replaceOccurrencesOfString:aBeReplacedString
                               withString:aReplacedString
                                  options:NSCaseInsensitiveSearch
                                    range:NSMakeRange(0, theString.length)];
    return [NSString stringWithString:theString];
}

- (BOOL)ak_onlyHanZiCharacter {
    BOOL isCharacter = YES;
    for (int i = 0; i < [self length]; i++ ){
        
        NSRange range = NSMakeRange(i,1);
        
        NSString *subString=[self substringWithRange:range];
        
        const char *cString=[subString UTF8String];
        
        if (strlen(cString) != 3) {
            isCharacter = NO;
            break;
        }
    }
    return isCharacter;
}

+ (NSString *)ak_getSecrectStringWithPhoneNumber:(NSString *)phoneNum {
    if (!(phoneNum && phoneNum.length == 11)) return phoneNum;
    NSMutableString *newStr = [NSMutableString stringWithString:phoneNum];
    NSRange range = NSMakeRange(3, 4);
    [newStr replaceCharactersInRange:range withString:@"****"];
    return newStr;
}

+ (NSString *)ak_changeNumberFormat:(NSString *)num {
    if (!num) {
        return @"";
    }
    
    //整数
    NSString* str11;
    //小数点之后的数字
    NSString* str22;
    
    if ([num containsString:@"."]) {
        NSArray* array = [num componentsSeparatedByString:@"."];
        str11 = array[0];
        str22 = array[1];
    }else{
        str11 = num;
    }

    int count = 0;
    long long int a = str11.longLongValue;
    while (a != 0)
    {
        count++;
        a /= 10;
    }
    NSMutableString *string = [NSMutableString stringWithString:str11];
    NSMutableString *newstring = [NSMutableString string];
    while (count > 3) {
        count -= 3;
        NSRange rang = NSMakeRange(string.length - 3, 3);
        NSString *str = [string substringWithRange:rang];
        [newstring insertString:str atIndex:0];
        [newstring insertString:@"," atIndex:0];
        [string deleteCharactersInRange:rang];
    }
    [newstring insertString:string atIndex:0];
    
    if ([num containsString:@"."]) {
        //包含小数点
        //返回的数字
        NSString* str33;
        
        if (str22.length>0) {
            //小数点后面有数字
            str33 = [NSString stringWithFormat:@"%@.%@",newstring,str22];
        }else{
            //没有数字
            str33 = [NSString stringWithFormat:@"%@",newstring];
        }
        return str33;
    }else{
        //不包含小数点
        return newstring;
    }
}

#pragma mark - 计算文本大小
- (CGSize)ak_sizeWithFontEX:(UIFont *)font {
    NSMutableDictionary *attr = [NSMutableDictionary dictionaryWithCapacity:10];
    [attr setValue:font forKey:NSFontAttributeName];
    CGSize textSize = [self sizeWithAttributes:attr];
    return textSize;
}

- (CGSize)ak_sizeWithFontEX:(UIFont *)font constrainedToSize:(CGSize)size {
    return  [self ak_sizeWithFontEX:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
}

- (CGSize)ak_sizeWithFontEX:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode {
    NSMutableDictionary *attr = [NSMutableDictionary dictionaryWithCapacity:10];
    if (font) {
        [attr setValue:font forKey:NSFontAttributeName];
    }
    if (lineBreakMode) {
        NSMutableParagraphStyle *ps = [[NSMutableParagraphStyle alloc] init];
        [ps setLineBreakMode:NSLineBreakByCharWrapping];
        [attr setValue:ps forKey:NSParagraphStyleAttributeName];
    }
    CGRect rect = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attr context:nil];
    return CGSizeMake(ceil(rect.size.width), ceil(rect.size.height)); //进位取整, 防止文字内带字母计算太极端问题
}

#pragma mark - 文件 相关
- (unsigned long long)ak_fileSize {
    unsigned long long cacheSize = 0;
    
    NSFileManager *manager = [NSFileManager defaultManager];
    
    
    BOOL isDirectory = NO;
    BOOL isExists = [manager fileExistsAtPath:self isDirectory:&isDirectory];
    
    if (!isExists) return 0;
    
    if (isDirectory) {
        NSDirectoryEnumerator *enumerator = [manager enumeratorAtPath:self];
        for (NSString *subpath in enumerator) {
            NSString *fullPath = [self stringByAppendingPathComponent:subpath];
            cacheSize += [manager attributesOfItemAtPath:fullPath error:nil].fileSize;
        }
    } else {
        cacheSize = [manager attributesOfItemAtPath:self error:nil].fileSize;
    }
    
    return cacheSize;
}

#pragma mark - NSDate 相关
+ (NSDateFormatter *)ak_defaultDateFormatter {
    static NSDateFormatter *dateFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
    });
    return dateFormatter;
}

+ (NSString *)ak_stringFromDate:(NSDate *)date format:(NSString *)format {
    NSDateFormatter *dateFormatter = [self ak_defaultDateFormatter];
    [dateFormatter setDateFormat:format];
    NSString *dateStr = [dateFormatter stringFromDate:date];
    return dateStr;
}

+ (NSString *)ak_compareCurrentTime:(NSDate *)date {
    NSTimeInterval timeInterval = [date timeIntervalSinceNow];
    timeInterval = -timeInterval;
    long temp = 0;
    NSString *result;
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
    }
    else if((temp = timeInterval/60) < 60){
        result = [NSString stringWithFormat:@"%ld分前",temp];
    }
    else if((temp = temp/60) < 24){
        result = [NSString stringWithFormat:@"%ld小时前",temp];
    }
    else if((temp = temp/24) < 30){
        result = [NSString stringWithFormat:@"%ld天前",temp];
    }
    else {
        result = [NSString ak_stringFromDate:date format:@"yyyy-MM-dd"];
    }
    return result;
}

+ (NSString *)ak_intervalSinceNow:(NSString *)string format:(NSString *)format {
    NSDateFormatter *dateFormatter = [self ak_defaultDateFormatter];
    [dateFormatter setDateFormat:format];
    NSDate *date = [dateFormatter dateFromString:string];
    NSDate *currentDate = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitDay;
    NSDateComponents *dateCom = [calendar components:unit fromDate:date toDate:currentDate options:0];
    NSString *timeString = [NSString stringWithFormat:@"%ld天",(long)dateCom.day];
    return timeString;
}

- (NSString *)dateWithDifference{
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    NSDate *validDate= [dateFormatter dateFromString:self];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:NSCalendarUnitDay
                                               fromDate:currentDate
                                                 toDate:validDate
                                                options:0];
    
    return [NSString stringWithFormat:@"%li",(long)components.day];
}

- (NSString *)ak_firstUppercaseString {
    
    NSString *strTrimResult = self.ak_trim;
    
    if (!(strTrimResult && strTrimResult.length > 0)) return nil;
    
    NSMutableString *strTemp = [NSMutableString stringWithString:strTrimResult];
    CFStringTransform((__bridge CFMutableStringRef)strTemp, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((__bridge CFMutableStringRef)strTemp, NULL, kCFStringTransformStripDiacritics, NO);
    NSString *strUppercaseString = [[strTemp uppercaseString] stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if (strUppercaseString && strUppercaseString.length > 0) {
        return [strUppercaseString substringToIndex:1];
    }
    
    return nil;
}


- (NSString *)ak_PinYinString {
    NSString *strTrimResult = self.ak_trim;
    
    if (!(strTrimResult && strTrimResult.length > 0)) return nil;
    
    NSMutableString *strTemp = [NSMutableString stringWithString:strTrimResult];
    CFStringTransform((__bridge CFMutableStringRef)strTemp, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((__bridge CFMutableStringRef)strTemp, NULL, kCFStringTransformStripDiacritics, NO);
    return [[strTemp uppercaseString] stringByReplacingOccurrencesOfString:@" " withString:@""];
}
/** 新增ahkit */
- (NSNumber *)numberString {
    return [NSNumber numberWithInteger:[self integerValue]];
}
- (BOOL)ak_validatePhone {
    if (self) {
        NSString* number = @"^1([0-9]){10}$";
        NSPredicate *numberPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",number];
        return [numberPre evaluateWithObject:self];
    }
    return NO;
    
}
- (NSString *)ak_hiddenPartNumber {
    if ([self length] == 11) {
        NSString *sFrist = [self substringToIndex:3];
        NSString *sLast = [self substringFromIndex:7];
        return  [NSString stringWithFormat:@"%@****%@",sFrist,sLast];
    }
    return self;
}
- (NSString *)stringValue {
    return self;
}

////消息转发
//- (void)forwardInvocation:(NSInvocation *)invocation {
//    NSLog(@"******NSString有不能处理的方法%@已兼容不Crash请处理*****",invocation);
//    if ([self respondsToSelector:[invocation selector]]) {
//        
//        [invocation invokeWithTarget:self];
//    }
//}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector {
    NSMethodSignature *sig = [[NSString class] instanceMethodSignatureForSelector:selector];
    if(sig == nil) {
        sig = [NSMethodSignature signatureWithObjCTypes:"@^v^c"];
    }
    return sig;
}

- (void)ak_copyToPasteboard {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self;
}

- (NSString *)ak_stringByTrimmingCharactersDeleteInvalidZeroAfterDecimalPoint {
    NSArray<NSString *> *arrComponents = [self componentsSeparatedByString:@"."];
    if ([self hasPrefix:@"."] || !(arrComponents.count && arrComponents.count == 2)) return self;
    
    NSString *strResult = @"";
    
    NSString *strLastComponent = arrComponents.lastObject;
    if (strLastComponent && strLastComponent.length) {
        NSMutableString *strTemp = [NSMutableString stringWithString:strLastComponent];
        BOOL isHasZero = YES;
        while (isHasZero) {
            if ([strTemp hasSuffix:@"0"]) {
                [strTemp deleteCharactersInRange:NSMakeRange(strTemp.length - 1, 1)];
            } else {
                isHasZero = NO;
            }
        }
        strResult = strTemp.length ? [NSString stringWithFormat:@"%@.%@", arrComponents.firstObject, strTemp] : arrComponents.firstObject;
    } else {
        strResult = arrComponents.firstObject;
    }
    
    return strResult;
}

+ (NSString *)ak_stringWithNumberAddUnitAutoDeleteInvalidZeroAfterDecimalPointWithNumber:(NSNumber *)number scale:(short)scale {
    return [[self ak_stringWithNumberAddUnitWithNumber:number scale:scale isNeedDeleteInvalidZeroAfterDecimalPoint:YES] componentsJoinedByString:@""];
}

+ (NSArray<NSString *> *)ak_stringArrayWithNumberAddUnitAutoDeleteInvalidZeroAfterDecimalPointWithNumber:(NSNumber *)number scale:(short)scale {
    return [self ak_stringWithNumberAddUnitWithNumber:number scale:scale isNeedDeleteInvalidZeroAfterDecimalPoint:YES];
}

// 目前 isNeedDeleteInvalidZeroAfterDecimalPoint 只支持传 YES, 传 NO 有问题, ak_handleNumberWithScale 方法中, 系统直接过滤了无效的 0 了
+ (NSArray<NSString *> *)ak_stringWithNumberAddUnitWithNumber:(NSNumber *)number scale:(short)scale isNeedDeleteInvalidZeroAfterDecimalPoint:(BOOL)isNeedDeleteInvalidZeroAfterDecimalPoint {
    if (![number isKindOfClass:[NSNumber class]]) return nil;
    float waitHandleNumber = [number floatValue];
    NSString *strResult = nil;
    NSString *strUnit = nil;
    NSMutableArray<NSString *> *arrResult = [NSMutableArray array];
    if (waitHandleNumber >= 100000000.0) {
        waitHandleNumber = (waitHandleNumber / 100000000.0);
        strUnit = @"亿";
    } else if (waitHandleNumber >= 10000.0) {
        waitHandleNumber = (waitHandleNumber / 10000.0);
        strUnit = @"万";
    }
    strResult = [[[NSNumber numberWithFloat:waitHandleNumber] ak_handleNumberWithScale:scale] stringValue];
    if ([strUnit isEqualToString:@"万"] && [strResult floatValue] >= 10000.0) {
        strUnit = @"亿";
        strResult = [[[NSNumber numberWithFloat:([strResult floatValue] / 10000.0)] ak_handleNumberWithScale:scale] stringValue];;
    }
    if (isNeedDeleteInvalidZeroAfterDecimalPoint) {
        strResult = [strResult ak_stringByTrimmingCharactersDeleteInvalidZeroAfterDecimalPoint];
    }
    strResult = (strResult && strResult.length) ? strResult : @"";
    [arrResult addObject:strResult];
    if (strUnit && strUnit.length) [arrResult addObject:strUnit];
    return arrResult;
}


@end
