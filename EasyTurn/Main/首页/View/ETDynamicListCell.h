//
//  ETDynamicListCell.h
//  EasyTurn
//
//  Created by 刘盖 on 2019/8/7.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ETDynamicListCell : UITableViewCell
+ (CGFloat)cellHeight;
+ (instancetype)dynamicListCell:(UITableView *)tableView dict:(NSDictionary *)dict;
@property (nonatomic,strong) UILabel *labelDesc;
@property (nonatomic,strong) UILabel *labelPrice;
@end

NS_ASSUME_NONNULL_END
