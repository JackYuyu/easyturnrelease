//
//  OTSyncTitleView.m
//  81-SyncView
//
//  Created by OUT MAN on 2017/9/15.
//  Copyright © 2017年 OUT MAN. All rights reserved.
//

#import "OTSyncTitleView.h"
#import "OTSyncViewStyleConfig.h"

#define kDefaultConst (3333)

@interface OTSyncTitleView () {
    NSArray<NSString *> *_arrTitles;
    OTSyncViewStyleConfig *_styleConfig;
    NSInteger _currentIndex;
}

@property (nonatomic, strong) UIScrollView *svContainer;
@property (nonatomic, strong) UIView *vBottomLine;
@property (nonatomic, strong) UIView *vCover;
@property (nonatomic, strong) NSMutableArray<NSString *> *arrNormalColorRGB;
@property (nonatomic, strong) NSMutableArray<NSString *> *arrSelectColorRGB;
@property (nonatomic, strong) NSMutableArray<NSString *> *arrDifferenceRGB;
@property (nonatomic, strong) NSMutableArray<UILabel *> *arrLabels;

@end

@implementation OTSyncTitleView

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray<NSString *> *)arrTitles styleConfig:(OTSyncViewStyleConfig *)styleConfig {
    self = [super initWithFrame:frame];
    if (self) {
        _arrTitles = arrTitles;
        _styleConfig = styleConfig;
        _currentIndex = 0;
        self.backgroundColor = _styleConfig.titleContainerBackgroundColor;
        [self createSubViewsAndConstraints];
    }
    return self;
}

