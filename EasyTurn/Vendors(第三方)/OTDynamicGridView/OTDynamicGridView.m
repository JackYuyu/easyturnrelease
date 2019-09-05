//
//  OTDynamicGridView.m
//  AutoTraderCloud
//
//  Created by OUT MAN on 2017/10/19.
//  Copyright © 2017年 AutoHome. All rights reserved.
//

#import "OTDynamicGridView.h"

@interface OTDynamicGridView () <UICollectionViewDataSource, UICollectionViewDelegate> {
    UICollectionView *_cvDynamicGrid;
    OTDynamicGridViewStyleConfig *_styleConfig;
    NSInteger _cacheRows;
}

@end

@implementation OTDynamicGridView

- (instancetype)initWithDynamicGridViewStyleConfig:(OTDynamicGridViewStyleConfig *)styleConfig {
    self = [super init];
    if (self) {
        _styleConfig = styleConfig;
        _cacheRows = 0;
        [self createSubViewsAndConstraints];
    }
    return self;
}

- (void)createSubViewsAndConstraints {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat itemW = (Screen_Width - _styleConfig.leading - _styleConfig.trailing - (_styleConfig.cols - 1) * _styleConfig.colSpace) / _styleConfig.cols;
    layout.itemSize = CGSizeMake(itemW, _styleConfig.itemH);
    layout.minimumLineSpacing = _styleConfig.rowSpace;
    layout.minimumInteritemSpacing = _styleConfig.colSpace;
    layout.sectionInset = UIEdgeInsetsMake(_styleConfig.top, _styleConfig.leading, _styleConfig.bottom, _styleConfig.trailing);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.headerReferenceSize = CGSizeMake(Screen_Width, _styleConfig.headerHeight);
    layout.footerReferenceSize = CGSizeMake(Screen_Width, _styleConfig.footerHeight);
    
    _cvDynamicGrid = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _cvDynamicGrid.backgroundColor = kACColorClear;
    _cvDynamicGrid.pagingEnabled = NO;
    _cvDynamicGrid.scrollsToTop = YES;
    _cvDynamicGrid.bounces = NO;
    _cvDynamicGrid.scrollEnabled = NO;
    _cvDynamicGrid.showsVerticalScrollIndicator = NO;
    _cvDynamicGrid.showsHorizontalScrollIndicator = NO;
    _cvDynamicGrid.dataSource = self;
    _cvDynamicGrid.delegate = self;
    [self addSubview:_cvDynamicGrid];
    [_cvDynamicGrid mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}

#pragma mark - Public API
- (void)reloadData {
    [_cvDynamicGrid reloadData];
}

- (void)registerCellClass:(Class)cellClass forCellWithReuseIdentifier:(NSString *)identifier {
    [_cvDynamicGrid registerClass:cellClass forCellWithReuseIdentifier:identifier];
}

- (void)registerClass:(Class)viewClass forSupplementaryViewOfKind:(NSString *)elementKind withReuseIdentifier:(NSString *)identifier {
    [_cvDynamicGrid registerClass:viewClass forSupplementaryViewOfKind:elementKind withReuseIdentifier:identifier];
}

- (UICollectionViewCell *)dequeueReusableCellWithReuseIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath {
    return [_cvDynamicGrid dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
}

- (UICollectionReusableView *)dequeueReusableSupplementaryViewOfKind:(NSString *)elementKind withReuseIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath {
    return [_cvDynamicGrid dequeueReusableSupplementaryViewOfKind:elementKind withReuseIdentifier:identifier forIndexPath:indexPath];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if ([_dataSource respondsToSelector:@selector(dynamicGridView:numberOfItemsInSection:)]) {
        NSInteger itemCount = [_dataSource dynamicGridView:self numberOfItemsInSection:section];
        
        if ([_dataSource respondsToSelector:@selector(dynamicGridView:necessaryHeight:)]) {
            NSInteger rows = itemCount / _styleConfig.cols + (itemCount % _styleConfig.cols ? 1 : 0);
            
            if (_cacheRows != rows) {
                _cacheRows = rows;
                
                CGFloat necessaryHeight = 0.f;
                
                if (rows == 0) {
                    necessaryHeight = _styleConfig.top + _styleConfig.bottom + rows * _styleConfig.itemH + (_styleConfig.headerHeight ? _styleConfig.headerHeight : 0) + (_styleConfig.footerHeight ? _styleConfig.footerHeight : 0);
                } else {
                    necessaryHeight = _styleConfig.top + _styleConfig.bottom + rows * _styleConfig.itemH + (rows - 1) * _styleConfig.rowSpace + (_styleConfig.headerHeight ? _styleConfig.headerHeight : 0) + (_styleConfig.footerHeight ? _styleConfig.footerHeight : 0);
                }
                
                [_dataSource dynamicGridView:self necessaryHeight:necessaryHeight];
            }
        }
        return itemCount;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([_dataSource respondsToSelector:@selector(dynamicGridView:cellForItemAtIndexPath:)]) {
        return [_dataSource dynamicGridView:self cellForItemAtIndexPath:indexPath];
    }
    return nil;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([_dataSource respondsToSelector:@selector(dynamicGridView:viewForSupplementaryElementOfKind:atIndexPath:)]) {
        return [_dataSource dynamicGridView:self viewForSupplementaryElementOfKind:kind atIndexPath:indexPath];
    }
    return nil;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:NO];
    if ([_delegate respondsToSelector:@selector(dynamicGridView:didSelectItemAtIndexPath:)]) {
        [_delegate dynamicGridView:self didSelectItemAtIndexPath:indexPath];
    }
}

@end
