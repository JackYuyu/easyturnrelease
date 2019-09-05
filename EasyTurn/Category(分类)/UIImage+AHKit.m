//
//  UIImage+AHKit.m
//  AHKIt_CarMaid
//
//  Created by zhangMo on 2016/12/26.
//  Copyright © 2016年 AutoHome. All rights reserved.
//

#import "UIImage+AHKit.h"

#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 70000
#define SY_TEXTSIZE(text, font) ([text length] > 0 ? [text \
sizeWithAttributes:@{NSFontAttributeName:font}] : CGSizeZero)
#define SY_MULTILINE_TEXTSIZE(text, font, maxSize, mode) ([text length] > 0 ? [text \
boundingRectWithSize:maxSize options:(NSStringDrawingUsesLineFragmentOrigin) \
attributes:@{NSFontAttributeName:font} context:nil].size : CGSizeZero)
#else
#define SY_TEXTSIZE(text, font) ([text length] > 0 ? [text sizeWithFontEX:font] : CGSizeZero)
#define SY_MULTILINE_TEXTSIZE(text, font, maxSize, mode) ([text length] > 0 ? [text \
sizeWithFontEX:font constrainedToSize:maxSize lineBreakMode:mode] : CGSizeZero)
#endif

#define DEGREES_TO_RADIANS(degrees) (degrees * M_PI / 180)
#define RADIANS_TO_DERREES(radians) (radians * 180 / M_PI)

@implementation UIImage (AHKit)