- (void)createSubViewsAndConstraints {
    if (!_arrTitles.count) return;
    
    [self addSubview:self.svContainer];
    
    if (_styleConfig.isAutoAdjustEnable) {
        CGFloat calculateW = _styleConfig.insets.left + (_arrTitles.count - 1) * _styleConfig.titleMargin + _styleConfig.insets.right;
        CGFloat calculateTitleMaxW = 0.f;
        for (int i = 0; i < _arrTitles.count; i++) {
            CGFloat tempTitleW = ceil([_arrTitles[i] boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, [UIFont systemFontOfSize:_styleConfig.fontSize].lineHeight) options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading) attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:_styleConfig.fontSize]} context:nil].size.width);
            calculateTitleMaxW = (tempTitleW > calculateTitleMaxW) ? tempTitleW : calculateTitleMaxW;
            calculateW += tempTitleW;
        }
        _styleConfig.isScrollEnable = calculateW > self.bounds.size.width;
        if (!_styleConfig.isScrollEnable) {
            if (_styleConfig.insets.left && _styleConfig.insets.right) {
                CGFloat calculateMargin = (self.bounds.size.width - _arrTitles.count * calculateTitleMaxW) / (_arrTitles.count + 1);
                _styleConfig.insets = UIEdgeInsetsMake(_styleConfig.insets.top, calculateMargin, _styleConfig.insets.bottom, calculateMargin);
                _styleConfig.titleMargin = calculateMargin;
            } else if (_styleConfig.insets.left || _styleConfig.insets.right) {
                CGFloat calculateMargin = (self.bounds.size.width - _arrTitles.count * calculateTitleMaxW) / _arrTitles.count;
                _styleConfig.insets = UIEdgeInsetsMake(_styleConfig.insets.top, (_styleConfig.insets.left ? calculateMargin : 0), _styleConfig.insets.bottom, (_styleConfig.insets.right ? calculateMargin : 0));
                _styleConfig.titleMargin = calculateMargin;
            } else {
                CGFloat calculateMargin = (self.bounds.size.width - _arrTitles.count * calculateTitleMaxW) / _arrTitles.count - 1;
                _styleConfig.insets = UIEdgeInsetsMake(_styleConfig.insets.top, 0, _styleConfig.insets.bottom, 0);
                _styleConfig.titleMargin = calculateMargin;
            }
        }
    }
    
    CGFloat labH = _styleConfig.isShowBottomLine && _styleConfig.bottomLineHeight ? (self.bounds.size.height - _styleConfig.bottomLineHeight) : self.bounds.size.height;
    CGFloat labW = _styleConfig.isScrollEnable ? 0 : ((self.bounds.size.width - _styleConfig.insets.left - _styleConfig.insets.right - (_arrTitles.count - 1) * _styleConfig.titleMargin) / _arrTitles.count);
    CGFloat labX = 0;
    CGFloat labY = 0;
    
    for (int i = 0; i < _arrTitles.count; i++) {
        NSString *strTitle = (NSString *)_arrTitles[i];
        UILabel *labTemp = [[UILabel alloc] init];
        labTemp.backgroundColor = _styleConfig.titleViewBackgroundColor;
        labTemp.userInteractionEnabled = YES;
        labTemp.tag = kDefaultConst + i;
        labTemp.text = strTitle;
        labTemp.textAlignment = NSTextAlignmentCenter;
        labTemp.textColor = i == 0 ? _styleConfig.selectedColor : _styleConfig.normalColor;
        labTemp.font = [UIFont systemFontOfSize:_styleConfig.fontSize];
        
        if (_styleConfig.isScrollEnable) {
            labW = ceil([strTitle boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, labTemp.font.lineHeight) options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading) attributes:@{NSFontAttributeName: labTemp.font} context:nil].size.width);
            labX = (i == 0) ? _styleConfig.insets.left : (CGRectGetMaxX(self.arrLabels[(i - 1)].frame) + _styleConfig.titleMargin);
        } else {
            labX = (i == 0) ? _styleConfig.insets.left : (CGRectGetMaxX(self.arrLabels[(i - 1)].frame) + _styleConfig.titleMargin);
        }
        
        [labTemp setFrame:CGRectMake(labX, labY, labW, labH)];
        
        [self.svContainer addSubview:labTemp];
        [self.arrLabels addObject:labTemp];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickTitle:)];
        [labTemp addGestureRecognizer:tapGesture];
    }
    
    if (_styleConfig.isScaleEnable) {
        UILabel *labFirst = self.arrLabels.firstObject;
        labFirst.transform = CGAffineTransformMakeScale(_styleConfig.maxScale, _styleConfig.maxScale);
    }

    if (_styleConfig.isScrollEnable) {
        UILabel *labLast = self.arrLabels.lastObject;
        self.svContainer.contentSize = CGSizeMake(CGRectGetMaxX(labLast.frame) + _styleConfig.insets.right, 0);
    }
    
    if (_styleConfig.isShowBottomLine) {
        CGFloat vBottomLineW = (_styleConfig.bottomLineWidth && _styleConfig.bottomLineWidth <= self.arrLabels.firstObject.frame.size.width) ? _styleConfig.bottomLineWidth : self.arrLabels.firstObject.frame.size.width;
        CGFloat vBottomLineX = self.arrLabels.firstObject.frame.origin.x + (self.arrLabels.firstObject.frame.size.width - vBottomLineW) * 0.5;
        self.vBottomLine.frame = CGRectMake(vBottomLineX, self.bounds.size.height - _styleConfig.bottomLineHeight, vBottomLineW, _styleConfig.bottomLineHeight);
        [self.svContainer addSubview:self.vBottomLine];
    }
    
    if (_styleConfig.isShowCoverView) {
        CGFloat vCoverW = self.arrLabels.firstObject.frame.size.width;
        CGFloat vCoverH = _styleConfig.coverViewHeight;
        CGFloat vCoverX = self.arrLabels.firstObject.frame.origin.x;
        CGFloat vCoverY = (self.arrLabels.firstObject.frame.size.height - vCoverH) * 0.5;
        if (_styleConfig.isScrollEnable) {
            vCoverX -= _styleConfig.coverViewMargin;
            vCoverW += 2 * _styleConfig.coverViewMargin;
        }
        self.vCover.frame = CGRectMake(vCoverX, vCoverY, vCoverW, vCoverH);
        self.vCover.layer.cornerRadius = _styleConfig.coverViewRadius;
        self.layer.masksToBounds = YES;
        [self.svContainer insertSubview:self.vCover atIndex:0];
    }
}

#pragma mark - Public APIs
- (void)resetTitlesWithTitles:(NSArray<NSString *> *)arrTitles {
    [self cleanTitlesAndResetDefaultValues];
    _arrTitles = arrTitles;
    [self createSubViewsAndConstraints];
}

