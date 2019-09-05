//
//  OTSyncContainerView.h
//  81-SyncView
//
//  Created by OUT MAN on 2017/9/15.
//  Copyright © 2017年 OUT MAN. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OTSyncContainerViewDelegate;
@interface OTSyncContainerView : UIView

@property (nonatomic, weak) id<OTSyncContainerViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame childViewControllers:(NSArray<UIViewController *> *)arrChildVCs parentViewController:(UIViewController *)parentVC;
- (void)scrollToItem:(NSInteger)item;

@end

@protocol OTSyncContainerViewDelegate <NSObject>

- (void)syncContainerView:(OTSyncContainerView *)vSyncContainer scrollToItem:(NSInteger)item;
//- (void)syncContainerView:(OTSyncContainerView *)vSyncContainer sourceItem:(NSInteger)sourceItem targetItem:(NSInteger)targetItem progress:(CGFloat)progress;

@end
