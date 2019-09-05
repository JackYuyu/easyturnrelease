//
//  UIView+AHkit.h
//  AHKIt_CarMaid
//
//  Created by zhangMo on 2016/12/22.
//  Copyright © 2016年 AutoHome. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (AHkit)

/* frame.origin.x */
@property (nonatomic) CGFloat minX;

/* frame.origin.y */
@property (nonatomic) CGFloat minY;

/* frame.origin.x + frame.size.width */
@property (nonatomic) CGFloat maxX;

/* frame.origin.y + frame.size.height */
@property (nonatomic) CGFloat maxY;

/* frame.size.width */
@property (nonatomic) CGFloat width;

/* frame.size.height */
@property (nonatomic) CGFloat height;

/* center.x */
@property (nonatomic) CGFloat centerX;

/* center.y */
@property (nonatomic) CGFloat centerY;

/* Return the x coordinate on the screen */
@property (nonatomic, readonly) CGFloat ttScreenX;

/* Return the y coordinate on the screen */
@property (nonatomic, readonly) CGFloat ttScreenY;

/* Return the x coordinate on the screen, taking into account scroll views */
@property (nonatomic, readonly) CGFloat screenViewX;

/* Return the y coordinate on the screen, taking into account scroll views */
@property (nonatomic, readonly) CGFloat screenViewY;

/* Return the view frame on the screen, taking into account scroll views */
@property (nonatomic, readonly) CGRect screenFrame;

/* frame.origin */
@property (nonatomic) CGPoint origin;

/* frame.size */
@property (nonatomic) CGSize size;

/* center for bounds */
@property (nonatomic) CGPoint centerBounds;

- (UIView*)ak_subviewWithFirstResponder;
- (UIView*)ak_subviewWithClass:(Class)cls;
- (UIView*)ak_superviewWithClass:(Class)cls;
- (void)ak_removeAllSubviews;

/** 
 * 设置背景图片
 */
- (void)ak_setBackgroundImage:(UIImage *)image;
/** 
 * 设置背景视图
 */
- (void)ak_setBackgroundView:(UIView *)bgView;
/**
 * Super UIViewController
 */
- (UIViewController *)ak_viewController;

/**
 初始化一根线
 */
- (id)initLineWithFrame:(CGRect)frame color:(UIColor *)color;

/** 
 * 文字视图结构
 */
- (NSString *)ak_stringViewStruct;
/**
 * 图片视图结构
 */
- (NSMutableArray *)ak_imageViewStruct;
/**
 *  是否重叠
 */
- (BOOL)ak_isIntersectsWithView:(UIView *)view;

/**
 设置随机背景色
 */
- (void)ak_randomBackgroundColor;

/**
 设置随机背景色(可设置 alpha 通道)

 @param alpha CGFloat alpha 通道
 */
- (void)ak_randomBackgroundColorWithAlpha:(CGFloat)alpha;

/**
 给所有 subview 设置随机背景色
 */
- (void)ak_randomBackgroundColorForSubviews;


/**
 给一个 view 添加阴影
 
 @param shadowColor 阴影颜色
 @param shadowOffset 阴影 offset
 @param shadowOpacity 阴影透明度
 @param shadowRadius 阴影半径
 */
- (void)ak_addShadowWithColor:(UIColor*)shadowColor shadowOffset:(CGSize)shadowOffset shadowOpacity:(CGFloat)shadowOpacity shadowRadius:(CGFloat)shadowRadius;

#pragma mark - UIView 截屏功能
@property (nonatomic) BOOL isCapturing;

/**
 万能截取 View 中的内容

 @param completeBlock 返回图片的 block (主线程返回)
 */
- (void)ak_captureView:(void(^)(UIImage *image))completeBlock;

- (BOOL)ak_containsWKWebView;

/**
 * 截屏
 */
- (UIImage *)ak_screenshot;

/**
 添加圆角

 @param radius 设置圆角
 @return 圆角View
 */
- (UIView *)addCornerRadiusWithRadius:(CGFloat)radius;
- (UIView *)addBorderWithBorderColor:(UIColor*)borderColor andBorderWidth:(CGFloat)borderWidth;
- (UIView *)addBorderWithBorderColor:(UIColor*)borderColor borderWidth:(CGFloat)borderWidth cornerRadius:(CGFloat)cornerRadius;



/**
 绘制渐变色颜色

 @param view view
 @param fromHexColorStr 第一个颜色色值
 @param toHexColorStr 最后一个颜色色值
 @return 渐变颜色
 */
+ (CAGradientLayer *)setGradualChangingColor:(UIView *)view fromColor:(NSString *)fromHexColorStr toColor:(NSString *)toHexColorStr;


/**
 获取16进制颜色的方法

 @param hexColor 颜色rgb色值
 @return 16进制颜色
 */
+ (UIColor *)colorWithHex:(NSString *)hexColor;
@end
