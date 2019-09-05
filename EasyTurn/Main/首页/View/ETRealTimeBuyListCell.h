//
//  ETRealTimeBuyListCell.h
//  EasyTurn
//
//  Created by 刘盖 on 2019/8/8.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ETRealTimeBuyListCell : UITableViewCell

+ (CGFloat)cellHeight;
+ (instancetype)realTimeBuyListCell:(UITableView *)tableView dict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