- (void)resetTitlesWithTitles:(NSArray<NSString *> *)arrTitles styleConfig:(OTSyncViewStyleConfig *)styleConfig {
    [self cleanTitlesAndResetDefaultValues];
    _arrTitles = arrTitles;
    _styleConfig = styleConfig;
    self.backgroundColor = _styleConfig.titleContainerBackgroundColor;
    [self createSubViewsAndConstraints];
}

- (void)selectTitleWithIndex:(NSInteger)index {
    [self selectTitleWithIndex:index animated:YES];
}

- (void)selectTitleWithIndex:(NSInteger)index animated:(BOOL)animated {
    if (index >= self.arrLabels.count) return;
    UILabel *labSource = self.arrLabels[_currentIndex];
    labSource.textColor = _styleConfig.normalColor;
    _currentIndex = index;
    UILabel *labTarget = self.arrLabels[_currentIndex];
    labTarget.textColor = _styleConfig.selectedColor;
    [self adjustTitlePositionWithTitleLabel:self.arrLabels[_currentIndex]];
    
    if (_styleConfig.isScaleEnable) {
        if (animated) {
            [UIView animateWithDuration:0.25 animations:^{
                labSource.transform = CGAffineTransformIdentity;
                labTarget.transform = CGAffineTransformMakeScale(_styleConfig.maxScale, _styleConfig.maxScale);
            }];
        } else {
            labSource.transform = CGAffineTransformIdentity;
            labTarget.transform = CGAffineTransformMakeScale(_styleConfig.maxScale, _styleConfig.maxScale);
        }
    }
    
    if (_styleConfig.isShowBottomLine) {
        CGFloat vBottomLineW = (_styleConfig.bottomLineWidth && _styleConfig.bottomLineWidth <= labTarget.frame.size.width) ? _styleConfig.bottomLineWidth : labTarget.frame.size.width;
        CGFloat vBottomLineX = labTarget.frame.origin.x + (labTarget.frame.size.width - vBottomLineW) * 0.5;
        if (animated) {
            [UIView animateWithDuration:0.25 animations:^{
                CGRect vBottomLineRect = self.vBottomLine.frame;
                vBottomLineRect.origin.x = vBottomLineX;
                vBottomLineRect.size.width = vBottomLineW;
                self.vBottomLine.frame = vBottomLineRect;
            }];
        } else {
            CGRect vBottomLineRect = self.vBottomLine.frame;
            vBottomLineRect.origin.x = vBottomLineX;
            vBottomLineRect.size.width = vBottomLineW;
            self.vBottomLine.frame = vBottomLineRect;
        }
    }
    
    if (_styleConfig.isShowCoverView) {
        if (animated) {
            [UIView animateWithDuration:0.25 animations:^{
                CGRect vCoverRect = self.vCover.frame;
                vCoverRect.origin.x = labTarget.frame.origin.x;
                vCoverRect.size.width = labTarget.frame.size.width;
                if (self->_styleConfig.isScrollEnable) {
                    vCoverRect.origin.x -= self->_styleConfig.coverViewMargin;
                    vCoverRect.size.width += 2 * self->_styleConfig.coverViewMargin;
                }
                self.vCover.frame = vCoverRect;
            }];
        } else {
            CGRect vCoverRect = self.vCover.frame;
            vCoverRect.origin.x = labTarget.frame.origin.x;
            vCoverRect.size.width = labTarget.frame.size.width;
            if (_styleConfig.isScrollEnable) {
                vCoverRect.origin.x -= _styleConfig.coverViewMargin;
                vCoverRect.size.width += 2 * _styleConfig.coverViewMargin;
            }
            self.vCover.frame = vCoverRect;
        }
    }
}

