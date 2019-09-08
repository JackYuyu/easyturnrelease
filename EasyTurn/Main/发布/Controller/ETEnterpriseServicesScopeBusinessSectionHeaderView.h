//
//  ETEnterpriseServicesScopeBusinessSectionHeaderView.h
//  EasyTurn
//
//  Created by 程立 on 2019/9/8.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ETEnterpriseServicesScopeBusinessSectionHeaderViewDelegate;
@class ETEnterpriseServicesBusinessScopeModel;
@interface ETEnterpriseServicesScopeBusinessSectionHeaderView : UITableViewHeaderFooterView
@property (nonatomic, weak) id<ETEnterpriseServicesScopeBusinessSectionHeaderViewDelegate> delegate;
- (void)makeETEnterpriseServicesScopeBusinessSectionHeaderViewWithModel:(ETEnterpriseServicesBusinessScopeModel *)mItem section:(NSInteger)section;
@end

@protocol ETEnterpriseServicesScopeBusinessSectionHeaderViewDelegate <NSObject>

- (void)enterpriseServicesScopeBusinessSectionHeaderView:(UITableViewHeaderFooterView *)enterpriseServicesScopeBusinessSectionHeaderView model:(ETEnterpriseServicesBusinessScopeModel *)mItem section:(NSInteger)section;

@end

NS_ASSUME_NONNULL_END
