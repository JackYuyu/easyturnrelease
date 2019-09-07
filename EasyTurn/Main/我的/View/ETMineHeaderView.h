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
@end

@interface ETMineHeaderView : UIView
- (void)makeMineHeaderViewWithETMineViewModel:(ETMineViewModel *)model;
@property (nonatomic, weak) id<ETMineHeaderViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
