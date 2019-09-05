//
//  ETSaleDetailHeaderView.h
//  EasyTurn
//
//  Created by 刘盖 on 2019/8/29.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ETSaleDetailHeaderView : UIView
@property (nonatomic,assign) BOOL service;
+ (instancetype)saleDetailHeaderView:(NSDictionary *)dict click:(void (^)(void))clickBlock;
+ (instancetype)serviceDetailHeaderView:(NSDictionary *)dict click:(void (^)(void))clickBlock;
+ (instancetype)forBuyDetailHeaderView:(NSDictionary *)dict click:(void (^)(void))clickBlock;

@end

@interface ETSaleDetailBotToolView : UIView
@property (nonatomic,strong) void (^blockvip)(void);
+ (instancetype)detailBotToolView:(void (^)(NSInteger clickTag))clickBlock;
- (void)refreshIsCollected:(BOOL)isCollected;
@end


@interface ETSaleAndServiceDetailCell : UITableViewCell


+ (instancetype)saleAndServiceDetailCell:(UITableView *)tableView model:(NSDictionary *)dict;
+ (CGFloat)cellHeight;
+ (CGFloat)cellHeightLines:(NSString *)string;
@end

NS_ASSUME_NONNULL_END