//- (void)handleTitleColorGradualChangeWithSourceIndex:(NSInteger)sourceIndex targetIndex:(NSInteger)targetIndex progress:(CGFloat)progress {
//    if (sourceIndex >= self.arrLabels.count || targetIndex >= self.arrLabels.count) return;
//    
//    UILabel *labSource = self.arrLabels[sourceIndex];
//    UILabel *labTarget = self.arrLabels[targetIndex];
//
//    // 颜色渐变滑动快 会奔溃, 目前存在问题
//    labSource.textColor = [UIColor colorWithRed:[self.arrSelectColorRGB[0] floatValue] - progress * [self.arrDifferenceRGB[0] floatValue] green:[self.arrSelectColorRGB[1] floatValue] - progress * [self.arrDifferenceRGB[1] floatValue] blue:[self.arrSelectColorRGB[2] floatValue] - progress * [self.arrDifferenceRGB[2] floatValue] alpha:1.0];
//    labTarget.textColor = [UIColor colorWithRed:[self.arrNormalColorRGB[0] floatValue] + progress * [self.arrDifferenceRGB[0] floatValue] green:[self.arrNormalColorRGB[1] floatValue] + progress * [self.arrDifferenceRGB[1] floatValue] blue:[self.arrNormalColorRGB[2] floatValue] + progress * [self.arrDifferenceRGB[2] floatValue] alpha:1.0];
//    
//    labSource.textColor = _styleConfig.normalColor;
//    labTarget.textColor = _styleConfig.selectedColor;
//}

