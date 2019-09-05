//
//  UIButton+AHKit.h
//  AHKIt_CarMaid
//
//  Created by zhangMo on 2016/12/22.
//  Copyright © 2016年 AutoHome. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  图片文字按钮对齐方式
 */
typedef NS_ENUM(NSUInteger, UIButtonAlignment) {
    UIButtonAlignmentLeft = 1,//左对齐
    UIButtonAlignmentRight = 2//右对齐
};

@interface UIButton (AHKit)
/**
 *  保持图片不变形，从坐标点调整偏移
 */
- (UIEdgeInsets)ak_setImageEdgeInsetsFromOriginOffSet:(CGVector)vector imageSize:(CGSize)size;
/**
 *  保持图片不变形，从中心点调整偏移
 */
- (UIEdgeInsets)ak_setImageEdgeInsetsFromCenterOffSet:(CGVector)vector imageSize:(CGSize)size;

/**
 *  图片对齐方式
 *  参数 alignment  UIButtonAlignment
 *  参数 space      图片和文字空隙
 */
- (void)ak_sizeToFitAlignment;//默认右对齐，间隙5
- (void)ak_sizeToFitAlignment:(UIButtonAlignment)alignment;
- (void)ak_sizeToFitAlignment:(UIButtonAlignment)alignment space:(CGFloat)space;

/**
 *  设置Button不同状态设置背景色
 */
- (void)ak_setImageBackgroundColor:(UIColor *)backgroundColor forStatus:(UIControlState)state;

/**
 *  扩大 UIButton 的點擊範圍
 *  控制上下左右的延長範圍
 *
 *  @param top    <#top description#>
 *  @param right  <#right description#>
 *  @param bottom <#bottom description#>
 *  @param left   <#left description#>
 */
- (void)ak_setEnlargeEdgeWithTop:(CGFloat)top right:(CGFloat)right bottom:(CGFloat)bottom left:(CGFloat)left;


@end
