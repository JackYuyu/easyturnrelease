//
//  OTSyncContainerView.m
//  81-SyncView
//
//  Created by OUT MAN on 2017/9/15.
//  Copyright © 2017年 OUT MAN. All rights reserved.
//

#import "OTSyncContainerView.h"

#define kSyncContentCellReuseID @"kSyncContentCellReuseID"

@interface OTSyncContainerView () <UICollectionViewDataSource, UICollectionViewDelegate> {
    NSArray<UIViewController *> *_arrChildVCs;
    UIViewController *_vcParent;
    CGFloat _startOffsetX;
//    BOOL _isForbidDelegate;
}

@property (nonatomic, strong) UICollectionView *cvContent;

@end

@implementation OTSyncContainerView

- (instancetype)initWithFrame:(CGRect)frame childViewControllers:(NSArray<UIViewController *> *)arrChildVCs parentViewController:(UIViewController *)parentVC {
    self = [super initWithFrame:frame];
    if (self) {
        _arrChildVCs = arrChildVCs;
        _vcParent = parentVC;
        _startOffsetX = 0;
//        _isForbidDelegate = NO;
        [self createSubViewsAndConstraints];
    }
    return self;
}

#pragma mark - Public APIs
- (void)scrollToItem:(NSInteger)item {
    if (item >= _arrChildVCs.count) return;
//    _isForbidDelegate = YES;
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:0];
    [_cvContent scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}

- (void)createSubViewsAndConstraints {
    [self addSubview:self.cvContent];
    
    for (UIViewController *vcTemp in _arrChildVCs) {
        [_vcParent addChildViewController:vcTemp];
    }
}

#pragma mark - Private APIs
- (void)handleCollectionViewDidEndScroll {
    NSInteger item = (NSInteger)_cvContent.contentOffset.x / _cvContent.bounds.size.width;
    if ([_delegate respondsToSelector:@selector(syncContainerView:scrollToItem:)]) {
        [_delegate syncContainerView:self scrollToItem:item];
    }
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _arrChildVCs.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kSyncContentCellReuseID forIndexPath:indexPath];
    
    for (UIView *vTemp in cell.contentView.subviews) {
        [vTemp removeFromSuperview];
    }
    UIViewController *vcTemp = _arrChildVCs[indexPath.item];
    vcTemp.view.frame = cell.contentView.bounds;
    [cell.contentView addSubview:vcTemp.view];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self handleCollectionViewDidEndScroll];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        [self handleCollectionViewDidEndScroll];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
//    _isForbidDelegate = NO;
    _startOffsetX = scrollView.contentOffset.x;
}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    if (scrollView.contentOffset.x == _startOffsetX || _isForbidDelegate) return;
//    
//    CGFloat progress = 0.f;
//    NSInteger targetIndex = 0;
//    NSInteger sourceIndex = (NSInteger)(_startOffsetX / _cvContent.bounds.size.width);
//    
//    if (_cvContent.contentOffset.x > _startOffsetX) {
//        targetIndex = ((sourceIndex + 1) > (_arrChildVCs.count - 1)) ? (_arrChildVCs.count - 1) :  (sourceIndex + 1);
//        progress = (_cvContent.contentOffset.x - _startOffsetX) / _cvContent.bounds.size.width;
//    } else {
//        targetIndex = (sourceIndex - 1 < 0) ? 0 : (sourceIndex - 1);
//        progress = (_startOffsetX - _cvContent.contentOffset.x) / _cvContent.bounds.size.width;
//    }
//    
//    NSLog(@"%zd --- %zd ---", sourceIndex, targetIndex);
//    
//    if ([_delegate respondsToSelector:@selector(syncContainerView:sourceItem:targetItem:progress:)]) {
//        [_delegate syncContainerView:self sourceItem:sourceIndex targetItem:targetIndex progress:progress];
//    }
//}

#pragma mark - Lazy Load
- (UICollectionView *)cvContent {
    if (!_cvContent) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = self.bounds.size;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _cvContent = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        _cvContent.showsHorizontalScrollIndicator = NO;
        _cvContent.showsVerticalScrollIndicator = NO;
        _cvContent.pagingEnabled = YES;
        _cvContent.scrollsToTop = NO;
        _cvContent.bounces = NO;
        _cvContent.delegate = self;
        _cvContent.dataSource = self;
        [_cvContent registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kSyncContentCellReuseID];
        
    }
    return _cvContent;
}

@end