#pragma mark - 根据颜色生成图片
+ (UIImage *)ak_createImageWithColor:(UIColor *)color {
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

+ (UIImage *)ak_imageWithColor:(UIColor *)color size:(CGSize)size {
    
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)ak_imageWithColor:(UIColor *)color triangleSize:(CGSize)size {
    
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, CGRectGetMidX(rect), CGRectGetMinY(rect)); // top left
    CGContextAddLineToPoint(context, CGRectGetMaxX(rect), CGRectGetMaxY(rect)); // mid right
    CGContextAddLineToPoint(context, CGRectGetMinX(rect), CGRectGetMaxY(rect)); // bottom left
    CGContextClosePath(context);
    
    CGContextFillPath(context);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)ak_imageWithColor:(UIColor *)color roundSize:(CGSize)size {
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(contextRef, [color CGColor]);
    CGContextAddEllipseInRect(contextRef, CGRectMake(0, 0, size.width, size.height));
    CGContextFillPath(contextRef);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

+ (UIImage *)ak_resizableImageWithColor:(UIColor *)color {
    return [self ak_resizableImageWithColor:color initialSize:CGSizeMake(4, 4) resizeEdge:UIEdgeInsetsMake(2, 2, 2, 2)];
}

+ (UIImage *)ak_resizableImageWithColor:(UIColor *)color initialSize:(CGSize)size resizeEdge:(UIEdgeInsets)edgeInsets {
    UIImage *resizableImage = [[self ak_imageWithColor:color size:size] resizableImageWithCapInsets:edgeInsets resizingMode:UIImageResizingModeTile];
    return resizableImage;
}

+ (UIImage *)ak_imageWithText:(NSString *)text
                         font:(UIFont *)textFont
                        color:(UIColor *)textColor
              backgroundColor:(UIColor *)backgroundColor
                    roundSize:(CGSize)roundSize {
    
    UIGraphicsBeginImageContextWithOptions(roundSize, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIColor *bgColor = backgroundColor ?  backgroundColor : [UIColor lightGrayColor];
    CGContextSetFillColorWithColor(context, [bgColor CGColor]);
    CGContextAddEllipseInRect(context, CGRectMake(0, 0, roundSize.width, roundSize.height));
    CGContextFillPath(context);
    
    // 文字设置
    if (text && text.length > 0) {
        CGRect frame = CGRectMake(0, 0, roundSize.width, roundSize.height);
        
        UIFont *font = textFont ? textFont : [UIFont systemFontOfSize:frame.size.height / 2.2];
        UIColor *color = textColor ? textColor : [UIColor whiteColor];
        
        NSMutableParagraphStyle *textStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
        textStyle.alignment = NSTextAlignmentCenter;
        
        NSDictionary *textAttributes = @{NSFontAttributeName: font, NSForegroundColorAttributeName:color, NSParagraphStyleAttributeName: textStyle};
        
        CGFloat textHeight = [text boundingRectWithSize:CGSizeMake(frame.size.width, CGFLOAT_MAX)  options: NSStringDrawingUsesLineFragmentOrigin attributes:textAttributes context: nil].size.height;
        
        CGContextSaveGState(context);
        CGContextClipToRect(context, frame);
        
        [text drawInRect: CGRectMake(CGRectGetMinX(frame), CGRectGetMinY(frame) + (CGRectGetHeight(frame) - textHeight) / 2, CGRectGetWidth(frame), textHeight) withAttributes: textAttributes];
        CGContextRestoreGState(context);
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
    
}

+ (UIImage *)ak_imageWithText:(NSString *)text
                         font:(UIFont *)textFont
                        color:(UIColor *)textColor
              backgroundColor:(UIColor *)backgroundColor
                        frame:(CGRect)frame
                 cornerRadius:(CGFloat)radius {
    
    
    UIGraphicsBeginImageContextWithOptions(frame.size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIColor *bgColor = backgroundColor ?  backgroundColor : [UIColor lightGrayColor];
    
    // 背景形状
    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRoundedRect:frame cornerRadius:radius];
    [bgColor setFill];
    [rectanglePath fill];
    
    // 文字设置
    if (text && text.length > 0) {
        UIFont *font = textFont ? textFont : [UIFont systemFontOfSize:frame.size.height / 2.2];
        UIColor *color = textColor ? textColor : [UIColor whiteColor];
        
        NSMutableParagraphStyle *textStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
        textStyle.alignment = NSTextAlignmentCenter;
        
        NSDictionary *textAttributes = @{NSFontAttributeName: font, NSForegroundColorAttributeName:color, NSParagraphStyleAttributeName: textStyle};
        
        CGFloat textHeight = [text boundingRectWithSize:CGSizeMake(frame.size.width, CGFLOAT_MAX)  options: NSStringDrawingUsesLineFragmentOrigin attributes:textAttributes context: nil].size.height;
        
        CGContextSaveGState(context);
        CGContextClipToRect(context, frame);
        
        [text drawInRect: CGRectMake(CGRectGetMinX(frame), CGRectGetMinY(frame) + (CGRectGetHeight(frame) - textHeight) / 2, CGRectGetWidth(frame), textHeight) withAttributes: textAttributes];
        CGContextRestoreGState(context);
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
    
}

#pragma mark - 图片缩放操作
- (UIImage *)ak_originImageScaleToSize:(CGSize)size {
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}

- (UIImage *)ak_imageToSize:(CGSize)size andScaleWidth:(CGFloat)scaleWidth andScaleHeight:(CGFloat)scaleHeight {
    // 倍数
    CGFloat widthMultiple = self.size.width / scaleWidth;
    CGFloat heightMultiple = self.size.height / scaleHeight;
    
    CGFloat scale = 0;
    // 缩放已倍数小的为准
    if (widthMultiple < heightMultiple) {
        // 图片比目标大小大时才缩放
        if (self.size.width > size.width)
            scale = size.width / self.size.width;
    }
    // 高的倍数小 or 高宽倍数相等
    else {
        // 图片比目标大小大时才缩放
        if (self.size.height > size.height)
            scale = size.height / self.size.height;
    }
    UIImage *img = self;
    // 需要缩放
    if (scale != 0) {
        img = [self ak_imageToScale:scale];
    }
    // 需要裁剪
    if (widthMultiple != heightMultiple) {
        img = [img imageToNew:scaleWidth andScaleHeight:scaleHeight];
    }
    return img;
}

- (UIImage *)imageToNew:(CGFloat)scaleWidth andScaleHeight:(CGFloat)scaleHeight {
    // 倍数
    CGFloat widthMultiple = self.size.width / scaleWidth;
    CGFloat heightMultiple = self.size.height / scaleHeight;
    
    CGRect rect = CGRectNull;
    // 倍数大的裁剪
    if (widthMultiple > heightMultiple) {
        CGFloat newWidth = heightMultiple * scaleWidth;
        rect = CGRectMake((self.size.width - newWidth) / 2, 0, newWidth, self.size.height);
    } else if (heightMultiple > widthMultiple) {
        CGFloat newHeight = widthMultiple * scaleHeight;
        rect = CGRectMake(0, (self.size.height - newHeight) / 2, self.size.width, newHeight);
    }
    
    if (CGRectIsNull(rect)) {
        return self;
    } else {
        UIImage *image4b3 = [self ak_imageAtRect:rect];
        return image4b3;
    }
}
- (UIImage *)ak_imageTo4b3 {
    // 倍数
    CGFloat widthMultiple = self.size.width / 4.0;
    CGFloat heightMultiple = self.size.height / 3.0;
    
    CGRect rect = CGRectNull;
    // 倍数大的裁剪
    if (widthMultiple > heightMultiple) {
        CGFloat newWidth = heightMultiple * 4.0;
        rect = CGRectMake((self.size.width - newWidth) / 2, 0, newWidth, self.size.height);
    } else if (heightMultiple > widthMultiple) {
        CGFloat newHeight = widthMultiple * 3.0;
        rect = CGRectMake(0, (self.size.height - newHeight) / 2, self.size.width, newHeight);
    }
    
    if (CGRectIsNull(rect)) {
        return self;
    } else {
        UIImage *image4b3 = [self ak_imageAtRect:rect];
        return image4b3;
    }
}
- (UIImage *)ak_imageTo4b3AtSize:(CGSize)size {
    if (size.height / size.width != 3.0 / 4.0)
        return self;
    
    // 倍数
    CGFloat widthMultiple = self.size.width / 4.0;
    CGFloat heightMultiple = self.size.height / 3.0;
    
    // 宽高先缩放到4:3
    CGFloat scale = 0;
    // 缩放已倍数小的为准
    if (widthMultiple < heightMultiple) {
        // 图片比目标大小大时才缩放
        if (self.size.width > size.width)
            scale = size.width / self.size.width;
    }
    // 高的倍数小 or 高宽倍数相等
    else {
        // 图片比目标大小大时才缩放
        if (self.size.height > size.height)
            scale = size.height / self.size.height;
    }
    
    UIImage *img = self;
    // 需要缩放
    if (scale != 0) {
        img = [self ak_imageToScale:scale];
    }
    // 需要裁剪
    if (widthMultiple != heightMultiple) {
        img = [img ak_imageTo4b3];
    }
    return img;
}
- (UIImage *)ak_imageAtRect:(CGRect)rect {
    rect = CGRectMake(rect.origin.x * self.scale, rect.origin.y * self.scale, rect.size.width * self.scale, rect.size.height * self.scale);
    
    CGImageRef imgref = CGImageCreateWithImageInRect(self.CGImage, rect);
    UIImage *img = [UIImage imageWithCGImage:imgref];
    CGImageRelease(imgref);
    return img;
}
- (UIImage *)ak_imageToScale:(float)scale {
    CGSize size = CGSizeMake(self.size.width * scale, self.size.height * scale);
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}
- (UIImage *)ak_imageToSize:(CGSize)size {
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *sizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return sizeImage;
}
- (UIImage *)ak_scaleToSize:(CGSize)size {
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage =UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    //返回新的改变大小后的图片
    return scaledImage;
}

- (UIImage *)ak_fixCameraOrientation {
    // 如果图片朝向是 UP , 不做操作
    if (self.imageOrientation == UIImageOrientationUp)
        return self;
    // 计算
    // 如果是 Left/Right/Down
    CGAffineTransform transform =CGAffineTransformIdentity;
    switch (self.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, self.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width,0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, self.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    // 如果图片是 镜像的
    switch (self.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width,0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.height,0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    // 重新画图, 进行变换
    CGContextRef ctx =CGBitmapContextCreate(NULL, self.size.width, self.size.height,
                                            CGImageGetBitsPerComponent(self.CGImage),0,
                                            CGImageGetColorSpace(self.CGImage),
                                            CGImageGetBitmapInfo(self.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (self.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            CGContextDrawImage(ctx,CGRectMake(0,0,self.size.height,self.size.width), self.CGImage);
            break;
        default:
            CGContextDrawImage(ctx,CGRectMake(0,0,self.size.width,self.size.height), self.CGImage);
            break;
    }
    // 返回新图片
    CGImageRef cgimg =CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

#pragma mark - 图片添加/合并操作
+ (UIImage *)ak_addImage:(UIImage *)image1 toImage:(UIImage *)image2 andSize:(CGSize)size {
    UIGraphicsBeginImageContext(size);
    
    [image2 drawInRect:CGRectMake(0, 0, size.width, size.height)];
    [image1 drawInRect:CGRectMake((size.width - image1.size.width)/2, 0, image1.size.width, image1.size.height)];
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return resultingImage;
}
+ (UIImage *)ak_mergerImage1:(UIImage *)image1 image2:(UIImage *)image2 toSize:(CGSize)toSize {
    UIGraphicsBeginImageContext(toSize);
    // Draw image1
    [image1 drawInRect:CGRectMake(0, 0, image1.size.width, image1.size.height)];
    // Draw image2
    [image2 drawInRect:CGRectMake(image1.size.width, 0, image2.size.width, image2.size.height)];
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultingImage;
}
- (UIImage *)ak_addImage:(UIImage *)image point:(CGPoint)point {
    return [self ak_addImage:image point:point scale:0];
}

- (UIImage *)ak_addImage:(UIImage *)image point:(CGPoint)point scale:(CGFloat)scale {
    UIGraphicsBeginImageContextWithOptions(self.size, NO, scale);
    // Draw image1
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    // Draw image2
    [image drawInRect:CGRectMake(point.x, point.y, image.size.width, image.size.height)];
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return resultingImage;
}

- (UIImage *)ak_imageRotatedByRadians:(CGFloat)radians
{
    return [self ak_imageRotatedByDegrees:RADIANS_TO_DERREES(radians)];
}

- (UIImage *)ak_imageRotatedByDegrees:(CGFloat)degrees
{
    // calculate the size of the rotated view's containing box for our drawing space
    UIView *rotatedViewBox = [[UIView alloc] initWithFrame:CGRectMake(0,0,self.size.width, self.size.height)];
    CGAffineTransform t = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(degrees));
    rotatedViewBox.transform = t;
    CGSize rotatedSize = rotatedViewBox.frame.size;
    
    // Create the bitmap context
    UIGraphicsBeginImageContext(rotatedSize);
    CGContextRef bitmap = UIGraphicsGetCurrentContext();
    
    // Move the origin to the middle of the image so we will rotate and scale around the center.
    CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2);
    
    //   // Rotate the image context
    CGContextRotateCTM(bitmap, DEGREES_TO_RADIANS(degrees));
    
    // Now, draw the rotated/scaled image into the context
    CGContextScaleCTM(bitmap, 1.0, -1.0);
    CGContextDrawImage(bitmap, CGRectMake(-self.size.width / 2, -self.size.height / 2, self.size.width, self.size.height), [self CGImage]);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage*)ak_imageByScalingAndCroppingForSize:(CGSize)targetSize
{
    UIImage *sourceImage = self;
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth= width * scaleFactor;
        scaledHeight = height * scaleFactor;
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else if (widthFactor < heightFactor)
        {
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    UIGraphicsBeginImageContext(targetSize); // this will crop
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width= scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    [sourceImage drawInRect:thumbnailRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil)
        
        NSLog(@"could not scale image");
    
    //pop the context to get back to the default
    
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage *)ak_subImageOfViewFrame:(CGRect)viewFrame {
    CGSize imageSize = self.size;
    
    // 根据屏幕上 view 的 rect 换算到图片上的对应位置
//    CGFloat scale = [UIScreen mainScreen].scale;
//    CGFloat x = imageSize.width/(SCREEN_WIDTH * scale) * viewFrame.origin.x * scale;
//    CGFloat w = imageSize.width/(SCREEN_WIDTH * scale) * viewFrame.size.width * scale;
//    CGFloat y = imageSize.height/(SCREEN_HEIGHT * scale) * viewFrame.origin.y * scale;
//    CGFloat h = imageSize.height/(SCREEN_HEIGHT * scale) * viewFrame.size.height * scale;
    CGFloat x = imageSize.width/Screen_Width * viewFrame.origin.x;
    CGFloat w = imageSize.width/Screen_Width * viewFrame.size.width;
    CGFloat y = imageSize.height/Screen_Height * viewFrame.origin.y;
    CGFloat h = imageSize.height/Screen_Height * viewFrame.size.height;
    CGRect rectOnImage = CGRectMake(x, y, w, h) ;
    
    UIImage *submage = nil;
//    UIImage *fullImage = [UIImage imageWithCGImage:imageRotated.CGImage];
    CGImageRef imageRotatedRef = self.CGImage;
    CGImageRef subImageRef = CGImageCreateWithImageInRect(imageRotatedRef, rectOnImage);
    UIGraphicsBeginImageContext(rectOnImage.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, rectOnImage, subImageRef);
    submage = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    CGImageRelease(subImageRef);
    return submage;
}


#pragma mark - 图片加滤镜
typedef enum {
    ALPHA = 0,
    BLUE = 1,
    GREEN = 2,
    RED = 3
} PIXELS;

- (UIImage *)ak_toGrayImage {
    CGSize size = [self size];
    int width = size.width;
    int height = size.height;
    
    // the pixels will be painted to this array
    uint32_t *pixels = (uint32_t *) malloc(width * height * sizeof(uint32_t));
    
    // clear the pixels so any transparency is preserved
    memset(pixels, 0, width * height * sizeof(uint32_t));
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    // create a context with RGBA pixels
    CGContextRef context = CGBitmapContextCreate(pixels, width, height, 8, width * sizeof(uint32_t), colorSpace,
                                                 kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedLast);
    
    // paint the bitmap to our context which will fill in the pixels array
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), [self CGImage]);
    
    for(int y = 0; y < height; y++) {
        for(int x = 0; x < width; x++) {
            uint8_t *rgbaPixel = (uint8_t *) &pixels[y * width + x];
            
            // convert to grayscale using recommended method: http://en.wikipedia.org/wiki/Grayscale#Converting_color_to_grayscale
            uint32_t gray = 0.3 * rgbaPixel[RED] + 0.59 * rgbaPixel[GREEN] + 0.11 * rgbaPixel[BLUE];
            
            // set the pixels to gray
            rgbaPixel[RED] = gray;
            rgbaPixel[GREEN] = gray;
            rgbaPixel[BLUE] = gray;
        }
    }
    
    // create a new CGImageRef from our context with the modified pixels
    CGImageRef image = CGBitmapContextCreateImage(context);
    
    // we're done with the context, color space, and pixels
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    free(pixels);
    
    // make a new UIImage to return
    UIImage *resultUIImage = [UIImage imageWithCGImage:image];
    
    // we're done with image now too
    CGImageRelease(image);
    
    return resultUIImage;
}

- (UIImage *)ak_blurredImage:(CGFloat)blurAmount
{
    if (blurAmount < 0.0 || blurAmount > 1.0) {
        blurAmount = 0.5;
    }
    
    int boxSize = (int)(blurAmount * 40);
    boxSize = boxSize - (boxSize % 2) + 1;
    
    CGImageRef img = self.CGImage;
    
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    
    void *pixelBuffer;
    
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    
    if (!error) {
        error = vImageBoxConvolve_ARGB8888(&outBuffer, &inBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
        
        if (!error) {
            error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
        }
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGContextRef ctx = CGBitmapContextCreate(outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             (CGBitmapInfo)kCGImageAlphaNoneSkipLast);
    
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    
    free(pixelBuffer);
    CFRelease(inBitmapData);
    
    CGImageRelease(imageRef);
    
    return returnImage;
}

+ (UIImage *)ak_imageFromImage:(UIImage *)image inRect:(CGRect)rect {
    CGImageRef sourceImageRef = [image CGImage];
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, rect);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    CGImageRelease(newImageRef);
    
    return newImage;
}

+ (UIImage *)ak_screenshot:(UIView *)view andRect:(CGRect)rect1{
    CGRect rect = view.frame;
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:context];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    float originX = rect1.origin.x ;
    float originY = rect1.origin.y + 5 ;//5的误差,暂定
    float width = rect1.size.width ;
    float height = rect1.size.width ;
    //你需要的区域起点,宽,高;
    
    CGRect tmpRect = CGRectMake(originX , originY , width , height);
    CGImageRef newImageRef = CGImageCreateWithImageInRect([img CGImage], tmpRect);
    UIImage * imgeee = [UIImage imageWithCGImage:newImageRef];
    CGImageRelease(newImageRef);
    
    return imgeee;
}

+ (UIImage *)ak_blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur {
    if ((blur < 0.0f) || (blur > 1.0f)) {
        blur = 0.5f;
    }
    
    int boxSize = (int)(blur * 100);
    boxSize -= (boxSize % 2) + 1;
    
    CGImageRef img = image.CGImage;
    
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    void *pixelBuffer;
    
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL,
                                       0, 0, boxSize, boxSize, NULL,
                                       kvImageEdgeExtend);
    
    
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(
                                             outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             CGImageGetBitmapInfo(image.CGImage));
    
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    
    //clean up
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    
    free(pixelBuffer);
    CFRelease(inBitmapData);
    
    CGImageRelease(imageRef);
    
    return returnImage;
}

#pragma mark - 图片重命名
+ (UIImage *)ak_imageAutoNamed:(NSString *)imageName {
    if ((UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) && ([UIScreen mainScreen].bounds.size.height > 480.0f))
        return [UIImage imageNamed:[self autoRenameImageName:imageName]];
    else
        return [UIImage imageNamed:imageName];
}

+ (NSString *)autoRenameImageName:(NSString *)imageName {
    
    NSMutableString *imageNameMutable = [imageName mutableCopy];
    
    BOOL isJPG = NO;
    
    //Delete png extension
    NSRange extension = [imageName rangeOfString:@".png" options:NSBackwardsSearch | NSAnchoredSearch];
    if (extension.location != NSNotFound) {
        [imageNameMutable deleteCharactersInRange:extension];
    } else {
        //Delete jpg extension
        extension = [imageName rangeOfString:@".jpg" options:NSBackwardsSearch | NSAnchoredSearch];
        if (extension.location != NSNotFound) {
            [imageNameMutable deleteCharactersInRange:extension];
            isJPG = YES;
        }
    }
    
    //Look for @2x to introduce -568h string
    NSRange retinaAtSymbol = [imageName rangeOfString:@"@2x"];
    if (retinaAtSymbol.location != NSNotFound) {
        [imageNameMutable insertString:@"-568h" atIndex:retinaAtSymbol.location];
    } else {
        [imageNameMutable appendString:@"-568h@2x"];
    }
    
    //Check if the image exists and load the new 568 if so or the original name if not
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:imageNameMutable ofType:isJPG ? @"jpg" : @"png"];
    if (imagePath) {
        if (isJPG) {
            [imageNameMutable appendString:@".jpg"];
            return imageNameMutable;
        } else {
            //Remove the @2x to load with the correct scale 2.0
            [imageNameMutable replaceOccurrencesOfString:@"@2x" withString:@"" options:NSBackwardsSearch range:NSMakeRange(0, [imageNameMutable length])];
            return imageNameMutable;
        }
    } else {
        return imageName;
    }
}

#pragma mark - 图片加水印
+ (UIImage *)ak_imageNamed:(NSString *)name watermarkWithImageNamed:(NSString *)waterName {
    
    UIImage *img = [UIImage imageNamed:name];
    
    // 1.创建一个基于位图的上下文
    UIGraphicsBeginImageContextWithOptions(img.size, NO, 0.0);
    // 2.画背景
    [img drawInRect:CGRectMake(0, 0, img.size.width, img.size.height) blendMode:kCGBlendModeMultiply alpha:1.0];
    //    [img drawInRect:CGRectMake(0, 0, img.size.width, img.size.height)];
    
    // 3.画右下角的水印
    UIImage *waterImage = [UIImage imageNamed:waterName];
    CGFloat scale = 1; //缩放比例
    CGFloat margin = 30;//距离边缘多大
    CGFloat waterW = waterImage.size.width * scale;//水印图片的宽度
    CGFloat waterH = waterImage.size.height * scale;//水印图片的高度
    CGFloat waterX = img.size.width - waterW - margin;//x
    CGFloat waterY = img.size.height - waterH - margin;//y
    [waterImage drawInRect:CGRectMake(waterX, waterY, waterW, waterH)];
    
    // 4.从上下文中取得制作完毕的UIImage对象
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 5.结束上下文
    UIGraphicsEndImageContext();
    return newImage;
}

+ (UIImage *)ak_imageNamed:(NSString *)name watermarkWithLogNamed:(NSString *)logName {
    
    UIImage *bgImg = [UIImage imageNamed:name];
    //size : 生成新图片的尺寸
    //opaque : 是否透明 YES : 透明 NO : 不透明
    //scale : 缩放比例
    UIGraphicsBeginImageContextWithOptions(bgImg.size, NO, 0.0);
    [bgImg drawAtPoint:CGPointZero];
    
    //设置字体属性
    UIFont *font = [UIFont systemFontOfSize:40];
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:10];
    [dict setValue:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    [dict setValue:font forKey:NSFontAttributeName];
    
    CGSize size = SY_MULTILINE_TEXTSIZE(logName, font, CGSizeMake(1000, 1000), NSLineBreakByCharWrapping);
    /** 设置水印的位置 */
    [logName drawInRect:CGRectMake(bgImg.size.width - size.width - 10, bgImg.size.height - size.height - 10, size.width, size.height) withAttributes:dict];
    
    /** 从当前上下文取到已经添加水印的图片 */
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    /** 关闭上下文 */
    UIGraphicsEndPDFContext();
    
    return newImage;
}

#pragma mark - 图片加阴影
- (UIImage *)ak_applyLightEffect
{
    UIColor *tintColor = [UIColor colorWithWhite:1.0 alpha:0.5];
    return [self ak_applyBlurWithRadius:30 tintColor:tintColor saturationDeltaFactor:1.8 maskImage:nil];
}


- (UIImage *)ak_applyExtraLightEffect
{
    UIColor *tintColor = [UIColor colorWithWhite:0.97 alpha:0.82];
    return [self ak_applyBlurWithRadius:20 tintColor:tintColor saturationDeltaFactor:1.8 maskImage:nil];
}

- (UIImage *)ak_applyDarkEffect
{
    UIColor *tintColor = [UIColor colorWithWhite:0.11 alpha:0.73];
    return [self ak_applyBlurWithRadius:20 tintColor:tintColor saturationDeltaFactor:1.8 maskImage:nil];
}


- (UIImage *)ak_applyTintEffectWithColor:(UIColor *)tintColor
{
    const CGFloat EffectColorAlpha = 0.6;
    UIColor *effectColor = tintColor;
    long componentCount = CGColorGetNumberOfComponents(tintColor.CGColor);
    if (componentCount == 2) {
        CGFloat b;
        if ([tintColor getWhite:&b alpha:NULL]) {
            effectColor = [UIColor colorWithWhite:b alpha:EffectColorAlpha];
        }
    }
    else {
        CGFloat r, g, b;
        if ([tintColor getRed:&r green:&g blue:&b alpha:NULL]) {
            effectColor = [UIColor colorWithRed:r green:g blue:b alpha:EffectColorAlpha];
        }
    }
    return [self ak_applyBlurWithRadius:10 tintColor:effectColor saturationDeltaFactor:-1.0 maskImage:nil];
}


- (UIImage *)ak_applyBlurWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *)maskImage
{
    // Check pre-conditions.
    if (self.size.width < 1 || self.size.height < 1) {
        NSLog (@"*** error: invalid size: (%.2f x %.2f). Both dimensions must be >= 1: %@", self.size.width, self.size.height, self);
        return nil;
    }
    if (!self.CGImage) {
        NSLog (@"*** error: image must be backed by a CGImage: %@", self);
        return nil;
    }
    if (maskImage && !maskImage.CGImage) {
        NSLog (@"*** error: maskImage must be backed by a CGImage: %@", maskImage);
        return nil;
    }
    
    CGRect imageRect = { CGPointZero, self.size };
    UIImage *effectImage = self;
    
    BOOL hasBlur = blurRadius > __FLT_EPSILON__;
    BOOL hasSaturationChange = fabs(saturationDeltaFactor - 1.) > __FLT_EPSILON__;
    if (hasBlur || hasSaturationChange) {
        UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
        CGContextRef effectInContext = UIGraphicsGetCurrentContext();
        CGContextScaleCTM(effectInContext, 1.0, -1.0);
        CGContextTranslateCTM(effectInContext, 0, -self.size.height);
        CGContextDrawImage(effectInContext, imageRect, self.CGImage);
        
        vImage_Buffer effectInBuffer;
        effectInBuffer.data     = CGBitmapContextGetData(effectInContext);
        effectInBuffer.width    = CGBitmapContextGetWidth(effectInContext);
        effectInBuffer.height   = CGBitmapContextGetHeight(effectInContext);
        effectInBuffer.rowBytes = CGBitmapContextGetBytesPerRow(effectInContext);
        
        UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
        CGContextRef effectOutContext = UIGraphicsGetCurrentContext();
        vImage_Buffer effectOutBuffer;
        effectOutBuffer.data     = CGBitmapContextGetData(effectOutContext);
        effectOutBuffer.width    = CGBitmapContextGetWidth(effectOutContext);
        effectOutBuffer.height   = CGBitmapContextGetHeight(effectOutContext);
        effectOutBuffer.rowBytes = CGBitmapContextGetBytesPerRow(effectOutContext);
        
        if (hasBlur) {
            // A description of how to compute the box kernel width from the Gaussian
            // radius (aka standard deviation) appears in the SVG spec:
            // http://www.w3.org/TR/SVG/filters.html#feGaussianBlurElement
            //
            // For larger values of 's' (s >= 2.0), an approximation can be used: Three
            // successive box-blurs build a piece-wise quadratic convolution kernel, which
            // approximates the Gaussian kernel to within roughly 3%.
            //
            // let d = floor(s * 3*sqrt(2*pi)/4 + 0.5)
            //
            // ... if d is odd, use three box-blurs of size 'd', centered on the output pixel.
            //
            CGFloat inputRadius = blurRadius * [[UIScreen mainScreen] scale];
            uint32_t radius = floor(inputRadius * 3. * sqrt(2 * M_PI) / 4 + 0.5);
            if (radius % 2 != 1) {
                radius += 1; // force radius to be odd so that the three box-blur methodology works.
            }
            vImageBoxConvolve_ARGB8888(&effectInBuffer, &effectOutBuffer, NULL, 0, 0, radius, radius, 0, kvImageEdgeExtend);
            vImageBoxConvolve_ARGB8888(&effectOutBuffer, &effectInBuffer, NULL, 0, 0, radius, radius, 0, kvImageEdgeExtend);
            vImageBoxConvolve_ARGB8888(&effectInBuffer, &effectOutBuffer, NULL, 0, 0, radius, radius, 0, kvImageEdgeExtend);
        }
        BOOL effectImageBuffersAreSwapped = NO;
        if (hasSaturationChange) {
            CGFloat s = saturationDeltaFactor;
            CGFloat floatingPointSaturationMatrix[] = {
                0.0722 + 0.9278 * s,  0.0722 - 0.0722 * s,  0.0722 - 0.0722 * s,  0,
                0.7152 - 0.7152 * s,  0.7152 + 0.2848 * s,  0.7152 - 0.7152 * s,  0,
                0.2126 - 0.2126 * s,  0.2126 - 0.2126 * s,  0.2126 + 0.7873 * s,  0,
                0,                    0,                    0,  1,
            };
            const int32_t divisor = 256;
            NSUInteger matrixSize = sizeof(floatingPointSaturationMatrix)/sizeof(floatingPointSaturationMatrix[0]);
            int16_t saturationMatrix[matrixSize];
            for (NSUInteger i = 0; i < matrixSize; ++i) {
                saturationMatrix[i] = (int16_t)roundf(floatingPointSaturationMatrix[i] * divisor);
            }
            if (hasBlur) {
                vImageMatrixMultiply_ARGB8888(&effectOutBuffer, &effectInBuffer, saturationMatrix, divisor, NULL, NULL, kvImageNoFlags);
                effectImageBuffersAreSwapped = YES;
            }
            else {
                vImageMatrixMultiply_ARGB8888(&effectInBuffer, &effectOutBuffer, saturationMatrix, divisor, NULL, NULL, kvImageNoFlags);
            }
        }
        if (!effectImageBuffersAreSwapped)
            effectImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        if (effectImageBuffersAreSwapped)
            effectImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    // Set up output context.
    UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
    CGContextRef outputContext = UIGraphicsGetCurrentContext();
    CGContextScaleCTM(outputContext, 1.0, -1.0);
    CGContextTranslateCTM(outputContext, 0, -self.size.height);
    
    // Draw base image.
    CGContextDrawImage(outputContext, imageRect, self.CGImage);
    
    // Draw effect image.
    if (hasBlur) {
        CGContextSaveGState(outputContext);
        if (maskImage) {
            CGContextClipToMask(outputContext, imageRect, maskImage.CGImage);
        }
        CGContextDrawImage(outputContext, imageRect, effectImage.CGImage);
        CGContextRestoreGState(outputContext);
    }
    
    // Add in color tint.
    if (tintColor) {
        CGContextSaveGState(outputContext);
        CGContextSetFillColorWithColor(outputContext, tintColor.CGColor);
        CGContextFillRect(outputContext, imageRect);
        CGContextRestoreGState(outputContext);
    }
    
    // Output image is ready.
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return outputImage;
}

- (UIImage *)ak_applyLightEffectToRegion:(CGRect)cropRect
{
    UIColor *tintColor = [UIColor colorWithWhite:1.0 alpha:0.3];
    return [self ak_applyBlurWithRadius:8 tintColor:tintColor saturationDeltaFactor:1.8 maskImage:nil applyRegion:cropRect];
}

- (UIImage *)ak_applyBlurWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *)maskImage applyRegion:(CGRect)cropRect {
    
    UIImage *croppedImage = [self getSubImageFrom:self WithRect:cropRect];
    
    return [self applyBlurWithRadius:blurRadius tintColor:tintColor saturationDeltaFactor:saturationDeltaFactor maskImage:nil toImage:croppedImage];
}

// get sub image
- (UIImage *)getSubImageFrom:(UIImage*)img WithRect:(CGRect)rect {
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    // translated rectangle for drawing sub image
    CGRect drawRect = CGRectMake(-rect.origin.x, -rect.origin.y, img.size.width, img.size.height);
    // clip to the bounds of the image context
    // not strictly necessary as it will get clipped anyway?
    CGContextClipToRect(context, CGRectMake(0, 0, rect.size.width, rect.size.height));
    // draw image
    [img drawInRect:drawRect];
    // grab image
    UIImage *subImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return subImage;
}

- (UIImage *)applyBlurWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *)maskImage toImage: (UIImage *)originalImage
{
    // Check pre-conditions.
    if (originalImage.size.width < 1 || originalImage.size.height < 1) {
        NSLog (@"*** error: invalid size: (%.2f x %.2f). Both dimensions must be >= 1: %@", self.size.width, self.size.height, self);
        return nil;
    }
    if (!originalImage.CGImage) {
        NSLog (@"*** error: image must be backed by a CGImage: %@", self);
        return nil;
    }
    if (maskImage && !maskImage.CGImage) {
        NSLog (@"*** error: maskImage must be backed by a CGImage: %@", maskImage);
        return nil;
    }
    
    CGRect imageRect = { CGPointZero, originalImage.size };
    UIImage *effectImage = originalImage;
    
    BOOL hasBlur = blurRadius > __FLT_EPSILON__;
    BOOL hasSaturationChange = fabs(saturationDeltaFactor - 1.) > __FLT_EPSILON__;
    if (hasBlur || hasSaturationChange) {
        UIGraphicsBeginImageContextWithOptions(originalImage.size, NO, [[UIScreen mainScreen] scale]);
        CGContextRef effectInContext = UIGraphicsGetCurrentContext();
        CGContextScaleCTM(effectInContext, 1.0, -1.0);
        CGContextTranslateCTM(effectInContext, 0, -originalImage.size.height);
        CGContextDrawImage(effectInContext, imageRect, originalImage.CGImage);
        
        vImage_Buffer effectInBuffer;
        effectInBuffer.data     = CGBitmapContextGetData(effectInContext);
        effectInBuffer.width    = CGBitmapContextGetWidth(effectInContext);
        effectInBuffer.height   = CGBitmapContextGetHeight(effectInContext);
        effectInBuffer.rowBytes = CGBitmapContextGetBytesPerRow(effectInContext);
        
        UIGraphicsBeginImageContextWithOptions(originalImage.size, NO, [[UIScreen mainScreen] scale]);
        CGContextRef effectOutContext = UIGraphicsGetCurrentContext();
        vImage_Buffer effectOutBuffer;
        effectOutBuffer.data     = CGBitmapContextGetData(effectOutContext);
        effectOutBuffer.width    = CGBitmapContextGetWidth(effectOutContext);
        effectOutBuffer.height   = CGBitmapContextGetHeight(effectOutContext);
        effectOutBuffer.rowBytes = CGBitmapContextGetBytesPerRow(effectOutContext);
        
        if (hasBlur) {
            // A description of how to compute the box kernel width from the Gaussian
            // radius (aka standard deviation) appears in the SVG spec:
            // http://www.w3.org/TR/SVG/filters.html#feGaussianBlurElement
            //
            // For larger values of 's' (s >= 2.0), an approximation can be used: Three
            // successive box-blurs build a piece-wise quadratic convolution kernel, which
            // approximates the Gaussian kernel to within roughly 3%.
            //
            // let d = floor(s * 3*sqrt(2*pi)/4 + 0.5)
            //
            // ... if d is odd, use three box-blurs of size 'd', centered on the output pixel.
            //
            CGFloat inputRadius = blurRadius * [[UIScreen mainScreen] scale];
            uint32_t radius = floor(inputRadius * 3. * sqrt(2 * M_PI) / 4 + 0.5);
            if (radius % 2 != 1) {
                radius += 1; // force radius to be odd so that the three box-blur methodology works.
            }
            vImageBoxConvolve_ARGB8888(&effectInBuffer, &effectOutBuffer, NULL, 0, 0, radius, radius, 0, kvImageEdgeExtend);
            vImageBoxConvolve_ARGB8888(&effectOutBuffer, &effectInBuffer, NULL, 0, 0, radius, radius, 0, kvImageEdgeExtend);
            vImageBoxConvolve_ARGB8888(&effectInBuffer, &effectOutBuffer, NULL, 0, 0, radius, radius, 0, kvImageEdgeExtend);
        }
        BOOL effectImageBuffersAreSwapped = NO;
        if (hasSaturationChange) {
            CGFloat s = saturationDeltaFactor;
            CGFloat floatingPointSaturationMatrix[] = {
                0.0722 + 0.9278 * s,  0.0722 - 0.0722 * s,  0.0722 - 0.0722 * s,  0,
                0.7152 - 0.7152 * s,  0.7152 + 0.2848 * s,  0.7152 - 0.7152 * s,  0,
                0.2126 - 0.2126 * s,  0.2126 - 0.2126 * s,  0.2126 + 0.7873 * s,  0,
                0,                    0,                    0,  1,
            };
            const int32_t divisor = 256;
            NSUInteger matrixSize = sizeof(floatingPointSaturationMatrix)/sizeof(floatingPointSaturationMatrix[0]);
            int16_t saturationMatrix[matrixSize];
            for (NSUInteger i = 0; i < matrixSize; ++i) {
                saturationMatrix[i] = (int16_t)roundf(floatingPointSaturationMatrix[i] * divisor);
            }
            if (hasBlur) {
                vImageMatrixMultiply_ARGB8888(&effectOutBuffer, &effectInBuffer, saturationMatrix, divisor, NULL, NULL, kvImageNoFlags);
                effectImageBuffersAreSwapped = YES;
            }
            else {
                vImageMatrixMultiply_ARGB8888(&effectInBuffer, &effectOutBuffer, saturationMatrix, divisor, NULL, NULL, kvImageNoFlags);
            }
        }
        if (!effectImageBuffersAreSwapped)
            effectImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        if (effectImageBuffersAreSwapped)
            effectImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    // Set up output context.
    UIGraphicsBeginImageContextWithOptions(originalImage.size, NO, [[UIScreen mainScreen] scale]);
    CGContextRef outputContext = UIGraphicsGetCurrentContext();
    CGContextScaleCTM(outputContext, 1.0, -1.0);
    CGContextTranslateCTM(outputContext, 0, -originalImage.size.height);
    
    // Draw base image.
    CGContextDrawImage(outputContext, imageRect, originalImage.CGImage);
    
    // Draw effect image.
    if (hasBlur) {
        CGContextSaveGState(outputContext);
        if (maskImage) {
            CGContextClipToMask(outputContext, imageRect, maskImage.CGImage);
        }
        CGContextDrawImage(outputContext, imageRect, effectImage.CGImage);
        CGContextRestoreGState(outputContext);
    }
    
    // Add in color tint.
    if (tintColor) {
        CGContextSaveGState(outputContext);
        CGContextSetFillColorWithColor(outputContext, tintColor.CGColor);
        CGContextFillRect(outputContext, imageRect);
        CGContextRestoreGState(outputContext);
    }
    
    // Output image is ready.
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return outputImage;
}

+ (UIImage *)ak_scaleImage:(UIImage *)image toSize:(CGSize)targetSize isBaseOnShortEdge:(BOOL)isBaseOnShortEdge {
    if (!image) {
        return nil;
    }
    
    CGFloat imageWidth = image.size.width;
    CGFloat imageHeight = image.size.height;
    
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    float imageRatio = imageWidth/imageHeight * 1.0;
    float targetRatio = targetWidth/targetHeight * 1.0;
    NSLog(@"imageRatio %f targetRatio %f",imageRatio,targetRatio);
    
    // 根据 isBaseOnShortEdge 进行图片是否需要进行缩放的判断
    if (isBaseOnShortEdge) {
        if (targetRatio>=1) {
            if (imageRatio >= 1) {
                if (imageHeight <= targetHeight) {
                    return image;
                }
            } else {
                if (imageWidth <= targetHeight) {
                    return image;
                }
            }
        } else {
            if (imageRatio >= 1) {
                if (imageHeight <= targetWidth) {
                    return image;
                }
            } else {
                if (imageWidth <= targetWidth) {
                    return image;
                }
            }
        }
    } else {
        if (targetRatio>=1) {
            if (imageRatio >= 1) {
                if (imageWidth <= targetWidth) {
                    return image;
                }
            } else {
                if (imageHeight <= targetWidth) {
                    return image;
                }
            }
        } else {
            if (imageRatio >= 1) {
                if (imageWidth <= targetHeight) {
                    return image;
                }
            } else {
                if (imageHeight <= targetHeight) {
                    return image;
                }
            }
        }
    }
    
    
    CGSize finalSize = [self finalSizeByImageSize:image.size targetSize:targetSize isBaseOnShortEdge:isBaseOnShortEdge];
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(finalSize);
    
    // 绘制改变大小的图片
    //    [image drawInRect:CGRectMake(xPos, yPos, width, height)];
    [image drawInRect:CGRectMake(0, 0, finalSize.width, finalSize.height)];
    
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    // 返回新的改变大小后的图片
    return scaledImage;
}

/**
 *  图片缩放大小计算
 *
 *  @param imageSize         原图大小
 *  @param targetSize        目标大小
 *  @param isBaseOnShortEdge 是否以最小边为基准: YES 以短边为基准, 长边会超出目标长边; NO 以长边为基准,最长边不超过目标的长边.
 *
 *  @return 计算后的图片实际大小
 */
+ (CGSize)finalSizeByImageSize:(CGSize)imageSize targetSize:(CGSize)targetSize isBaseOnShortEdge:(BOOL)isBaseOnShortEdge {
    
    CGSize finalSize = targetSize;
    
    CGFloat imageWidth = imageSize.width;
    CGFloat imageHeight = imageSize.height;
    
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    
    float imageRatio = imageWidth/imageHeight * 1.0;
    float targetRatio = targetWidth/targetHeight * 1.0;
    
    // ratio(宽度/高度): >1 : 宽>高; <1 : 宽<高; =1 : 宽=高
    NSLog(@"imageRatio %f targetRatio %f",imageRatio,targetRatio);
    
    // 根据 isBaseOnShortEdge 进行图片是否需要进行缩放的判断, 如无需缩放, 返回图片大小
    if (isBaseOnShortEdge) {
        if (targetRatio>=1) {
            if (imageRatio >= 1) {
                if (imageHeight <= targetHeight) {
                    return imageSize;
                }
            } else {
                if (imageWidth <= targetHeight) {
                    return imageSize;
                }
            }
        } else {
            if (imageRatio >= 1) {
                if (imageHeight <= targetWidth) {
                    return imageSize;
                }
            } else {
                if (imageWidth <= targetWidth) {
                    return imageSize;
                }
            }
        }
    } else {
        if (targetRatio>=1) {
            if (imageRatio >= 1) {
                if (imageWidth <= targetWidth) {
                    return imageSize;
                }
            } else {
                if (imageHeight <= targetWidth) {
                    return imageSize;
                }
            }
        } else {
            if (imageRatio >= 1) {
                if (imageWidth <= targetHeight) {
                    return imageSize;
                }
            } else {
                if (imageHeight <= targetHeight) {
                    return imageSize;
                }
            }
        }
    }
    
    
    if (isBaseOnShortEdge) { // 以短边为基准, 长边会超出目标长度.
        if (targetRatio >= 1) { // 目标 宽 >= 高
            if (imageRatio > 1) {
                targetWidth = targetHeight*imageRatio;
                finalSize.width = targetWidth;
            }
            else if(imageRatio < 1) {
                targetWidth = targetHeight/imageRatio;
                finalSize = CGSizeMake(targetHeight, targetWidth);
            }
            else {
                finalSize = CGSizeMake(targetHeight, targetHeight);
            }
        }
        else { // 目标 宽 < 高
            if (imageRatio > 1) {
                targetHeight = targetWidth*imageRatio;
                finalSize = CGSizeMake(targetHeight, targetWidth);
            }
            else if(imageRatio < 1) {
                targetHeight = targetWidth/imageRatio;
                finalSize.height = targetHeight;
            }
            else {
                finalSize = CGSizeMake(targetWidth, targetWidth);
            }
        }
    } else { // 以长边为基准, 长边不会超出目标长度.
        if (targetRatio >= 1) { // 目标 宽 >= 高
            if (imageRatio > 1) {
                targetHeight = targetWidth/imageRatio;
                finalSize.height = targetHeight;
            }
            else if(imageRatio < 1) {
                targetHeight = targetWidth*imageRatio;
                finalSize = CGSizeMake(targetHeight, targetWidth);
            }
            else {
                finalSize = CGSizeMake(targetHeight, targetHeight);
            }
        }
        else { // 目标 宽 < 高
            if (imageRatio > 1) {
                targetWidth = targetHeight/imageRatio;
                finalSize = CGSizeMake(targetHeight, targetWidth);
            }
            else if(imageRatio < 1) {
                targetWidth = targetHeight*imageRatio;
                finalSize.width = targetWidth;
            }
            else {
                finalSize = CGSizeMake(targetWidth, targetWidth);
            }
        }
    }
    
    NSLog(@"finalSizeWidth %f finalSizeHeight %f", finalSize.width, finalSize.height);
    
    return finalSize;
}

+ (instancetype)ak_circleImageWithImageNamed:(NSString *)imageName {
    return [[self imageNamed:imageName] ak_circleImage];
}

- (instancetype)ak_circleImage {
    UIGraphicsBeginImageContextWithOptions(self.size, NO, [UIScreen mainScreen].scale);
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(contextRef, rect);
    CGContextClip(contextRef);
    [self drawInRect:rect];
    UIImage *imgCircle = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imgCircle;
}

- (UIImage *)ak_circleImageWithBackgroundColor:(UIColor *)backgroundColor {
    UIGraphicsBeginImageContextWithOptions(self.size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
//    CGContextSetShouldAntialias(context, YES);
//    CGContextSetBlendMode(context, kCGBlendModeOverlay);
    if (backgroundColor) {
        CGContextSetFillColorWithColor(context, [backgroundColor CGColor]);
    }
    CGContextAddEllipseInRect(context, rect);
    CGContextFillPath(context);
    [self drawInRect:rect];
    
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return resultingImage;
}

+ (UIImage *)ak_imageNamed:(NSString *)imageName {
    return [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

+ (UIImage *)imageWithClipImage:(UIImage *)image{
    
    //1.开启跟原始图片一样大小的上下文
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
    //2.设置一个圆形裁剪区域
    //2.1绘制一个圆形
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    //2.2.把圆形的路径设置成裁剪区域
    [path addClip];//超过裁剪区域以外的内容都给裁剪掉
    //3.把图片绘制到上下文当中(超过裁剪区域以外的内容都给裁剪掉)
    [image drawAtPoint:CGPointZero];
    //4.从上下文当中取出图片
    UIImage *newImage =  UIGraphicsGetImageFromCurrentImageContext();
    //5.关闭上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end
