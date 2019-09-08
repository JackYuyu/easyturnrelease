//
//  ETNametitleViewController.h
//  EasyTurn
//
//  Created by 王翔 on 2019/8/5.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import "ACViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ETNametitleViewController : ACViewController
@property(nonatomic,copy) void (^block)(NSString* name);
@end

NS_ASSUME_NONNULL_END
