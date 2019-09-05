//
//  UIView+AHkit.m
//  AHKIt_CarMaid
//
//  Created by zhangMo on 2016/12/22.
//  Copyright © 2016年 AutoHome. All rights reserved.
//

#import "UIView+AHkit.h"
#import <objc/runtime.h>
#import <WebKit/WebKit.h>

static NSString *const kAHKit_IsCapturing = @"kAHKit_IsCapturing_AssoKey_isCapturing";

@implementation UIView (AHkit)

- (CGFloat)minX {
    return self.frame.origin.x;
}

- (void)setMinX:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = floor(x);
    self.frame = frame;
}

- (CGFloat)minY {
    return self.frame.origin.y;
}

- (void)setMinY:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = floor(y);
    self.frame = frame;
}

- (CGFloat)maxX {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setMaxX:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = floor(x - frame.size.width);
    self.frame = frame;
}

- (CGFloat)maxY {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setMaxY:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = floor(y - frame.size.height);
    self.frame = frame;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)centerY {
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}

- (CGFloat)ttScreenX {
    CGFloat x = 0;
    for (UIView* view = self; view; view = view.superview) {
        x += view.minX;
    }
    return x;
}

- (CGFloat)ttScreenY {
    CGFloat y = 0;
    for (UIView* view = self; view; view = view.superview) {
        y += view.minY;
    }
    return y;
}

- (CGFloat)screenViewX {
    CGFloat x = 0;
    for (UIView* view = self; view; view = view.superview) {
        x += view.minX;
        
        if ([view isKindOfClass:[UIScrollView class]]) {
            UIScrollView* scrollView = (UIScrollView*)view;
            x -= scrollView.contentOffset.x;
        }
    }
    
    return x;
}

- (CGFloat)screenViewY {
    CGFloat y = 0;
    for (UIView* view = self; view; view = view.superview) {
        y += view.minY;
        
        if ([view isKindOfClass:[UIScrollView class]]) {
            UIScrollView* scrollView = (UIScrollView*)view;
            y -= scrollView.contentOffset.y;
        }
    }
    return y;
}

- (CGRect)screenFrame {
    return CGRectMake(self.screenViewX, self.screenViewY, self.width, self.height);
}

- (CGPoint)origin {
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin.x = floor(origin.x);
    frame.origin.y = floor(origin.y);
    self.frame = frame;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGPoint)centerBounds {
    return CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
}

- (void)setCenterBounds:(CGPoint)centerBounds {
    
}

- (UIView *)ak_subviewWithFirstResponder {
    if ([self isFirstResponder])
        return self;
    
    for (UIView *subview in self.subviews) {
        UIView *view = [subview ak_subviewWithFirstResponder];
        if (view) return view;
    }
    
    return nil;
}

- (UIView *)ak_subviewWithClass:(Class)cls {
    if ([self isKindOfClass:cls])
        return self;
    for (UIView* subview in self.subviews) {
        UIView* view = [subview ak_subviewWithClass:cls];
        if (view) return view;
    }
    return nil;
}

- (UIView *)ak_superviewWithClass:(Class)cls {
    if ([self isKindOfClass:cls]) {
        return self;
    } else if (self.superview) {
        return [self.superview ak_superviewWithClass:cls];
    } else {
        return nil;
    }
}

- (void)ak_removeAllSubviews {
    while (self.subviews.count) {
        UIView* child = self.subviews.lastObject;
        [child removeFromSuperview];
    }
}

- (void)ak_setBackgroundImage:(UIImage *)image {
    UIImageView *iv = [[UIImageView alloc] initWithImage:image];
    [self ak_setBackgroundView:iv];
}

- (void)ak_setBackgroundView:(UIView *)bgView {
    static int kBackgroundViewTag = 0x06746292;
    self.backgroundColor = [UIColor clearColor];
    
    bgView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    bgView.tag = kBackgroundViewTag;
    
    UIView* oldView = [self viewWithTag:kBackgroundViewTag];
    if (oldView)
        [oldView removeFromSuperview];
    
    [self insertSubview:bgView atIndex:0];
}

