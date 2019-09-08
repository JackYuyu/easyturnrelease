//
//  ETEnterpriseServicesScopeBusinessItemTableViewCell.h
//  EasyTurn
//
//  Created by 程立 on 2019/9/8.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ETEnterpriseServicesScopeBusinessItemTableViewCellDelegate;
@class ETEnterpriseServicesBusinessScopeModel;
@interface ETEnterpriseServicesScopeBusinessItemTableViewCell : UITableViewCell
@property (nonatomic, weak) id<ETEnterpriseServicesScopeBusinessItemTableViewCellDelegate> delegate;
- (void)makeETEnterpriseServicesScopeBusinessItemTableViewCellWithModel:(ETEnterpriseServicesBusinessScopeModel *)mItem;
@end

@protocol ETEnterpriseServicesScopeBusinessItemTableViewCellDelegate <NSObject>

- (void)enterpriseServicesScopeBusinessItemTableViewCell:(ETEnterpriseServicesScopeBusinessItemTableViewCell *)enterpriseServicesScopeBusinessItemTableViewCell model:(ETEnterpriseServicesBusinessScopeModel *)mItem;

@end

NS_ASSUME_NONNULL_END
