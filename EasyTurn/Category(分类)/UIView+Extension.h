//
//  UIView+Extension.h
//  
//
//  Created by mac on 15/12/22.
//  Copyright © 2015年 xlanet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)

//宽高位置大小
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic ,assign) CGFloat dc_bottom;
//中心点的x与y
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

- (UIView *)addCornerRadiusWithRadius:(CGFloat)radius;
+ (instancetype)viewFromXib;

@end
