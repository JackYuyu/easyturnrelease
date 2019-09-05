//
//  OTAutoScrollViewStyleConfig.m
//  AutoTraderCloud
//
//  Created by OUT MAN on 2017/10/16.
//  Copyright © 2017年 AutoHome. All rights reserved.
//

#import "OTAutoScrollViewStyleConfig.h"

@implementation OTAutoScrollViewStyleConfig

- (instancetype)init {
    self = [super init];
    if (self) {
        _isShowPageControl = YES;
        _pageControlHeight = 18.f;
        _pageControlLeftMargin = 15.f;
        _pageControlRightMargin = 15.f;
        _pageControlIndicatorMargin = 6.f;
        _pageControlNormalIndicatorImage = [UIImage ak_imageWithColor:kACColorGray4_R201_G201_B201_A1 size:CGSizeMake(3, 3)];
        _pageControlCurrentIndicatorImage = [UIImage ak_imageWithColor:kACColorWhite size:CGSizeMake(5, 5)];
        _pageControlLocation = OTAutoScrollViewPageControlLocationAboveScrollView;
        _pageControlPositionAlignment = OTAutoScrollViewPageControlPositionAlignmentRight;
    }
    return self;
}

@end
