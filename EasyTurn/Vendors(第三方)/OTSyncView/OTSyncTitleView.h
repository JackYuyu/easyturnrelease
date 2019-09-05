//
//  OTSyncTitleView.h
//  81-SyncView
//
//  Created by OUT MAN on 2017/9/15.
//  Copyright © 2017年 OUT MAN. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OTSyncViewStyleConfig;
@protocol OTSyncTitleViewDelegate;
@interface OTSyncTitleView : UIView

@property (nonatomic, weak) id<OTSyncTitleViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray<NSString *> *)arrTitles styleConfig:(OTSyncViewStyleConfig *)styleConfig;
- (void)resetTitlesWithTitles:(NSArray<NSString *> *)arrTitles;
- (void)resetTitlesWithTitles:(NSArray<NSString *> *)arrTitles styleConfig:(OTSyncViewStyleConfig *)styleConfig;
- (void)selectTitleWithIndex:(NSInteger)index;
- (void)selectTitleWithIndex:(NSInteger)index animated:(BOOL)animated;
//- (void)handleTitleColorGradualChangeWithSourceIndex:(NSInteger)sourceIndex targetIndex:(NSInteger)targetIndex progress:(CGFloat)progress;

@end

@protocol OTSyncTitleViewDelegate <NSObject>

- (void)syncTitleView:(OTSyncTitleView *)vSyncTitle selectedTitle:(NSString *)title selectedIndex:(NSInteger)index;

@end
