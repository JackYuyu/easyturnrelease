//
//  OTSyncView.m
//  81-SyncView
//
//  Created by OUT MAN on 2017/9/15.
//  Copyright © 2017年 OUT MAN. All rights reserved.
//

#import "OTSyncView.h"

@interface OTSyncView () <OTSyncTitleViewDelegate, OTSyncContainerViewDelegate> {
    NSArray<NSString *> *_arrTitles;
    NSArray<UIViewController *> *_arrChildVCs;
    UIViewController *_vcParent;
    OTSyncViewStyleConfig *_styleConfig;
}

@property (nonatomic, strong) OTSyncTitleView *vTitleContainer;
@property (nonatomic, strong) OTSyncContainerView *vContentContainer;

@end

@implementation OTSyncView

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray<NSString *> *)arrTitles childViewControllers:(NSArray<UIViewController *> *)arrChildVCs parentViewController:(UIViewController *)parentVC styleConfig:(OTSyncViewStyleConfig *)styleConfig {
    self = [super initWithFrame:frame];
    if (self) {
        _arrTitles = arrTitles;
        _arrChildVCs = arrChildVCs;
        _vcParent = parentVC;
        _styleConfig = styleConfig;
        [self createSubViewsAndConstraints];
    }
    return self;
}

- (void)createSubViewsAndConstraints {
    [self addSubview:self.vTitleContainer];
    self.vTitleContainer.delegate = self;
    
    [self addSubview:self.vContentContainer];
    self.vContentContainer.delegate = self;
}

- (void)titleScrollToIndexController:(NSUInteger)index {
    //滚动标题
    [self.vContentContainer scrollToItem:index];
    [self handleScrollToTargetWithIndex:index];
    // 滚动下面控制器
    [self.vTitleContainer selectTitleWithIndex:index];
    [self handleScrollToTargetWithIndex:index];
}

#pragma mark - OTSyncTitleViewDelegate
- (void)syncTitleView:(OTSyncTitleView *)vSyncTitle selectedTitle:(NSString *)title selectedIndex:(NSInteger)index {
    [self.vContentContainer scrollToItem:index];
    [self handleScrollToTargetWithIndex:index];
}

#pragma mark - OTSyncContainerViewDelegate
- (void)syncContainerView:(OTSyncContainerView *)vSyncContainer scrollToItem:(NSInteger)item {
    [self.vTitleContainer selectTitleWithIndex:item];
    [self handleScrollToTargetWithIndex:item];
}

- (void)handleScrollToTargetWithIndex:(NSInteger)index {
    if (!_arrTitles.count && _arrChildVCs.count && _arrTitles.count == _arrChildVCs.count) return;
    if (index >= _arrTitles.count) return;
    if ([_delegate respondsToSelector:@selector(syncView:scrollToIndex:title:childViewController:)]) {
        [_delegate syncView:self scrollToIndex:index title:[_arrTitles objectAtIndex:index] childViewController:[_arrChildVCs objectAtIndex:index]];
    }
}

//- (void)syncContainerView:(OTSyncContainerView *)vSyncContainer sourceItem:(NSInteger)sourceItem targetItem:(NSInteger)targetItem progress:(CGFloat)progress {
//    [self.vTitleContainer handleTitleColorGradualChangeWithSourceIndex:sourceItem targetIndex:targetItem progress:progress];
//}

#pragma mark - Lazy Load
- (OTSyncTitleView *)vTitleContainer {
    if (!_vTitleContainer) {
        _vTitleContainer = [[OTSyncTitleView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, _styleConfig.titleViewHeight) titles:_arrTitles styleConfig:_styleConfig];
    }
    return _vTitleContainer;
}

- (OTSyncContainerView *)vContentContainer {
    if (!_vContentContainer) {
        _vContentContainer = [[OTSyncContainerView alloc] initWithFrame:CGRectMake(0, _styleConfig.titleViewHeight, self.bounds.size.width, self.bounds.size.height - _styleConfig.titleViewHeight) childViewControllers:_arrChildVCs parentViewController:_vcParent];
    }
    return _vContentContainer;
}

@end
