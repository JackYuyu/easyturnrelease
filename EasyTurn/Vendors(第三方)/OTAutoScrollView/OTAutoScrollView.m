//
//  OTAutoScrollView.m
//  AutoTraderCloud
//
//  Created by OUT MAN on 2017/10/16.
//  Copyright © 2017年 AutoHome. All rights reserved.
//

#import "OTAutoScrollView.h"
#import "SMPageControl.h"
#define kDefaultCount (3)

@interface OTAutoScrollView () <UICollectionViewDataSource, UICollectionViewDelegate> {
    UICollectionView *_cvAutoScroll;
    OTAutoScrollViewStyleConfig *_style;
    SMPageControl *_pcControl;
    BOOL _isShowPageControl;
    NSInteger _itemsCountInEverySection;
}

@property (nonatomic, strong) NSTimer *timer;
@end

@implementation OTAutoScrollView

- (instancetype)initWithFrame:(CGRect)frame style:(OTAutoScrollViewStyleConfig *)style {
    self = [super initWithFrame:frame];
    if (self) {
        _style = style;
        _isNeedAutoScroll = YES;
        _timeInterval = 2.f;
        _isShowPageControl = YES;
        [self createSubViewsAndConstraints];
    }
    return self;
}

- (void)createSubViewsAndConstraints {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat cvAutoScrollH = [self calculateAutoScrollCollectionViewHeightAndconfigLayoutWithLayout:layout];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    
    _cvAutoScroll = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, cvAutoScrollH) collectionViewLayout:layout];
    _cvAutoScroll.dataSource = self;
    _cvAutoScroll.delegate = self;
    _cvAutoScroll.backgroundColor = kACColorClear;
    _cvAutoScroll.pagingEnabled = YES;
    _cvAutoScroll.scrollsToTop = NO;
    _cvAutoScroll.showsVerticalScrollIndicator = NO;
    _cvAutoScroll.showsHorizontalScrollIndicator = NO;
    _cvAutoScroll.bounces = NO;
    [self addSubview:_cvAutoScroll];
    
    _pcControl = [[SMPageControl alloc] initWithFrame:CGRectZero];
    _pcControl.hidden = YES;
    _pcControl.backgroundColor = kACColorClear;
    [_pcControl setUserInteractionEnabled:NO];
    [self addSubview:_pcControl];
    
    [self configPageControl];
}

#pragma mark - Private APIs
- (void)timerFire {
    [self timerInvalidateAndSetNil];
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:_timeInterval target:self selector:@selector(timerChange) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    [_timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:_timeInterval]];
}

- (void)timerInvalidateAndSetNil {
    [_timer invalidate];
    _timer = nil;
}

- (void)adjustADPosition {
    if (_itemsCountInEverySection <= 1) return;
   
    CGFloat offset = _style.scrollDirection == OTAutoScrollViewScrollDirectionHorizontal ? _cvAutoScroll.contentOffset.x : _cvAutoScroll.contentOffset.y;
    CGFloat spacer = _style.scrollDirection == OTAutoScrollViewScrollDirectionHorizontal ? _cvAutoScroll.bounds.size.width : _cvAutoScroll.bounds.size.height;
    NSInteger offsetItemCount = offset / spacer;
    NSInteger section = offsetItemCount / _itemsCountInEverySection;
    NSInteger item = offsetItemCount % _itemsCountInEverySection;
    if (item == 0) {
        if (section == 0) {
            CGPoint point = _style.scrollDirection == OTAutoScrollViewScrollDirectionHorizontal ? CGPointMake(_itemsCountInEverySection * spacer, 0) : CGPointMake(0, _itemsCountInEverySection * spacer);
            [_cvAutoScroll setContentOffset:point animated:NO];
        }
    } else if (item == (_itemsCountInEverySection - 1)) {
        if (section == (kDefaultCount - 1)) {
            CGPoint point = _style.scrollDirection == OTAutoScrollViewScrollDirectionHorizontal ? CGPointMake((_itemsCountInEverySection * 2 - 1) * spacer, 0) : CGPointMake(0, (_itemsCountInEverySection * 2 - 1) * spacer);
            [_cvAutoScroll setContentOffset:point animated:NO];
        }
    }
    
    if (_itemsCountInEverySection > 1) _pcControl.currentPage = item;
}

