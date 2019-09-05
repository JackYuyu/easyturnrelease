//
//  OTSyncView.h
//  81-SyncView
//
//  Created by OUT MAN on 2017/9/15.
//  Copyright © 2017年 OUT MAN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OTSyncTitleView.h"
#import "OTSyncContainerView.h"
#import "OTSyncViewStyleConfig.h"

@protocol OTSyncViewDelegate;
@interface OTSyncView : UIView

@property (nonatomic, weak) id<OTSyncViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray<NSString *> *)arrTitles childViewControllers:(NSArray<UIViewController *> *)arrChildVCs parentViewController:(UIViewController *)parentVC styleConfig:(OTSyncViewStyleConfig *)styleConfig;
- (void)titleScrollToIndexController:(NSUInteger)index;
@end

@protocol OTSyncViewDelegate <NSObject>

- (void)syncView:(OTSyncView *)vSync scrollToIndex:(NSInteger)index title:(NSString  *)title childViewController:(UIViewController *)vcChild;

@end
