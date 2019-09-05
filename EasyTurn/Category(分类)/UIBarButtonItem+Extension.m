//
//  UIBarButtonItem+Extension.m
//  WeiBo17
//
//  Created by teacher on 15/8/16.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"
@implementation UIBarButtonItem (Extension)

+ (instancetype)itemWithImageName:(NSString *)imageName target:(id)target action:(SEL)action{
    UIButton *button = [[UIButton alloc] init];
    //设置不同状态的image
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_highlighted",imageName]] forState:UIControlStateHighlighted];
    
    //根据图片大小设置当前button的大小
    button.size = button.currentImage.size;
    
    //添加点击事件
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

+ (instancetype)itemWithImageName:(NSString *)imageName title:(NSString *)title target:(id)target action:(SEL)action{
    
    UIButton *button = [[UIButton alloc] init];
    //设置不同状态的image
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_highlighted",imageName]] forState:UIControlStateHighlighted];
    
    //设置title
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:kACColorWhite forState:UIControlStateNormal];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -15)];
    //根据内容调整大小
//    [button sizeToFit];
    button.titleLabel.font = [UIFont systemFontOfSize:12];
    //添加点击事件
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:button];
    
}


+ (instancetype)itemWithTitle:(NSString *)title target:(id)target action:(SEL)action{
    
    UIButton *button = [[UIButton alloc] init];
        
    //设置title
    [button setTitle:title forState:UIControlStateNormal];
    
    //设置title不同状态的颜色
    [button setTitleColor:kACColorWhite forState:UIControlStateNormal];
    [button setTitleColor:kACColorBackgroundGray forState:UIControlStateDisabled];
    
    [button.titleLabel setFont:[UIFont systemFontOfSize:15]];
    
    //根据内容调整大小
    [button sizeToFit];
    
    //添加点击事件
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:button];
    
}


@end
