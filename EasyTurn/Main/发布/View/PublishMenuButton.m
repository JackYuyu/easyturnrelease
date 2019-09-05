//
//  PublishMenuButton.h
//  CrazyCoderNO1PopMenu
//
//  Created by 李志超 on 19/8/2.
//  Copyright © 2019年 李志超. All rights reserved.
//

#import "PublishMenuButton.h"

@implementation PublishMenuButton

/*
 *初始化弹出按钮的样式
 */
-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self == [super initWithFrame:frame]) {
        
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:16];
    }
    
    return self;
}

/**
 * 自定义按钮图片与文字的位置
 */
-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    // UIImageView
    CGFloat imageX = 0;
    CGFloat imageY = 0;
    CGFloat imageW = self.bounds.size.width;
    CGFloat imageH = self.bounds.size.height * 0.8;
    self.imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
    
    
    // UILabel
    CGFloat labelY = imageH;
    CGFloat labelH = self.bounds.size.height - labelY;
    self.titleLabel.frame = CGRectMake(imageX, labelY, imageW, labelH);
}

@end