- (void)caculatePageControlIndex {
    CGFloat offset = _style.scrollDirection == OTAutoScrollViewScrollDirectionHorizontal ? _cvAutoScroll.contentOffset.x : _cvAutoScroll.contentOffset.y;
    CGFloat spacer = _style.scrollDirection == OTAutoScrollViewScrollDirectionHorizontal ? _cvAutoScroll.bounds.size.width : _cvAutoScroll.bounds.size.height;
    NSInteger offsetItemCountFloat = offset / spacer;
    NSInteger offsetItemCount = (NSInteger)round(offsetItemCountFloat);
    NSInteger item = offsetItemCount % _itemsCountInEverySection;
    if (_itemsCountInEverySection > 1) _pcControl.currentPage = item;
}

- (void)timerChange {
    if (_itemsCountInEverySection <= 1) return;
    
    CGFloat offset = _style.scrollDirection == OTAutoScrollViewScrollDirectionHorizontal ? _cvAutoScroll.contentOffset.x : _cvAutoScroll.contentOffset.y;
    CGFloat spacer = _style.scrollDirection == OTAutoScrollViewScrollDirectionHorizontal ? _cvAutoScroll.bounds.size.width : _cvAutoScroll.bounds.size.height;
    NSInteger offsetItemCount = offset / spacer;
    NSInteger section = offsetItemCount / _itemsCountInEverySection;
    NSInteger item = offsetItemCount % _itemsCountInEverySection;
    
    if (item >= _itemsCountInEverySection - 1) {
        if (section >= (kDefaultCount - 1)) {
            section = 0;
            item = 0;
            NSError *error = [NSError errorWithDomain:@"OTAutoScrollView 自动滚动挂了 滚动重置" code:99887766 userInfo:nil];
        } else {
            section += 1;
            item = 0;
        }
    } else {
        item += 1;
    }
    
    UICollectionViewScrollPosition scrollPosition = _style.scrollDirection == OTAutoScrollViewScrollDirectionHorizontal ? UICollectionViewScrollPositionCenteredHorizontally : UICollectionViewScrollPositionCenteredVertically;
    [_cvAutoScroll scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:item inSection:section] atScrollPosition:scrollPosition animated:YES];
}

#pragma mark - Public APIs
- (void)registerClass:(Class)cellClass forCellWithReuseIdentifier:(NSString *)identifier {
    [_cvAutoScroll registerClass:cellClass forCellWithReuseIdentifier:identifier];
}

- (UICollectionViewCell *)dequeueReusableCellWithReuseIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath {
    return [_cvAutoScroll dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
}

- (void)reloadData {
    [self timerInvalidateAndSetNil];
    
    if ([_dataSource respondsToSelector:@selector(autoScrollView:numberOfItemsInSection:)   ]) {
        NSInteger realCount = [_dataSource autoScrollView:self numberOfItemsInSection:0];
        _pcControl.numberOfPages = realCount;
        _itemsCountInEverySection = realCount;
    }
    
    [_cvAutoScroll reloadData];
    
    if (_itemsCountInEverySection <= 1 || !self.isNeedAutoScroll) {
        [_cvAutoScroll setContentOffset:CGPointZero animated:NO];
        return;
    }
    
    [_cvAutoScroll scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:1] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
    _pcControl.currentPage = 0;
    [self timerFire];
}

- (void)reloadDataWithStyleConfig:(OTAutoScrollViewStyleConfig *)styleConfig animated:(BOOL)animated completion:(void (^)(BOOL finished))completion {
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)_cvAutoScroll.collectionViewLayout;
    if (!layout) return;
    
    _style = styleConfig;
    CGFloat cvAutoScrollH = [self calculateAutoScrollCollectionViewHeightAndconfigLayoutWithLayout:layout];
    _cvAutoScroll.height = cvAutoScrollH;
    
    [self configPageControl];
    
    [_cvAutoScroll setCollectionViewLayout:layout animated:animated completion:completion];
    [_cvAutoScroll reloadData];
}

