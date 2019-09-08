//
//  ETPayaymentViewController.h
//  EasyTurn
//
//  Created by 王翔 on 2019/7/31.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import "ACViewController.h"
#import "ETProductModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ETPayaymentViewController :ACViewController
@property (nonatomic, copy) NSString *releaseId;
@property (nonatomic, strong) ETProductModel *product;
@property (nonatomic, copy) NSString *finalPrice;

@end

NS_ASSUME_NONNULL_END
