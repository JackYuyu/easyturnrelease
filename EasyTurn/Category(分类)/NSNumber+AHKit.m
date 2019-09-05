//
//  NSNumber+AHKit.m
//  AHKit
//
//  Created by Sun Honglin on 17/2/8.
//  Copyright © 2017年 AutoHome. All rights reserved.
//

#import "NSNumber+AHKit.h"

@implementation NSNumber (AHKit)

- (NSString *)stringNumber {
    
    NSString *aString = @"";
    if (strcmp([self objCType], @encode(float)) == 0)
    {
        aString = [NSString stringWithFormat:@"%.2f", [self floatValue]];
    }
    else if (strcmp([self objCType], @encode(double)) == 0)
    {
        aString = [NSString stringWithFormat:@"%.2f", [self floatValue]];
    }
    else if (strcmp([self objCType], @encode(int)) == 0)
    {
        aString = [NSString stringWithFormat:@"%d", [self intValue]];
        
    } else if (strcmp([self objCType], @encode(long)) == 0) {
        
        aString = [NSString stringWithFormat:@"%ld", [self longValue]];
    }
    else if (strcmp([self objCType], @encode(long long)) == 0) {
        
        aString = [NSString stringWithFormat:@"%lld", [self longLongValue]];
        
    } else if (strcmp([self objCType], @encode(bool)) == 0) {
        
        aString = [NSString stringWithFormat:@"%d", [self boolValue]];
        
    } else if (strcmp([self objCType], @encode(char)) == 0) {
        
        aString = [NSString stringWithFormat:@"%c",[self charValue]];
    } else if (strcmp([self objCType], @encode(short)) == 0) {
        
        aString = [NSString stringWithFormat:@"%u",[self shortValue]];
    }
    return aString;
    
}
/** 新加 */
- (NSInteger)length {
    return [[self stringValue] length];
}

- (BOOL)isEqualToString:(NSString *)aString {
    return [[self stringValue] isEqualToString:aString];
}

+ (NSNumber *)ak_numberWithFloat:(float)value scale:(short)scale {
    return [[NSNumber numberWithFloat:value] ak_handleNumberWithScale:scale];
}

- (NSNumber *)ak_handleNumberWithScale:(short)scale {
    /**
     roundingMode:
        NSRoundPlain: 四舍五入
        NSRoundDown: 只舍不入
        NSRoundUp: 只入不舍
        NSRoundBankers: 四舍六入, 中间值时, 取最近的,保持保留最后一位为偶数 (21.625 保留 2 位会有问题)
     scale: 小数点后保留的位数
     */
    NSDecimalNumberHandler *numberHandler = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:scale raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    NSDecimalNumber *decimalNumber = [NSDecimalNumber decimalNumberWithString:[self stringValue]];
    return [decimalNumber decimalNumberByRoundingAccordingToBehavior:numberHandler];
}

@end
