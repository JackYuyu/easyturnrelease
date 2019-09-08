//
//  ETEnterpriseServicesScopeBusinessTableViewCell.h
//  EasyTurn
//
//  Created by 程立 on 2019/9/7.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ETEnterpriseServicesScopeBusinessTableViewCellDelegate;
@class ETEnterpriseServicesViewItemModel;
@interface ETEnterpriseServicesScopeBusinessTableViewCell : UITableViewCell
@property (nonatomic, weak) id<ETEnterpriseServicesScopeBusinessTableViewCellDelegate> delegate;
- (void)makeETEnterpriseServicesScopeBusinessTableViewCell:(ETEnterpriseServicesViewItemModel *)mItem indexPath:(NSIndexPath *)indexPath;
@end

@protocol ETEnterpriseServicesScopeBusinessTableViewCellDelegate <NSObject>

- (void)enterpriseServicesScopeBusinessTableViewCell:(ETEnterpriseServicesScopeBusinessTableViewCell *)enterpriseServicesScopeBusinessTableViewCell model:(ETEnterpriseServicesViewItemModel *)mItem indexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
