//
//  UIColor+Extension.h
//  DATABK
//
//  Created by 任长平 on 2017/3/22.
//  Copyright © 2017年 任长平. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Extension)
/**app主色调*/
+ (UIColor *)xm_MainColor;
/** 浅黑色 999999 */
+ (UIColor *)xm_somberColor;

/** 浅黑色 666666 */
+ (UIColor *)xm_middleColor;

/** 深黑色 333333 */
+ (UIColor *)xm_jetblackColor;
/** 灰色背景 */
+ (UIColor *)xm_grayColor;

/** 橙色 */
+ (UIColor *)xm_orangeColor;

/** 主要用于cell 的分割线颜色 */
+ (UIColor *)xm_splitlineColor;
/** 黑色背景 透明度为0.5 */
+ (UIColor *)xm_BackColor;

+ (UIColor *)xm_NavigationColor;

+ (UIColor *)xm_colorFromRGB:(uint32_t)rgbValue;

+ (UIColor *)xm_colorFromRGB:(uint32_t)rgbValue alpha:(CGFloat)alpha;

@end