// 初始化一根线
- (id)initLineWithFrame:(CGRect)frame color:(UIColor *)color {
    self = [self initWithFrame:frame];
    self.backgroundColor = color;
    return self;
}

- (UIViewController *)ak_viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

- (NSString *)ak_stringViewStruct {
    NSMutableString *str = [NSMutableString string];
    [self dumpViewIntoString:str view:self level:0];
    return str;
}

- (void)dumpViewIntoString:(NSMutableString *)str view:(UIView *)view level:(int)level {
    for (int i = 0; i < level; i++)
        [str appendString:@"--"];
        [str appendFormat:@"[%d] %@ %@\n", level, [view.class description], NSStringFromCGRect(view.frame)];
    for (UIView *v in view.subviews)
        [self dumpViewIntoString:str view:v level:level + 1];
}

- (NSMutableArray *)ak_imageViewStruct {
    NSMutableArray *imgs = [NSMutableArray array];
    [self dumpViewIntoImages:imgs view:self];
    return imgs;
}

- (void)dumpViewIntoImages:(NSMutableArray *)imgs view:(UIView *)view {
    UIImage *img = [view ak_screenshot];
    if (img)
        [imgs addObject:img];
    for (UIView *v in view.subviews)
        [self dumpViewIntoImages:imgs view:v];
}

- (BOOL)ak_isIntersectsWithView:(UIView *)view {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    // 拿到自己在 window 坐标系上的坐标
    CGRect selfNewRect = [self convertRect:self.bounds toView:window];
    // 拿到传入的 view 在 window 坐标系上的坐标
    CGRect newViewRect = [view convertRect:view.bounds toView:window];
    
    return CGRectIntersectsRect(selfNewRect, newViewRect);
}

- (void)ak_randomBackgroundColor {
    [self setBackgroundColor: kACColorRGBA(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255), 1.0)];
}

- (void)ak_randomBackgroundColorWithAlpha:(CGFloat)alpha {
    [self setBackgroundColor: kACColorRGBA(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255), alpha)];
}

- (void)ak_randomBackgroundColorForSubviews {
    for (UIView *subView in self.subviews) {
        [subView ak_randomBackgroundColor];
    }
}

- (void)ak_addShadowWithColor:(UIColor*)shadowColor shadowOffset:(CGSize)shadowOffset shadowOpacity:(CGFloat)shadowOpacity shadowRadius:(CGFloat)shadowRadius {
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:self.bounds];
    self.layer.shadowColor = shadowColor.CGColor;
    self.layer.shadowOffset = shadowOffset;
    self.layer.shadowOpacity = shadowOpacity;
    self.layer.shadowRadius = shadowRadius;
    self.layer.shadowPath = shadowPath.CGPath;
}

#pragma mark - UIView 截屏功能

- (BOOL)isCapturing {
    NSNumber *num = objc_getAssociatedObject(self, &kAHKit_IsCapturing);
    return num.boolValue;
}

- (void)setIsCapturing:(BOOL)isCapturing {
    NSNumber *num = [NSNumber numberWithBool:isCapturing];
    objc_setAssociatedObject(self, &kAHKit_IsCapturing, num, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)ak_captureView:(void(^)(UIImage *image))completeBlock {
    
    self.isCapturing = YES;
    // 如果 frame 是 Empty 的时候, 必崩
    if (CGRectIsEmpty(self.frame)) {
        if (completeBlock) {
            completeBlock(nil);
        }
    }

    UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, [UIScreen mainScreen].scale);
    // 默认是 YES 再研究下,afterScreenUpdates设为NO,如果设置为YES屏幕每次有更新的时候就会重新绘制。如果是 YES 截屏以后会影响当前页面的刷新率，如果有横滚动视图，会变卡
    // 如果是 YES, 视图在快速切换时, 会有一定几率崩溃
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, -self.frame.origin.x, -self.frame.origin.y);
    
    if ([self ak_containsWKWebView]) {
        [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
    } else {
        [self.layer renderInContext:context];
    }
    UIImage *capturedImage = UIGraphicsGetImageFromCurrentImageContext();
    CGContextRestoreGState(context);
    UIGraphicsEndImageContext();
    self.isCapturing = NO;
    if (completeBlock) {
        dispatch_async(dispatch_get_main_queue(), ^{
            completeBlock(capturedImage);
        });
    }
}

