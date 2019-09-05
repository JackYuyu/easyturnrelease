//
//  OTSyncViewStyleConfig.m
//  81-SyncView
//
//  Created by OUT MAN on 2017/9/15.
//  Copyright © 2017年 OUT MAN. All rights reserved.
//

#import "OTSyncViewStyleConfig.h"

@implementation OTSyncViewStyleConfig

- (instancetype)init {
    self = [super init];
    if (self) {
        _titleContainerBackgroundColor = kACColorWhite;
        _titleViewHeight = 45.f;
        _titleViewBackgroundColor = kACColorClear;
        _normalColor = kACColorGray2_R85_G85_B85_A1;
        _selectedColor = kACColorBlue_R85_G172_B238_A1;
        _fontSize = 14.f;
        
        _insets = UIEdgeInsetsMake(0, 25, 0, 25);
        _titleMargin = 25.f;
        
        _isAutoAdjustEnable = NO;
        
        _isScrollEnable = YES;
        
        _isScaleEnable = NO;
        _maxScale = 1.1;
        
        _isShowBottomLine = YES;
        _bottomLineColor = kACColorBlue_R85_G172_B238_A1;
        _bottomLineHeight = 2.f;
        _bottomLineWidth = 0.f;
        
        _isShowCoverView = NO;
        _coverViewColor = kACColorBlack;
        _coverViewAlpha = 0.4;
        _coverViewMargin = 8.f;
        _coverViewHeight = 25.f;
        _coverViewRadius = 12.5f;
    }
    return self;
}

@end
