//
//  ETForBuyDetailController.h
//  EasyTurn
//
//  Created by 刘盖 on 2019/9/5.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import "ACViewController.h"
#import "ETProductModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ETForBuyDetailController : ACViewController
@property (nonatomic, strong) ETProductModel *product;
@property (nonatomic, copy) NSString *releaseId;

+ (instancetype)forBuyDetailController:(NSDictionary *)detailInfo;
@end

NS_ASSUME_NONNULL_END
