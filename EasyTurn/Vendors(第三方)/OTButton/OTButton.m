//
//  OTButton.m
//  AutoTraderCloud
//
//  Created by OUT MAN on 2017/9/8.
//  Copyright © 2017年 AutoHome. All rights reserved.
//

#import "OTButton.h"

@implementation OTButton

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat margin = self.ot_marginWithImageViewAndLabel;
    
    CGFloat labW = CGRectGetWidth(self.titleLabel.bounds);
    CGFloat labH = CGRectGetHeight(self.titleLabel.bounds);
    CGFloat ivW = CGRectGetWidth(self.imageView.bounds);
    CGFloat ivH = CGRectGetHeight(self.imageView.bounds);
    
    CGFloat btnCenterX = CGRectGetWidth(self.bounds) * 0.5;
    CGFloat ivCenterX = btnCenterX - labW * 0.5;
    CGFloat labCenterX = btnCenterX + ivW * 0.5;
    
    switch (self.ot_styleWithImageViewAndLabelAlignment) {
        case OTButtonImageViewAndLabelAlignmentStyleImageViewLeftAndLabelRight:
        {
            self.imageEdgeInsets = UIEdgeInsetsMake(0, -(margin * 0.5), 0, margin * 0.5);
            self.titleEdgeInsets = UIEdgeInsetsMake(0, margin * 0.5, 0, -(margin * 0.5));
        }
            break;
        case OTButtonImageViewAndLabelAlignmentStyleImageViewRightAndLabelLeft:
        {
            self.imageEdgeInsets = UIEdgeInsetsMake(0, margin * 0.5 + labW, 0, -(margin * 0.5 + labW));
            self.titleEdgeInsets = UIEdgeInsetsMake(0, -(margin * 0.5 + ivW), 0, margin * 0.5 + ivW);
        }
            break;
        case OTButtonImageViewAndLabelAlignmentStyleImageViewTopAndLabelBottom:
        {
            self.imageEdgeInsets = UIEdgeInsetsMake(-(labH * 0.5 + margin * 0.5), btnCenterX - ivCenterX, labH * 0.5 + margin * 0.5, -(btnCenterX - ivCenterX));
            self.titleEdgeInsets = UIEdgeInsetsMake(ivH * 0.5 + margin * 0.5, -(labCenterX - btnCenterX), -(ivH * 0.5 + margin * 0.5), labCenterX - btnCenterX);
            CGRect labBounds = self.titleLabel.bounds;
            labBounds.size.width = self.bounds.size.width;
            self.titleLabel.bounds = labBounds;
            self.titleLabel.textAlignment = NSTextAlignmentCenter;
        }
            break;
        case OTButtonImageViewAndLabelAlignmentStyleImageViewBottomAndLabelTop:
        {
            self.imageEdgeInsets = UIEdgeInsetsMake(labH * 0.5 + margin * 0.5, btnCenterX - ivCenterX, -(labH * 0.5 + margin * 0.5), -(btnCenterX - ivCenterX));
            self.titleEdgeInsets = UIEdgeInsetsMake(-(ivH * 0.5 + margin * 0.5), -(labCenterX - btnCenterX), ivH * 0.5 + margin * 0.5, labCenterX - btnCenterX);
            CGRect labBounds = self.titleLabel.bounds;
            labBounds.size.width = self.bounds.size.width;
            self.titleLabel.bounds = labBounds;
            self.titleLabel.textAlignment = NSTextAlignmentCenter;
        }
            break;
    }
}

- (void)setHighlighted:(BOOL)highlighted {
    
}

@end
