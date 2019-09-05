//
//  ETMeinDynamicListCell.h
//  EasyTurn
//
//  Created by 王翔 on 2019/8/25.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ETMeinDynamicListCell : UITableViewCell
+ (CGFloat)cellHeight;
+ (instancetype)dynamicListCell:(UITableView *)tableView dict:(NSDictionary *)dict;
@property (nonatomic,strong) UILabel *labelDesc;
@property (nonatomic,strong) UILabel *labelPrice;
@property (nonatomic,strong) UILabel *labelTag;
@end

NS_ASSUME_NONNULL_END
