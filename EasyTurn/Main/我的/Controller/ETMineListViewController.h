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
@interface ETMineListViewController : ACViewController <JXPagerViewListViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) NSInteger releaseTypeId;
@property (nonatomic, strong) NSArray <UserInfosReleaseModel *> *arrDataSource;
@end

NS_ASSUME_NONNULL_END
