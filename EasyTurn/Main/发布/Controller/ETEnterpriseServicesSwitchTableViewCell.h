//
//  ETEnterpriseServicesSwitchTableViewCell.h
//  EasyTurn
//
//  Created by 程立 on 2019/9/7.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ETEnterpriseServicesViewItemModel;
@interface ETEnterpriseServicesSwitchTableViewCell : UITableViewCell
- (void)makeETEnterpriseServicesSwitchTableViewCellWithModel:(ETEnterpriseServicesViewItemModel *)mItem;
@end

NS_ASSUME_NONNULL_END
