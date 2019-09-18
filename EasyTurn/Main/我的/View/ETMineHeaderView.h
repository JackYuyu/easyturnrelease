//
//  ETMineHeaderView.h
//  EasyTurn
//
//  Created by 王翔 on 2019/9/2.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ETMineViewModel;
NS_ASSUME_NONNULL_BEGIN
@protocol ETMineHeaderViewDelegate <NSObject>

- (void)eTMineHeaderviewDidSelectItemAtIndexPath:(NSIndexPath *)indexPath;
- (void)eTMineHeaderviewOnClickHeaderEdit;
- (void)eTMineHeaderviewOnClickPayVip;
- (void)eTMineHeaderviewOnClickPayRefreshCount;
@end

@interface ETMineHeaderView : UIView
- (void)makeMineHeaderViewWithETMineViewModel:(ETMineViewModel *)model;
@property (nonatomic, weak) id<ETMineHeaderViewDelegate> delegate;
@property (nonatomic, strong) UIImageView *imagevUserType;

@end

NS_ASSUME_NONNULL_END
