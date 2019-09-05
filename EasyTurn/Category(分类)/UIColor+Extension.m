//
//  UIColor+Extension.m
//  DATABK
//
//  Created by 任长平 on 2017/3/22.
//  Copyright © 2017年 任长平. All rights reserved.
//

#import "UIColor+Extension.h"

@implementation UIColor (Extension)
+ (UIColor *)xm_MainColor{
    return [UIColor xm_colorFromRGB:0x1B88EE alpha:1.0];
//  return XMColor(63, 181, 233);
}
/** 浅黑色 999999 */
+ (UIColor *)xm_somberColor{
    return [UIColor xm_colorFromRGB:0x999999 alpha:1.0];
}

/** 浅黑色 666666 */
+ (UIColor *)xm_middleColor{
    return [UIColor xm_colorFromRGB:0x666666 alpha:1.0];
}

/** 深黑色 333333 */
+ (UIColor *)xm_jetblackColor{
    return [UIColor xm_colorFromRGB:0x333333 alpha:1.0];
}

+ (UIColor *)xm_NavigationColor{
    return [UIColor xm_MainColor];
}
+ (UIColor *)xm_BackColor{
    return [self xm_colorFromRGB:0x6d777e alpha:0.5];
}
+ (UIColor *)xm_grayColor{
    return [UIColor xm_colorFromRGB:0xF2F2F2];
}
+ (UIColor *)xm_orangeColor{
    return [UIColor xm_colorFromRGB:0xF58323];
}
+ (UIColor *)xm_splitlineColor{
    return [UIColor xm_colorFromRGB:0xF6F6F6];
}
+(UIColor *)xm_colorFromRGB:(uint32_t)rgbValue{
    return [UIColor xm_colorFromRGB:rgbValue alpha:1.0];
}

+(UIColor *)xm_colorFromRGB:(uint32_t)rgbValue alpha:(CGFloat)alpha{
    return  [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0
                            green:((float)((rgbValue & 0xFF00) >> 8))/255.0
                             blue:((float)(rgbValue & 0xFF))/255.0
                            alpha:alpha];
}



@end