#pragma mark - Private APIs
- (void)cleanTitlesAndResetDefaultValues {
    [self.arrLabels makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.arrLabels = nil;
    _currentIndex = 0;
}

- (void)adjustTitlePositionWithTitleLabel:(UILabel *)labTitle {
    CGFloat offsetX = labTitle.center.x - self.bounds.size.width * 0.5;
    if (offsetX < 0) offsetX = 0;
    if (offsetX > self.svContainer.contentSize.width - self.svContainer.bounds.size.width) offsetX = (self.svContainer.contentSize.width - self.svContainer.bounds.size.width) > 0 ? (self.svContainer.contentSize.width - self.svContainer.bounds.size.width) : 0;
    [self.svContainer setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}

- (void)getColorRGBWithColor:(nullable UIColor *)color r:(nullable CGFloat *)r g:(nullable CGFloat *)g b:(CGFloat *)b {
    if (![color isKindOfClass:[UIColor class]]) return;
    [color getRed:r green:g blue:b alpha:nil];
}

#pragma mark - Gesture Actions
- (void)onClickTitle:(UITapGestureRecognizer *)tapGesture {
    if (![tapGesture.view isKindOfClass:[UILabel class]]) return;
    UILabel *labTarget = (UILabel *)tapGesture.view;
    if ((labTarget.tag - kDefaultConst) == _currentIndex) return;
    UILabel *labSource = self.arrLabels[_currentIndex];
    labSource.textColor = _styleConfig.normalColor;
    labTarget.textColor = _styleConfig.selectedColor;
    _currentIndex = labTarget.tag - kDefaultConst;
    
    if (_styleConfig.isScrollEnable) [self adjustTitlePositionWithTitleLabel:labTarget];
    
    if (_styleConfig.isScaleEnable) {
        [UIView animateWithDuration:0.25 animations:^{
            labSource.transform = CGAffineTransformIdentity;
            labTarget.transform = CGAffineTransformMakeScale(self->_styleConfig.maxScale, self->_styleConfig.maxScale);
        }];
    }
    
    if (_styleConfig.isShowBottomLine) {
        
        CGFloat vBottomLineW = (_styleConfig.bottomLineWidth && _styleConfig.bottomLineWidth <= labTarget.frame.size.width) ? _styleConfig.bottomLineWidth : labTarget.frame.size.width;
        CGFloat vBottomLineX = labTarget.frame.origin.x + (labTarget.frame.size.width - vBottomLineW) * 0.5;
        
        [UIView animateWithDuration:0.25 animations:^{
            CGRect vbottomLineRect = self.vBottomLine.frame;
            vbottomLineRect.origin.x = vBottomLineX;
            vbottomLineRect.size.width = vBottomLineW;
            self.vBottomLine.frame = vbottomLineRect;
        }];
    }
    
    if (_styleConfig.isShowCoverView) {
        CGFloat vCoverX = _styleConfig.isScrollEnable ? labTarget.frame.origin.x - _styleConfig.coverViewMargin : labTarget.frame.origin.x;
        CGFloat vCoverW = _styleConfig.isScrollEnable ? labTarget.frame.size.width + 2 * _styleConfig.coverViewMargin : labTarget.frame.size.width;
        [UIView animateWithDuration:0.25 animations:^{
            CGRect vCoverRect = self.vCover.frame;
            vCoverRect.origin.x = vCoverX;
            vCoverRect.size.width = vCoverW;
            self.vCover.frame = vCoverRect;
        }];
    }
    
    if ([_delegate respondsToSelector:@selector(syncTitleView:selectedTitle:selectedIndex:)]) {
        [_delegate syncTitleView:self selectedTitle:labTarget.text selectedIndex:_currentIndex];
    }
}

#pragma mark - Lazy Load
- (UIScrollView *)svContainer {
    if (!_svContainer) {
        _svContainer = [[UIScrollView alloc] initWithFrame:self.bounds];
        _svContainer.showsHorizontalScrollIndicator = NO;
        _svContainer.showsVerticalScrollIndicator = NO;
        _svContainer.scrollsToTop = NO;
    }
    return _svContainer;
}


- (NSMutableArray<UILabel *> *)arrLabels {
    if (!_arrLabels) {
        _arrLabels = [NSMutableArray array];
    }
    return _arrLabels;
}

- (UIView *)vBottomLine {
    if (!_vBottomLine) {
        _vBottomLine = [[UIView alloc] init];
        _vBottomLine.backgroundColor = _styleConfig.bottomLineColor;
    }
    return _vBottomLine;
}

- (UIView *)vCover {
    if (!_vCover) {
        _vCover = [[UIView alloc] init];
        _vCover.backgroundColor = _styleConfig.coverViewColor;
        _vCover.alpha = _styleConfig.coverViewAlpha;
    }
    return _vCover;
}

-  (NSMutableArray<NSString *> *)arrNormalColorRGB {
    if (!_arrNormalColorRGB) {
        _arrNormalColorRGB = [NSMutableArray array];
        CGFloat normalColorR = 0;
        CGFloat normalColorG = 0;
        CGFloat normalColorB = 0;
        [self getColorRGBWithColor:_styleConfig.normalColor r:&normalColorR g:&normalColorG b:&normalColorB];
        [_arrNormalColorRGB addObject:[NSString stringWithFormat:@"%f", normalColorR]];
        [_arrNormalColorRGB addObject:[NSString stringWithFormat:@"%f", normalColorG]];
        [_arrNormalColorRGB addObject:[NSString stringWithFormat:@"%f", normalColorB]];
    }
    return _arrNormalColorRGB;
}

- (NSMutableArray<NSString *> *)arrSelectColorRGB {
    if (!_arrSelectColorRGB) {
        _arrSelectColorRGB = [NSMutableArray array];
        CGFloat selectedColorR = 0;
        CGFloat selectedColorG = 0;
        CGFloat selectedColorB = 0;
        [self getColorRGBWithColor:_styleConfig.selectedColor r:&selectedColorR g:&selectedColorG b:&selectedColorB];
        [_arrSelectColorRGB addObject:[NSString stringWithFormat:@"%f", selectedColorR]];
        [_arrSelectColorRGB addObject:[NSString stringWithFormat:@"%f", selectedColorG]];
        [_arrSelectColorRGB addObject:[NSString stringWithFormat:@"%f", selectedColorB]];
    }
    return _arrSelectColorRGB;
}

- (NSMutableArray<NSString *> *)arrDifferenceRGB {
    if (!_arrDifferenceRGB) {
        _arrDifferenceRGB = [NSMutableArray array];
        [_arrDifferenceRGB addObject:[NSString stringWithFormat:@"%f", [self.arrSelectColorRGB[0] floatValue] - [self.arrNormalColorRGB[0] floatValue]]];
        [_arrDifferenceRGB addObject:[NSString stringWithFormat:@"%f", [self.arrSelectColorRGB[1] floatValue] - [self.arrNormalColorRGB[1] floatValue]]];
        [_arrDifferenceRGB addObject:[NSString stringWithFormat:@"%f", [self.arrSelectColorRGB[2] floatValue] - [self.arrNormalColorRGB[2] floatValue]]];
    }
    return _arrDifferenceRGB;
}

@end