- (BOOL)ak_containsWKWebView {
    if ([self isKindOfClass:[WKWebView class]]) {
        return YES;
    }
    
    for (UIView *subView in self.subviews) {
        if ([subView ak_containsWKWebView]) {
            return YES;
        }
    }
    return NO;
}

// 原始截屏方法
- (UIImage *)ak_screenshot {
    UIImage *image = nil;
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, [UIScreen mainScreen].scale);
    //默认是 YES 再研究下,afterScreenUpdates设为NO,如果设置为YES屏幕每次有更新的时候就会重新绘制。如果是 YES 截屏以后会影响当前页面的刷新率，如果有横滚动视图，会变卡
    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:NO];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIView *)addCornerRadiusWithRadius:(CGFloat)radius {
    [self.layer setCornerRadius:radius];
    [self.layer setMasksToBounds:YES];
    return self;
}
- (UIView *)addBorderWithBorderColor:(UIColor*)borderColor andBorderWidth:(CGFloat)borderWidth {
    [self.layer setBorderColor:[borderColor CGColor]];
    [self.layer setBorderWidth:borderWidth];
    [self.layer setMasksToBounds:YES];
    return self;
}
- (UIView *)addBorderWithBorderColor:(UIColor*)borderColor borderWidth:(CGFloat)borderWidth cornerRadius:(CGFloat)cornerRadius {
    self.layer.borderColor = [borderColor CGColor];
    self.layer.borderWidth = borderWidth;
    self.layer.cornerRadius = cornerRadius;
    [self.layer setMasksToBounds:YES];
    return self;
}

// 绘制渐变色颜色
+ (CAGradientLayer *)setGradualChangingColor:(UIView *)view fromColor:(NSString *)fromHexColorStr toColor:(NSString *)toHexColorStr{
    //CAGradientLayer类对其绘制渐变背景颜色、填充层的形状(包括圆角)
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = view.bounds;
    
    //创建渐变色数组，需要转换为CGColor颜色
    gradientLayer.colors = @[(__bridge id)[self colorWithHex:fromHexColorStr].CGColor,(__bridge id)[self colorWithHex:toHexColorStr].CGColor];
    
    //  设置渐变颜色方向，左上点为(0,0), 右下点为(1,1)
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 1);
    
    //  设置颜色变化点，取值范围 0.0~1.0
    gradientLayer.locations = @[@0,@1];
    
    return gradientLayer;
}

//获取16进制颜色的方法
+ (UIColor *)colorWithHex:(NSString *)hexColor {
    hexColor = [hexColor stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ([hexColor length] < 6) {
        return nil;
    }
    if ([hexColor hasPrefix:@"#"]) {
        hexColor = [hexColor substringFromIndex:1];
    }
    NSRange range;
    range.length = 2;
    range.location = 0;
    NSString *rs = [hexColor substringWithRange:range];
    range.location = 2;
    NSString *gs = [hexColor substringWithRange:range];
    range.location = 4;
    NSString *bs = [hexColor substringWithRange:range];
    unsigned int r, g, b, a;
    [[NSScanner scannerWithString:rs] scanHexInt:&r];
    [[NSScanner scannerWithString:gs] scanHexInt:&g];
    [[NSScanner scannerWithString:bs] scanHexInt:&b];
    if ([hexColor length] == 8) {
        range.location = 4;
        NSString *as = [hexColor substringWithRange:range];
        [[NSScanner scannerWithString:as] scanHexInt:&a];
    } else {
        a = 255;
    }
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:((float)a / 255.0f)];
}

@end
