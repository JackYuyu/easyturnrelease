//
//  ETPaymentStagesVC.h
//  EasyTurn
//
//  Created by 刘盖 on 2019/8/5.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ETProductModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ETPaymentStagesCartVC : UIViewController

@property (nonatomic, copy) NSString *releaseId;
@property (nonatomic, strong) ETProductModel *product;
@property (nonatomic, copy) NSString *finalPrice;
@property (nonatomic, copy) NSString *releaseOrderId;

+ (instancetype)paymentStagesCartVC:(NSInteger)stagesCount;
@end

NS_ASSUME_NONNULL_END
