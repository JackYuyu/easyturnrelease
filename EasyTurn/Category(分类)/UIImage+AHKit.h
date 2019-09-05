//
//  UIImage+AHKit.h
//  AHKIt_CarMaid
//
//  Created by zhangMo on 2016/12/26.
//  Copyright © 2016年 AutoHome. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Accelerate/Accelerate.h>
#import <float.h>

@interface UIImage (AHKit)

/**
 * 使用颜色生成图片
 */
+ (UIImage *)ak_createImageWithColor:(UIColor *)color;
+ (UIImage *)ak_imageWithColor:(UIColor *)color size:(CGSize)size;
+ (UIImage *)ak_imageWithColor:(UIColor *)color triangleSize:(CGSize)size;
+ (UIImage *)ak_imageWithColor:(UIColor *)color roundSize:(CGSize)size;
+ (UIImage *)ak_resizableImageWithColor:(UIColor *)color;
+ (UIImage *)ak_resizableImageWithColor:(UIColor *)color initialSize:(CGSize)size resizeEdge:(UIEdgeInsets)edgeInsets;

+ (UIImage *)ak_imageWithText:(NSString *)text
                         font:(UIFont *)textFont
                        color:(UIColor *)textColor
              backgroundColor:(UIColor *)backgroundColor
                    roundSize:(CGSize)roundSize;
/**
 根据文字,生成相应图片

 @param text 文字内容
 @param textFont 文字字体
 @param textColor 文字颜色
 @param backgroundColor 图片背景色
 @param frame 图片大小
 @param radius 圆角大小, 不需要圆角传 0.0
 @return 图片
 */
+ (UIImage *)ak_imageWithText:(NSString *)text
                         font:(UIFont *)textFont
                        color:(UIColor *)textColor
              backgroundColor:(UIColor *)backgroundColor
                        frame:(CGRect)frame
                 cornerRadius:(CGFloat)radius;

/**
 * 图片缩放操作
 */
- (UIImage *)ak_originImageScaleToSize:(CGSize)size;
- (UIImage *)ak_imageToSize:(CGSize)size andScaleWidth:(CGFloat)scaleWidth andScaleHeight:(CGFloat)scaleHeight;
- (UIImage *)ak_imageTo4b3;
- (UIImage *)ak_imageTo4b3AtSize:(CGSize)size;
- (UIImage *)ak_imageAtRect:(CGRect)rect;
- (UIImage *)ak_imageToScale:(float)scale;
- (UIImage *)ak_imageToSize:(CGSize)size;
- (UIImage *)ak_scaleToSize:(CGSize)size;

- (UIImage *)ak_fixCameraOrientation;

/**
 * 图片 添加/合并/旋转/剪切 操作
 */
+ (UIImage *)ak_addImage:(UIImage *)image1 toImage:(UIImage *)image2 andSize:(CGSize)size;
+ (UIImage *)ak_mergerImage1:(UIImage *)image1 image2:(UIImage *)image2 toSize:(CGSize)toSize;
- (UIImage *)ak_addImage:(UIImage *)image point:(CGPoint)point;
- (UIImage *)ak_addImage:(UIImage *)image point:(CGPoint)point scale:(CGFloat)scale;
- (UIImage *)ak_imageRotatedByRadians:(CGFloat)radians;
- (UIImage *)ak_imageRotatedByDegrees:(CGFloat)degrees;
- (UIImage *)ak_imageByScalingAndCroppingForSize:(CGSize)targetSize;
- (UIImage *)ak_subImageOfViewFrame:(CGRect)viewFrame;


/**
 * 图片重命名
 */
+ (UIImage *)ak_imageAutoNamed:(NSString *)imageName;

/**
 * 图片加滤镜
 */
- (UIImage *)ak_toGrayImage;
- (UIImage *)ak_blurredImage:(CGFloat)blurAmount;
+ (UIImage *)ak_imageFromImage:(UIImage *)image inRect:(CGRect)rect;
+ (UIImage *)ak_screenshot:(UIView *)view andRect:(CGRect)rect1;
+ (UIImage *)ak_blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur;

/**
 * 通过一张图片添加水印
 * @param name 图片名称
 * @param waterName 水印图片名称
 * @return 添加了水印的图片
 */
+ (UIImage *)ak_imageNamed:(NSString *)name watermarkWithImageNamed:(NSString *)waterName;

/**
 * 通过文字添加水印
 * @param name 图片名称
 * @param logName 文案
 * @return 添加了水印的图片
 */
+ (UIImage *)ak_imageNamed:(NSString *)name watermarkWithLogNamed:(NSString *)logName;

/**
 * 添加阴影
 * cropRect 局部区域
 */
- (UIImage *)ak_applyLightEffect;
- (UIImage *)ak_applyExtraLightEffect;
- (UIImage *)ak_applyDarkEffect;
- (UIImage *)ak_applyTintEffectWithColor:(UIColor *)tintColor;
- (UIImage *)ak_applyLightEffectToRegion:(CGRect)cropRect;
- (UIImage *)ak_applyBlurWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *)maskImage;
- (UIImage *)ak_applyBlurWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *)maskImage applyRegion:(CGRect)cropRect;

/**
 *  等比例缩放图片
 *
 *  @param image             原图
 *  @param targetSize        目标大小
 *  @param isBaseOnShortEdge 是否以最小边为基准: YES 以短边为基准, 长边会超出目标长边; NO 以长边为基准,最长边不超过目标的长边.
 *
 *  @return 缩放后图片
 */
+ (UIImage *)ak_scaleImage:(UIImage *)image toSize:(CGSize)targetSize isBaseOnShortEdge:(BOOL)isBaseOnShortEdge;

/**
 *  返回圆形图片
 */
+ (instancetype)ak_circleImageWithImageNamed:(NSString *)imageName;

/**
 *  返回圆形图片
 */
- (instancetype)ak_circleImage;

- (UIImage *)ak_circleImageWithBackgroundColor:(UIColor *)backgroundColor;

/**
 *  获取原始图片（不会被系统渲染）
 */
+ (UIImage *)ak_imageNamed:(NSString *)imageName;

/**
 *  生成一张圆形图片
 *
 *  @param image       要裁剪的图片
 *
 *  @return 生成的圆形图片
 */

+ (UIImage *)imageWithClipImage:(UIImage *)image;

@end
