//
//  ETBuyPushViewController.h
//  EasyTurn
//
//  Created by 王翔 on 2019/7/31.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ETProductModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ETBuyPushViewController : UIViewController
@property (nonatomic, copy) NSString *releaseId;
@property (nonatomic, strong) ETProductModel *product;
@end

NS_ASSUME_NONNULL_END
