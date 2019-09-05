//
//  OTDynamicGridView.h
//  AutoTraderCloud
//
//  Created by OUT MAN on 2017/10/19.
//  Copyright © 2017年 AutoHome. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "OTDynamicGridViewStyleConfig.h"

@protocol OTDynamicGridViewDataSource;
@protocol OTDynamicGridViewDelegate;
@interface OTDynamicGridView : UIView

@property (nonatomic, weak) id<OTDynamicGridViewDataSource> dataSource;
@property (nonatomic, weak) id<OTDynamicGridViewDelegate> delegate;

- (instancetype)initWithDynamicGridViewStyleConfig:(OTDynamicGridViewStyleConfig *)styleConfig;

- (void)reloadData;
- (void)registerCellClass:(Class)cellClass forCellWithReuseIdentifier:(NSString *)identifier;
- (void)registerClass:(Class)viewClass forSupplementaryViewOfKind:(NSString *)elementKind withReuseIdentifier:(NSString *)identifier;
- (UICollectionViewCell *)dequeueReusableCellWithReuseIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath;
- (UICollectionReusableView *)dequeueReusableSupplementaryViewOfKind:(NSString *)elementKind withReuseIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath;

@end

@protocol OTDynamicGridViewDataSource <NSObject>

@required
- (NSInteger)dynamicGridView:(OTDynamicGridView *)vDynamicGrid numberOfItemsInSection:(NSInteger)section;
- (UICollectionViewCell *)dynamicGridView:(OTDynamicGridView *)vDynamicGrid cellForItemAtIndexPath:(NSIndexPath *)indexPath;
@optional
- (void)dynamicGridView:(OTDynamicGridView *)vDynamicGrid necessaryHeight:(CGFloat)necessaryHeight;
- (UICollectionReusableView *)dynamicGridView:(OTDynamicGridView *)vDynamicGrid viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath;

@end

@protocol OTDynamicGridViewDelegate <NSObject>

@optional
- (void)dynamicGridView:(OTDynamicGridView *)vDynamicGrid didSelectItemAtIndexPath:(NSIndexPath *)indexPath;

@end
