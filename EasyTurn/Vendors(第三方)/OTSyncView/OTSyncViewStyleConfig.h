//
//  OTSyncViewStyleConfig.h
//  81-SyncView
//
//  Created by OUT MAN on 2017/9/15.
//  Copyright © 2017年 OUT MAN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OTSyncViewStyleConfig : NSObject

/** SyncTitleView 相关样式属性 */
@property (nonatomic, strong) UIColor *titleContainerBackgroundColor;
@property (nonatomic, assign) CGFloat titleViewHeight;
@property (nonatomic, strong) UIColor *titleViewBackgroundColor;
@property (nonatomic, strong) UIColor *normalColor;
@property (nonatomic, strong) UIColor *selectedColor;
@property (nonatomic, assign) CGFloat fontSize;

@property (nonatomic, assign) UIEdgeInsets insets;
@property (nonatomic, assign) CGFloat titleMargin;

@property (nonatomic, assign) BOOL isAutoAdjustEnable;

@property (nonatomic, assign) BOOL isScrollEnable;

@property (nonatomic, assign) BOOL isScaleEnable;
@property (nonatomic, assign) CGFloat maxScale;

@property (nonatomic, assign) BOOL isShowBottomLine;
@property (nonatomic, strong) UIColor *bottomLineColor;
@property (nonatomic, assign) CGFloat bottomLineHeight;
// 如果需要定宽, 请设置这个, 否则就是自动适配的宽度
@property (nonatomic, assign) CGFloat bottomLineWidth;

@property (nonatomic, assign) BOOL isShowCoverView;
@property (nonatomic, strong) UIColor *coverViewColor;
@property (nonatomic, assign) CGFloat coverViewAlpha;
@property (nonatomic, assign) CGFloat coverViewMargin;
@property (nonatomic, assign) CGFloat coverViewHeight;
@property (nonatomic, assign) CGFloat coverViewRadius;

@end