- (CGFloat)calculateAutoScrollCollectionViewHeightAndconfigLayoutWithLayout:(UICollectionViewFlowLayout *)layout {
    _isShowPageControl = _style.isShowPageControl && (_style.pageControlHeight > 0);
    CGFloat autoScrollH = ((_style.pageControlLocation == OTAutoScrollViewPageControlLocationUnderScrollView && _isShowPageControl) ? self.bounds.size.height - _style.pageControlHeight : self.bounds.size.height);
    layout.itemSize = CGSizeMake(self.bounds.size.width, autoScrollH);
    layout.scrollDirection = (_style.scrollDirection == OTAutoScrollViewScrollDirectionHorizontal) ? UICollectionViewScrollDirectionHorizontal : UICollectionViewScrollDirectionVertical;
    return autoScrollH;
}

- (void)configPageControl {
    if (_isShowPageControl) {
        CGFloat pcControlH = _style.pageControlHeight;
        CGFloat pcControlW = self.bounds.size.width - _style.pageControlLeftMargin - _style.pageControlRightMargin;
        CGFloat pcControlX = _style.pageControlLeftMargin;
        CGFloat pcControlY = self.bounds.size.height - _style.pageControlHeight;
        [_pcControl setFrame:CGRectMake(pcControlX, pcControlY, pcControlW, pcControlH)];
        
        switch (_style.pageControlPositionAlignment) {
            case OTAutoScrollViewPageControlPositionAlignmentCenter:
            {
                _pcControl.alignment = SMPageControlAlignmentCenter;
            }
                break;
            case OTAutoScrollViewPageControlPositionAlignmentLeft:
            {
                _pcControl.alignment = SMPageControlAlignmentLeft;
            }
                break;
            case OTAutoScrollViewPageControlPositionAlignmentRight:
            {
                _pcControl.alignment = SMPageControlAlignmentRight;
            }
                break;
            default:
                break;
        }
        
        _pcControl.indicatorMargin = _style.pageControlIndicatorMargin;
        [_pcControl setPageIndicatorImage:_style.pageControlNormalIndicatorImage];
        [_pcControl setCurrentPageIndicatorImage:_style.pageControlCurrentIndicatorImage];
        _pcControl.hidden = NO;
    } else {
        _pcControl.hidden = YES;
    }
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return ((_itemsCountInEverySection > 1) ? kDefaultCount : 1);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _itemsCountInEverySection;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([_dataSource respondsToSelector:@selector(autoScrollView:cellForItemAtIndexPath:)]) {
        return [_dataSource autoScrollView:self cellForItemAtIndexPath:indexPath];
    }
    return nil;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:NO];
    if ([_delegate respondsToSelector:@selector(autoScrollView:didSelectItemAtIndexPath:)]) {
        [_delegate autoScrollView:self didSelectItemAtIndexPath:indexPath];
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self timerInvalidateAndSetNil];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self caculatePageControlIndex];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self adjustADPosition];
    if (self.isNeedAutoScroll) [self timerFire];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        [self adjustADPosition];
        if (self.isNeedAutoScroll) [self timerFire];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self adjustADPosition];
}

//#pragma mark - Lazy Load
//- (NSTimer *)timer {
//    if (!_timer) {
//        _timer = [NSTimer scheduledTimerWithTimeInterval:self.timeInterval target:self selector:@selector(timerChange) userInfo:nil repeats:YES];
//        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
//    }
//    return _timer;
//}

//#pragma mark - Override
//- (void)removeFromSuperview {
//    [super removeFromSuperview];
//}

#pragma mark - Setter And Getter
- (OTAutoScrollViewStyleConfig *)styleConfig {
    return _style;
}

- (void)setIsPanGestureRecognizer:(BOOL)isPanGestureRecognizer {
    _cvAutoScroll.scrollEnabled = isPanGestureRecognizer;
}

#pragma mark - Dealloc
- (void)dealloc {
    [self timerInvalidateAndSetNil];
    AMLog(@"<< dealloc >>");
}

@end
