//
//  ETMineListViewController.h
//  EasyTurn
//
//  Created by 王翔 on 2019/9/3.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import "ACViewController.h"
#import "JXPagerView.h"
NS_ASSUME_NONNULL_BEGIN
@class UserInfosReleaseModel;
@class ETMineListViewController;
@protocol ETMineListViewControllerDelegate <NSObject>
- (void)eTMineListViewController:(ETMineListViewController *)vc WithButtonType:(UIButton *)sender WithReleaseId:(NSString *)releaseId;
@end
@interface ETMineListViewController : ACViewController <JXPagerViewListViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) NSInteger releaseTypeId;
@property (nonatomic, strong) NSArray <UserInfosReleaseModel *> *arrDataSource;
@property (nonatomic, weak) id<ETMineListViewControllerDelegate> delegate;
@property (nonatomic, strong) UINavigationController *naviController;
@end

NS_ASSUME_NONNULL_END
