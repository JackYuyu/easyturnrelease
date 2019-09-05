//
//  ETHomeHeaderView1.h
//  EasyTurn
//
//  Created by 程立 on 2019/7/27.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol ETHomeHeaderViewDelegate <NSObject>

- (void)homeHeaderViewPushSearch;

- (void)slideshowHeadViewDidSelectItemAtIndex:(NSInteger)index;

@end

@interface ETHomeHeaderView1 : UIView
///轮播图数组
@property (nonatomic, strong) NSArray *imageGroupArray;
@property (nonatomic, weak) id<ETHomeHeaderViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
