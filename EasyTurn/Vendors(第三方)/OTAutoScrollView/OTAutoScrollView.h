//
//  OTAutoScrollView.h
//  AutoTraderCloud
//
//  Created by OUT MAN on 2017/10/16.
//  Copyright © 2017年 AutoHome. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OTAutoScrollViewStyleConfig.h"
NS_ASSUME_NONNULL_BEGIN

@protocol OTAutoScrollViewDataSource;
@protocol OTAutoScrollViewDelegate;
@interface OTAutoScrollView : UIView

@property (nonatomic, weak) id<OTAutoScrollViewDataSource> dataSource;
@property (nonatomic, weak) id<OTAutoScrollViewDelegate> delegate;
/**
 * 默认开启自动滚动
 */
@property (nonatomic, assign) BOOL isNeedAutoScroll;
/**
 * 是否支持手动滚动，默认YES
 */
@property (nonatomic, assign) BOOL isPanGestureRecognizer;
/**
 * 默认值 2s
 */
@property (nonatomic, assign) NSTimeInterval timeInterval;
/**
 * 当前 AutoScrollView 的样式
 */
@property (nonatomic, strong, readonly) OTAutoScrollViewStyleConfig *styleConfig;

- (instancetype)initWithFrame:(CGRect)frame style:(OTAutoScrollViewStyleConfig *)style;
- (void)registerClass:(Class)cellClass forCellWithReuseIdentifier:(NSString *)identifier;
- (UICollectionViewCell *)dequeueReusableCellWithReuseIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath;
- (void)reloadData;
- (void)reloadDataWithStyleConfig:(OTAutoScrollViewStyleConfig *)styleConfig animated:(BOOL)animated completion:(void (^)(BOOL finished))completion;

@end

@protocol OTAutoScrollViewDataSource <NSObject>

@required
- (NSInteger)autoScrollView:(OTAutoScrollView *)vAutoScroll numberOfItemsInSection:(NSInteger)section;
- (UICollectionViewCell *)autoScrollView:(OTAutoScrollView *)vAutoScroll cellForItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@protocol OTAutoScrollViewDelegate <NSObject>

@optional
- (void)autoScrollView:(OTAutoScrollView *)vAutoScroll didSelectItemAtIndexPath:(NSIndexPath *)indexPath;

@end
NS_ASSUME_NONNULL_END
