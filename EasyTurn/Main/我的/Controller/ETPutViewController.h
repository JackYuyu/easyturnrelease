//
//  ETPutViewController.h
//  EasyTurn
//
//  Created by 王翔 on 2019/7/20.
//  Copyright © 2019年 EasyTurn. All rights reserved.
//

#import "ACViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ETPutViewController : ACViewController
@property(nonatomic,strong) void(^block)(void);
@end

NS_ASSUME_NONNULL_END
