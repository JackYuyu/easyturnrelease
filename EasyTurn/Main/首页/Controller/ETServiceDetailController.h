//
//  ETServiceDetailController.h
//  EasyTurn
//
//  Created by 刘盖 on 2019/8/29.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import "ACViewController.h"
#import "ETProductModel.h"

NS_ASSUME_NONNULL_BEGIN
#pragma mark 服务详情
@interface ETServiceDetailController : ACViewController
@property (nonatomic, strong) ETProductModel *product;

+ (instancetype)serviceDetailController:(NSDictionary *)detailInfo;
@end

NS_ASSUME_NONNULL_END
