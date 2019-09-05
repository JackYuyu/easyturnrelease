//
//  UIButton+AHKit.m
//  AHKIt_CarMaid
//
//  Created by zhangMo on 2016/12/22.
//  Copyright © 2016年 AutoHome. All rights reserved.
//

#import "UIButton+AHKit.h"
#import "UIView+AHkit.h"
#import "NSString+AHKit.h"
#import <objc/runtime.h>

@implementation UIButton (AHKit)

static char topNameKey;
static char rightNameKey;
static char bottomNameKey;
static char leftNameKey;

- (UIEdgeInsets)ak_setImageEdgeInsetsFromOriginOffSet:(CGVector)vector imageSize:(CGSize)size {
    float offsetX = self.frame.size.width - size.width;
    float offsetY = self.frame.size.height - size.height;
    
    UIEdgeInsets edgeInsets =  UIEdgeInsetsMake(vector.dy, vector.dx, offsetY - vector.dy, offsetX - vector.dx);
    return edgeInsets;
}

- (UIEdgeInsets)ak_setImageEdgeInsetsFromCenterOffSet:(CGVector)vector imageSize:(CGSize)size {
    float offsetX = self.frame.size.width - size.width;
    float offsetY = self.frame.size.height - size.height;
    UIEdgeInsets edgeInsets =  UIEdgeInsetsMake(offsetY/2.0 + vector.dy, offsetX/2.0 + vector.dx, offsetY/2.0 - vector.dy, offsetX/2.0 - vector.dx);
    
    return edgeInsets;
}

- (void)ak_sizeToFitAlignment {
    [self ak_sizeToFitAlignment:UIButtonAlignmentRight space:5];
}

- (void)ak_sizeToFitAlignment:(UIButtonAlignment)alignment {
    [self ak_sizeToFitAlignment:alignment space:0];
}

- (void)ak_sizeToFitAlignment:(UIButtonAlignment)alignment space:(CGFloat)space {
    if (alignment == UIButtonAlignmentRight) {
        UIImage *image = self.imageView.image;
        CGFloat buttonImageViewWidth = CGImageGetWidth(image.CGImage);
        
        if ([UIScreen mainScreen].scale >= 2.0f) {// iOS 4.0+
            buttonImageViewWidth *= 0.5f;
        }
        CGSize buttonTitleLabelSize = [self.titleLabel.text ak_sizeWithFontEX:self.titleLabel.font];
        CGFloat buttonTitleLabelWidth = buttonTitleLabelSize.width;
        self.width = buttonTitleLabelWidth + buttonImageViewWidth + space + 2;
        
        [self setTitleEdgeInsets:UIEdgeInsetsMake(0, - buttonImageViewWidth - space, 0, buttonImageViewWidth)];
        [self setImageEdgeInsets:UIEdgeInsetsMake(0, buttonTitleLabelWidth + space, 0, - buttonTitleLabelWidth)];
    }
}

- (void)ak_setImageBackgroundColor:(UIColor *)backgroundColor forStatus:(UIControlState)state {
    UIImage *img = [SSJewelryCore resizableImageWithColor: backgroundColor];
    [self setBackgroundImage:img forState:state];
}

- (void)ak_setEnlargeEdgeWithTop:(CGFloat)top right:(CGFloat)right bottom:(CGFloat)bottom left:(CGFloat)left
{
    objc_setAssociatedObject(self, &topNameKey, [NSNumber numberWithFloat:top], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &rightNameKey, [NSNumber numberWithFloat:right], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &bottomNameKey, [NSNumber numberWithFloat:bottom], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &leftNameKey, [NSNumber numberWithFloat:left], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (CGRect)enlargedRect
{
    NSNumber *topEdge = objc_getAssociatedObject(self, &topNameKey);
    NSNumber *rightEdge = objc_getAssociatedObject(self, &rightNameKey);
    NSNumber *bottomEdge = objc_getAssociatedObject(self, &bottomNameKey);
    NSNumber *leftEdge = objc_getAssociatedObject(self, &leftNameKey);
    if (topEdge && rightEdge && bottomEdge && leftEdge) {
        return CGRectMake(self.bounds.origin.x - leftEdge.floatValue,
                          self.bounds.origin.y - topEdge.floatValue,
                          self.bounds.size.width + leftEdge.floatValue + rightEdge.floatValue,
                          self.bounds.size.height + topEdge.floatValue + bottomEdge.floatValue);
    }
    else
    {
        return self.bounds;
    }
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    CGRect rect = [self enlargedRect];
    if (CGRectEqualToRect(rect, self.bounds)) {
        return [super hitTest:point withEvent:event];
    }
    return CGRectContainsPoint(rect, point) ? self : nil;
}

@end
