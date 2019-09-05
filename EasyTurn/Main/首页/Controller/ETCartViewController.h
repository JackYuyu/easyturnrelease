//
//  ETPurchaseViewController.h
//  EasyTurn
//
//  Created by 王翔 on 2019/8/17.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ETProductModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ETCartViewController : UIViewController
@property (nonatomic, strong) ETProductModel *product;
@property (nonatomic, copy) NSString *releaseId;

@end

NS_ASSUME_NONNULL_END
