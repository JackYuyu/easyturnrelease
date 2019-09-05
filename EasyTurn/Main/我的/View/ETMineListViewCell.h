//
//  ETMineListViewCell.h
//  EasyTurn
//
//  Created by 王翔 on 2019/9/3.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UserInfosReleaseModel;
NS_ASSUME_NONNULL_BEGIN
@protocol ETMineListViewCellDelegate <NSObject>

- (void)onCLickETMineListViewCellButtonType:(UIButton *)sender;

@end
@interface ETMineListViewCell : UITableViewCell
- (void)makeCellWithUserInfosReleaseModel:(UserInfosReleaseModel *)model indexPath:(NSIndexPath *)indexPath;
@property (nonatomic, weak) id<ETMineListViewCellDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
