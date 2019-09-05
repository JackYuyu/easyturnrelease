//
//  ETBindViewController.h
//  EasyTurn
//
//  Created by 王翔 on 2019/8/9.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ETBindViewController : UIViewController
@property (nonatomic,copy) void (^block)(NSString* account,NSString* name);
@end

NS_ASSUME_NONNULL_END
