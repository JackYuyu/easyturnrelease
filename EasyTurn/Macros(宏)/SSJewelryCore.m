//
//  SSJewelryCore.m
//  SSJewelry
//
//  Created by sszb on 2018/9/28.
//  Copyright © 2018 Song. All rights reserved.
//

#import "SSJewelryCore.h"
@implementation SSJewelryCore
/* 是否有效点击 */
static NSTimeInterval lastClickTime;
+ (BOOL)isValidClick
{
    return [SSJewelryCore isValidClick:0.3];
}

+ (BOOL)isValidClick:(NSTimeInterval)intervalTime
{
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
    if (fabs(time - lastClickTime) < intervalTime)
        return NO;
    lastClickTime = time;
    return YES;
}

#pragma mark - 图片处理
//使用颜色生成图片
+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size
{
    UIImage *img = nil;
    @autoreleasepool {
        CGRect rect = CGRectMake(0, 0, size.width, size.height);
        UIGraphicsBeginImageContext(rect.size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context,
                                       color.CGColor);
        CGContextFillRect(context, rect);
        img = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    return img;
}

+ (UIImage *)resizableImageWithColor:(UIColor *)color {
    return [SSJewelryCore resizableImageWithColor:color initialSize:CGSizeMake(4, 4) resizeEdge:UIEdgeInsetsMake(2, 2, 2, 2)];
}

+ (UIImage *)resizableImageWithColor:(UIColor *)color initialSize:(CGSize)size resizeEdge:(UIEdgeInsets)edgeInsets {
    UIImage *resizableImage = [[SSJewelryCore imageWithColor:color andSize:size] resizableImageWithCapInsets:edgeInsets resizingMode:UIImageResizingModeTile];
    return resizableImage;
}

#pragma mark 字符串 size 计算
+ (CGSize)sizeOfString:(NSString *)str fittingSize:(CGSize)fittingSize font:(UIFont *)font {
    NSMutableDictionary *attr = [NSMutableDictionary new];
    if (font) {
        [attr setValue:font forKey:NSFontAttributeName];
    }
    CGRect rect = [str boundingRectWithSize:fittingSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attr context:nil];
    return CGSizeMake(ceil(rect.size.width), ceil(rect.size.height)); //进位取整, 防止文字内带字母计算太极端问题
}

+ (CGSize)sizeOfString:(NSString *)str fittingSize:(CGSize)fittingSize font:(UIFont *)font lineSpaces:(CGFloat)lineSpaces {
    NSMutableDictionary *attr = [NSMutableDictionary new];
    if (font) {
        [attr setValue:font forKey:NSFontAttributeName];
    }
    if (lineSpaces) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = lineSpaces;
        [attr setValue:paragraphStyle forKey:NSParagraphStyleAttributeName];
    }
    
    CGRect rect = [str boundingRectWithSize:fittingSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attr context:nil];
    return CGSizeMake(ceil(rect.size.width), ceil(rect.size.height)); //进位取整, 防止文字内带字母计算太极端问题
}

+ (CGSize)sizeOfAttributedString:(NSAttributedString *)str fittingSize:(CGSize)fittingSize {
    CGRect rect = [str boundingRectWithSize:fittingSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
    return CGSizeMake(ceil(rect.size.width), ceil(rect.size.height)); //进位取整, 防止文字内带字母计算太极端问题
}

#pragma mark - 判断字符串格式
/** 验证是否全为数字 **/
+ (BOOL)isValidateNumbers:(NSString *)numbers{
    NSString *numberRegex = @"^[0-9]+$";
    NSPredicate *numbersTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", numberRegex];
    return [numbersTest evaluateWithObject:numbers];
}

/** 验证是否合法的手机号 **/
+ (BOOL)isValidateMobile:(NSString *)mobile
{
    //    NSString *numberRegex = @"^[0-9]{11}";
    //手机号以13， 15，17, 18开头，八个 \d 数字字符
    /**
     * 移动号段: 134,135,136,137,138,139,147,148,150,151,152,157,158,159,172,178,182,183,184,187,188,198,1705
     * 联通号段: 130,131,132,145,146,155,156,166,171,175,176,185,186,1709
     * 电信号段: 133,149,153,173,174,177,180,181,189,199,1700
     * 虚拟号: 170
     * update: 2017-12-07
     */
    NSString *phoneRegex = @"^(1((3[0-9])|(4[0-9])|(5[0-9])|(6[0-9])|(7[0-9])|(8[0-9])|(9[0-9])))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    //    NSLog(@"phoneTest is %@",phoneTest);
    return [phoneTest evaluateWithObject:mobile];
}

#pragma 正则匹配用户密码6-8位数字和字母组合
+ (BOOL)checkPassword:(NSString *) password
{
    NSString *passwordRegex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,8}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", passwordRegex];
    BOOL isMatch = [pred evaluateWithObject:password];
    return isMatch;
     
}

#pragma 正则匹配昵称2-8位
+ (BOOL) validateNickname:(NSString *)nickname
{
    
    NSString *nicknameRegex = @"^[\u4e00-\u9fa5]{2,8}$";
    
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    
    return [passWordPredicate evaluateWithObject:nickname];
}

@end
