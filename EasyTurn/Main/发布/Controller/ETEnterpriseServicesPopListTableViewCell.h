//
//  ETEnterpriseServicesPopListTableViewCell.h
//  EasyTurn
//
//  Created by 程立 on 2019/9/7.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol ETEnterpriseServicesPopListTableViewCellDelegate;
@class ETEnterpriseServicesViewItemModel;
@interface ETEnterpriseServicesPopListTableViewCell : UITableViewCell
@property (nonatomic, weak) id<ETEnterpriseServicesPopListTableViewCellDelegate> delegate;
- (void)makeETEnterpriseServicesPopListTableViewCellWithModel:(ETEnterpriseServicesViewItemModel *)mItem;
@end

@protocol ETEnterpriseServicesPopListTableViewCellDelegate <NSObject>

- (void)enterpriseServicesPopListTableViewCell:(ETEnterpriseServicesPopListTableViewCell *)enterpriseServicesPopListTableViewCell selectPopViewListWithModel:(ETEnterpriseServicesViewItemModel *)mItem;

@end

NS_ASSUME_NONNULL_END
