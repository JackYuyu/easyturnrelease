//
//  ETPublishPurchaseSegmentViewController.h
//  EasyTurn
//
//  Created by 程立 on 2019/9/8.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import "ACViewController.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^dismissBlock) (void);

@interface ETPublishPurchaseSegmentViewController : ACViewController
@property (nonatomic, copy) dismissBlock mDismissBlock;

-(void)toDissmissSelf:(dismissBlock)block;

@end

NS_ASSUME_NONNULL_END
