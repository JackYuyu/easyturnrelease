//
//  ETPublishPurchaseViewController.h
//  EasyTurn
//
//  Created by 王翔 on 2019/7/30.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import "ACViewController.h"
#import "ETProductModel.h"

NS_ASSUME_NONNULL_BEGIN

//2.block传值  typedef void(^returnBlock)();
typedef void(^dismissBlock) (void);

@interface ETPublishPurchaseViewController : ACViewController
@property (nonatomic, strong) ETProductModel *product;


//block
//block声明属性
@property (nonatomic, copy) dismissBlock mDismissBlock;
//block声明方法
-(void)toDissmissSelf:(dismissBlock)block;

@end

NS_ASSUME_NONNULL_END
