//
//  OTAutoScrollViewStyleConfig.h
//  AutoTraderCloud
//
//  Created by OUT MAN on 2017/10/16.
//  Copyright © 2017年 AutoHome. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, OTAutoScrollViewScrollDirection) {
    OTAutoScrollViewScrollDirectionVertical = 0,
    OTAutoScrollViewScrollDirectionHorizontal
};

typedef NS_ENUM(NSUInteger, OTAutoScrollViewPageControlLocation) {
    OTAutoScrollViewPageControlLocationAboveScrollView = 0,
    OTAutoScrollViewPageControlLocationUnderScrollView
};

typedef NS_ENUM(NSUInteger, OTAutoScrollViewPageControlPositionAlignment) {
    OTAutoScrollViewPageControlPositionAlignmentCenter = 0,
    OTAutoScrollViewPageControlPositionAlignmentLeft,
    OTAutoScrollViewPageControlPositionAlignmentRight
};

@interface OTAutoScrollViewStyleConfig : NSObject

@property (nonatomic, assign) OTAutoScrollViewScrollDirection scrollDirection;

@property (nonatomic, assign) BOOL isShowPageControl;
@property (nonatomic, assign) CGFloat pageControlHeight;
@property (nonatomic, assign) CGFloat pageControlLeftMargin;
@property (nonatomic, assign) CGFloat pageControlRightMargin;
@property (nonatomic, assign) CGFloat pageControlIndicatorMargin;
@property (nonatomic, strong) UIImage *pageControlNormalIndicatorImage;
@property (nonatomic, strong) UIImage *pageControlCurrentIndicatorImage;
@property (nonatomic, assign) OTAutoScrollViewPageControlLocation pageControlLocation;
@property (nonatomic, assign) OTAutoScrollViewPageControlPositionAlignment pageControlPositionAlignment;

@end
